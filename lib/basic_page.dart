import 'package:flutter/material.dart';
import 'recipes/recipes.dart';
import 'add_new.dart';
import 'package:flutterfire_ui/auth.dart';

class BasicPage extends StatefulWidget {
  final String uid;
  final int pageIndex;
  const BasicPage( {super.key, required this.uid, required this.pageIndex} );

  @override
  State<BasicPage> createState() => _BasicPageState();
}


class _BasicPageState extends State<BasicPage> {
  late int currentPageIndex = widget.pageIndex;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        /*
        leading: (currentPageIndex == 1) ? null : IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).maybePop();
            },
          ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Search Pressed')));
            },
          ),
        ], */
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined), 
            label: 'Recipes',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box_outlined), 
            label: 'Add New',
          ),
        ]
      ),
      body: <Widget>[
        ProfileScreen(),
        RecipePage(uid: widget.uid),
        AddNewPage(uid: widget.uid),
      ][currentPageIndex],
    );
  }
}

