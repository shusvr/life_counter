import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'items.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
  final Function(Item) onColorSelected;
  SettingsPage({required this.onColorSelected});
}

class _SettingsPageState extends State<SettingsPage> {
  Color currentColor = Colors.blue;

  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  String colorToHex(Color color) {
    String hexRaw =  '#${color.value.toRadixString(16).padLeft(8, '0')}';
    String hexColor = hexRaw.replaceAll('#ff', '0xff');
    return hexColor;
  }

  AlertDialog pickColorForPlayer(BuildContext context, int playerId){
    return AlertDialog(
      title: Text('Pick a color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: currentColor,
          onColorChanged: changeColor,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
            child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Select'),
          onPressed: () {
            Item newItem = Item(
              colorHex: colorToHex(currentColor),
              counter: 40,
              id: playerId,
            );
            widget.onColorSelected(newItem);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: ElevatedButton(
          child: Text('Change color'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Pick a player'),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text('Player 1'),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return pickColorForPlayer(context, 0);
                            },
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text('Player 2'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return pickColorForPlayer(context, 1);
                          },
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text('Player 3'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return pickColorForPlayer(context, 2);
                          },
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text('Player 4'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return pickColorForPlayer(context, 3);
                          },
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}