import 'package:flutter/material.dart';
import 'package:pantry/recipes/edit_recipes.dart';

class EpandedRecipePage extends StatelessWidget {
  final String uid;
  final String documentID;
  final String name;
  final String image;
  final String servings;
  final String time;
  final String difficulty;
  final String from;
  final String ingredients;
  final String directions;
  
  const EpandedRecipePage({super.key, required this.uid, required this.documentID, required this.name, required this.image, required this.servings, required this.difficulty, required this.time, required this.from, required this.directions, required this.ingredients});

  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double c_width = MediaQuery.of(context).size.width - 80;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).maybePop();
            },
          ),
      ),
      body: SingleChildScrollView(
              scrollDirection:Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/$image', width: 100,),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(name, style: theme.textTheme.displayMedium, textAlign: TextAlign.left, softWrap: true,)
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditRecipe(
                                    uid: uid,
                                    documentID: documentID,
                                    name: name,
                                    image: image,
                                    servings: servings,
                                    time: time,
                                    difficulty: difficulty,
                                    from: from,
                                    ingredients: ingredients,
                                    directions: directions,
                                  )));
                              }, 
                              icon: const Icon(Icons.edit),
                            )
                          ],
                        ),
                      ),
                      Text('Servings: $servings    Time: $time    Difficulty: $difficulty', style: theme.textTheme.bodySmall,),
                      Text(from, style: theme.textTheme.bodySmall,),

                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 10),
                        child: Text("Ingredients", style: theme.textTheme.headlineMedium),
                      ),

                      Text(ingredients, textAlign: TextAlign.left,softWrap: true, style: const TextStyle(height: 2),),

                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 10),
                        child: Text("Directions", style: theme.textTheme.headlineMedium),
                      ),
                      Text(directions, textAlign: TextAlign.left,softWrap: true, style: const TextStyle(height: 2),),

                      const SizedBox(height: 50,),
                    ],
                  ),
              ),
            )
    );
  }

}