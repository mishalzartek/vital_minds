import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class InfoDialog extends StatefulWidget {
  final int type;
  const InfoDialog({Key key, @required this.type}) : super(key: key);

  @override
  _InfoDialogState createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {

  @override
  Widget build(BuildContext context) {
        return GestureDetector(
            onTap: () {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    animType: AnimType.SCALE,
                    width: 400,
                    padding: EdgeInsets.all(10),
                    headerAnimationLoop: false,
                    buttonsBorderRadius: BorderRadius.circular(10),
                    body: Column(
                      children: [
                        Center(
                          child: Text(
                              'INFO',
                            textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal : 10.0),
                          child: Text(widget.type == 1
                              ? 'Tap to edit entries and swipe to delete them'
                              : widget.type == 2
                                  ? 'Tap on a section to add/edit entries'
                                  : widget.type == 3
                                      ? 'Slide to delete entries'
                                      : widget.type == 4
                                          ? "1) Reminders don't appear the next day even if it's not ticked off. We also send notifications for reminders if you allow us to.\n\n2)Slide to edit/delete a reminder"
                                          : widget.type == 5
                                              ? "1) Activities in the todo list will continue to appear until it is ticked off.\n\n2)Slide to edit/delete a todo entry"
                                              : 'Slide to edit/delete entries',
                            style: TextStyle(
                              fontStyle: FontStyle.italic
                            ),
                            softWrap: true,
                          ),

                        ),
                      ],
                    ),
                    btnOkOnPress: () {
                    })
                  ..show();
            },
            child: Icon(
              Icons.info,
              color: Colors.white,
            ));
  }
}
