import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pantry/recipes/icon_modal.dart';
import 'basic_page.dart';

class AddNewPage extends StatefulWidget {
  final String uid;
  AddNewPage({super.key, required this.uid});

@override
  State<AddNewPage> createState() => _AddNewPageState();
}


class _AddNewPageState extends State<AddNewPage> {
  String name = "Untitled";
  String image = 'cake.png';
  String servings = '--';
  String time = '--';
  String from = '';
  String difficulty = '--';
  String ingredients = "none";
  String directions = "none";
  
  final GlobalKey<FormState> _addNewKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final servingsController = TextEditingController();
  final difficultyController = TextEditingController();
  final timeController = TextEditingController();
  final fromController = TextEditingController();
  final ingredientsController = TextEditingController();
  final directionsController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    servingsController.dispose();
    difficultyController.dispose();
    timeController.dispose();
    fromController.dispose();
    ingredientsController.dispose();
    directionsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("assets/$image", width: 100,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context, 
                              builder: (BuildContext context) {
                                return IconModal(uid: widget.uid);
                              }
                            ).then((value) {
                              setState(() {
                                image = value;
                              });
                            });
                          }, 
                          child: const Text("Change Icon"),
                          ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Form(
                      key: _addNewKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Recipe Name',
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a name';
                                }
                                return null;
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: servingsController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Servings',
                                    ),
                                    validator: (String? value) {return null;},
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Flexible(
                                  child: TextFormField(
                                    controller: difficultyController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Difficulty',
                                    ),
                                    validator: (String? value) {return null;},
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              controller: timeController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Time',
                              ),
                              validator: (String? value) {
                                return null;
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              controller: fromController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'From',
                              ),
                              validator: (String? value) {
                                return null;
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 40, bottom: 10),
                            child: Text("Ingredients", style: theme.textTheme.headlineMedium),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              controller: ingredientsController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Ingredients',
                              ),
                              validator: (String? value) {
                                return null;
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 40, bottom: 10),
                            child: Text("Directions", style: theme.textTheme.headlineMedium),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              controller: directionsController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Directions',
                              ),
                              validator: (String? value) {
                                return null;
                              },
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: FilledButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_addNewKey.currentState!.validate()) {
                          // Process data.
                          if (nameController.text.isNotEmpty) {name = nameController.text;}
                          if (servingsController.text.isNotEmpty) {servings = servingsController.text;}
                          if (timeController.text.isNotEmpty) {time = timeController.text;}
                          if (fromController.text.isNotEmpty) {from = fromController.text;}
                          if (difficultyController.text.isNotEmpty) {difficulty = difficultyController.text;}
                          if (ingredientsController.text.isNotEmpty) {ingredients = ingredientsController.text;}
                          if (directionsController.text.isNotEmpty) {directions = directionsController.text;}
                          

                          // add to firebase database
                          FirebaseFirestore.instance
                          .collection('users/${widget.uid}/recipes')
                          .add({
                            'name': name, 
                            'image': image,
                            'servings': servings,
                            'difficulty': difficulty,
                            'time': time,
                            'from': from,
                            'ingredients': ingredients,
                            'directions': directions
                            });

                            // navigate to recipes page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BasicPage(uid: widget.uid, pageIndex: 1,))
                            );
                        }
                      },
                      child: const Text('Create Recipe'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
