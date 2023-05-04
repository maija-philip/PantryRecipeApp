import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pantry/basic_page.dart';
import 'dart:developer' as developer;
import 'recipe_card.dart';

class RecipePage extends StatelessWidget {
  final String uid;
  const RecipePage( {super.key, required this.uid} );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
            scrollDirection:Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Your Recipes", style: theme.textTheme.displayMedium, textAlign: TextAlign.left),
                    const SizedBox(height: 20,),
                    LoadRecipes(uid: uid),
            
                    Center(
                      child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: InkWell(
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          style: IconButton.styleFrom(
                            backgroundColor: theme.colorScheme.primaryContainer,
                            foregroundColor: theme.colorScheme.onPrimaryContainer,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BasicPage(uid: uid, pageIndex: 2,))
                            );
                          },
                        ),
                      ),
                                      ),
                    ),
                    
                    
                  ],
                ),
            ),
        );
  }
}

class LoadRecipes extends StatelessWidget {
  final String uid;
  LoadRecipes ({ super.key, required this.uid });
  late final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection("users/$uid/recipes").snapshots();
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<QuerySnapshot>(
      stream: users,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Loading..."));
        }
        final data = snapshot.requireData;
        // user data.docs[index]['name'] in loop thru
        if (data.docs.isEmpty) {
          return const Center(
            child: Text("You have no recipes, add a recipe",),
          );
        }

        return Wrap(
            children: snapshot.data!.docs.map((document) {
              return RecipeCard(
                uid: uid,
                documentID: document.id,
                name: document['name'], 
                image: document['image'],
                servings: document['servings'],
                difficulty: document['difficulty'],
                time: document['time'],
                from: document['from'],
                ingredients: document['ingredients'],
                directions: document['directions'],
                );
            }).toList(),
          );
      });
  }
}

