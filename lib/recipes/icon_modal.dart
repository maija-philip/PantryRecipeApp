import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IconModal extends StatefulWidget {
  final String uid;
  const IconModal({super.key, required this.uid});

  @override
  State<IconModal> createState() => _IconModalState();
}


class _IconModalState extends State<IconModal> {
    List _icons = [];

  @override
  void initState(){
    readJson();
    super.initState();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/image_list.json');
    final data = await json.decode(response);
    setState(() {
      _icons = data["image-list"];
    });
  }

  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double m_height = ((MediaQuery.of(context).size.height)/3)*2;

    return SizedBox(
                height: m_height,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // show icons
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: _buildIconCards()
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }


  List<Widget> _buildIconCards() {
    // create new list of widgets
    List<Widget> iconCards = [];

    // populate with data from _icons
    for (var icon in _icons) {
      iconCards.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkResponse(
            onTap: () => Navigator.pop(context, icon),
            child: SizedBox(
              width: 100,
              child:  Card (
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset("assets/$icon", width: 70,),
                        ),
                      ), 
            ),
          ),
        )
      );
    }

    // return the widget list
    return iconCards;
  }
}
