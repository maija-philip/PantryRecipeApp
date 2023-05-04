import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../basic_page.dart';
import 'icon_modal.dart';

class EditRecipe extends StatefulWidget {
  final String uid;
  final String documentID;
  String name;
  String image;
  String servings;
  String time;
  String from;
  String difficulty;
  String ingredients;
  String directions;
  EditRecipe({super.key, required this.uid, required this.documentID, required this.name, required this.image,  required this.servings, required this.difficulty, required this.time, required this.from, required this.directions, required this.ingredients});
  

@override
  State<EditRecipe> createState() => _EditRecipeState();
}


class _EditRecipeState extends State<EditRecipe> {
  
  final GlobalKey<FormState> _addNewKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final servingsController = TextEditingController();
  final difficultyController = TextEditingController();
  final timeController = TextEditingController();
  final fromController = TextEditingController();
  final ingredientsController = TextEditingController();
  final directionsController = TextEditingController();

  late String iconImage = widget.image;
  
  @override
  void initState() {
    nameController.text = widget.name;
    servingsController.text = widget.servings;
    difficultyController.text = widget.difficulty;
    timeController.text = widget.time;
    fromController.text = widget.from;
    ingredientsController.text = widget.ingredients;
    directionsController.text = widget.directions;
  }

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset("assets/$iconImage", width: 100,),
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
                                    iconImage = value;
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
                        child: Row(
                          children: [
                            FilledButton(
                              onPressed: () {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                if (_addNewKey.currentState!.validate()) {
                                  // Process data.
                                  if (nameController.text.isNotEmpty) {widget.name = nameController.text;}
                                  if (servingsController.text.isNotEmpty) {widget.servings = servingsController.text;}
                                  if (timeController.text.isNotEmpty) {widget.time = timeController.text;}
                                  if (fromController.text.isNotEmpty) {widget.from = fromController.text;}
                                  if (difficultyController.text.isNotEmpty) {widget.difficulty = difficultyController.text;}
                                  if (ingredientsController.text.isNotEmpty) {widget.ingredients = ingredientsController.text;}
                                  if (directionsController.text.isNotEmpty) {widget.directions = directionsController.text;}
                                  if (iconImage != '') {widget.image = iconImage;}
                                  // delete previous entry of recipe
                                  final collection = FirebaseFirestore.instance.collection('users/${widget.uid}/recipes');
                                  collection 
                                      .doc(widget.documentID) // <-- Doc ID to be deleted. 
                                      .delete()
                                      .catchError((error) => developer.log('Delete failed: $error'));

                                  // add to firebase database
                                  FirebaseFirestore.instance
                                  .collection('users/${widget.uid}/recipes')
                                  .add({
                                    'name': widget.name, 
                                    'image': widget.image,
                                    'servings': widget.servings,
                                    'difficulty': widget.difficulty,
                                    'time': widget.time,
                                    'from': widget.from,
                                    'ingredients': widget.ingredients,
                                    'directions': widget.directions
                                    });

                                    // navigate to recipes page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => BasicPage(uid: widget.uid, pageIndex: 1,))
                                    );
                                }
                              },
                              child: const Text('Change Recipe'),
                            ),
                            
                            const SizedBox(width: 15,),

                            OutlinedButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Are you sure you want to delete this recipe?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                         // delete entry of recipe
                                        final collection = FirebaseFirestore.instance.collection('users/${widget.uid}/recipes');
                                        collection 
                                            .doc(widget.documentID) // <-- Doc ID to be deleted. 
                                            .delete()
                                            .catchError((error) => developer.log('Delete failed: $error'));

                                        // navigate to recipes page
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => BasicPage(uid: widget.uid, pageIndex: 1,))
                                        );
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              ), 
                              child: const Text("Delete Recipe")
                            ),

                          ],
                        ),
                      ),

                      const SizedBox(height: 50,),
                    ]
                )
              )
            )
    );
  }
}
