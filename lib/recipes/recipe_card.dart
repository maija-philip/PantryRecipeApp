import 'package:flutter/material.dart';
import 'package:pantry/recipes/recipe_expanded.dart';

class RecipeCard extends StatelessWidget {
  final String uid;
  final String documentID;
  final String name;
  final String image;
  final String servings;
  final String time ;
  final String difficulty;
  final String from;
  final String ingredients;
  final String directions;
  
  const RecipeCard({super.key,required this.uid, required this.documentID, required this.name, required this.image,  required this.servings, required this.difficulty, required this.time, required this.from, required this.directions, required this.ingredients});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkResponse(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EpandedRecipePage(
                                                      uid: uid,
                                                      documentID: documentID,
                                                      name: name,
                                                      image: image,
                                                      servings: servings,
                                                      difficulty: difficulty,
                                                      time: time,
                                                      from: from,
                                                      ingredients: ingredients,
                                                      directions: directions,
                                                      ))
          );
        },
        child: SizedBox(
          width: 100,
          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card (
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset("assets/$image", width: 70,),
                        ),
                      ),
                      Text(name, style: theme.textTheme.labelMedium, textAlign: TextAlign.center,),
                      
                    ],
                  ),
        ),
      ),
    );
  }

}