import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/widgets/dumb_widgets/info_dialog.dart';
import 'package:vitalminds/widgets/smart_widgets/journal/journal_view_model.dart';

class GratefulFor extends StatefulWidget {
  final JournalViewModel viewModel;
  const GratefulFor({
    Key key,
    this.viewModel,
  }) : super(key: key);

  @override
  State<GratefulFor> createState() => _GratefulForState();
}

class _GratefulForState extends State<GratefulFor> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        widget.viewModel.deleteAllEmptyJournalEntries();
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.01),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.1),
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: [
                    Text("Grateful for",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.left),
                    SizedBox(
                      width: 7.0,
                    ),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              InfoDialog(type: 3)
            ],
          ),
          Divider(
            color: Colors.white.withOpacity(0.4),
          ),
          widget.viewModel.isBusy
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SpinKitWanderingCubes(
                    color: Colors.white,
                    size: 40,
                    duration: Duration(milliseconds: 1200),
                  ),
                )
              : Container(
                  margin: widget.viewModel.gratefulForControllers.length == 0
                      ? EdgeInsets.all(0)
                      : EdgeInsets.symmetric(vertical: height * 0.01),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: widget.viewModel.gratefulForControllers.length,
                    itemBuilder: (context, index) {
                      return GratefulTextField(
                        viewModel: widget.viewModel,
                        index: index,
                      );
                    },
                  ),
                ),
          Container(
            margin: EdgeInsets.only(
                left: width * 0.03, top: height * 0.02, bottom: height * 0.01),
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus.unfocus();
                widget.viewModel.addGratefulForController();
              },
              child: Text(
                "+  Add New",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class GratefulTextField extends StatefulWidget {
  final JournalViewModel viewModel;
  final int index;
  const GratefulTextField({Key key, this.viewModel, this.index})
      : super(key: key);

  @override
  _GratefulTextFieldState createState() => _GratefulTextFieldState();
}

class _GratefulTextFieldState extends State<GratefulTextField> {
  FocusNode gratefulFocusNode = FocusNode();
  String gratefulNameError;
  List<String> gratefulOptions = [
    'This helped me get through the day',
    'I have extra appreciation for',
    'I realized the importance of',
    "I'm simply grateful for",
    "Someone I should thank",
    "I consider myself lucky because",
    "Other"
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Slidable(
          startActionPane: ActionPane(
            motion: DrawerMotion(),
            children: [
              SlidableAction(
                icon: Icons.delete,
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                onPressed: (c) =>
                    widget.viewModel.deleteGratefulForController(widget.index),
              ),
            ],
          ),
          child: widget.viewModel.gratefulForControllers[widget.index].text ==
                  ""
              ? Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton(
                    iconEnabledColor: Colors.white,
                    menuMaxHeight: 400,
                    items: List<DropdownMenuItem>.generate(
                        gratefulOptions.length, (int i) {
                      return DropdownMenuItem(
                        child: Text(gratefulOptions[i] + "..."),
                        value: gratefulOptions[i],
                      );
                    }),
                    hint: Text(
                      "What are you thankful for today?",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        print(value.length);
                        widget.viewModel.gratefulForControllers[widget.index]
                            .text = value == "Other" ? " " : value + " ";
                        gratefulFocusNode.requestFocus();
                        widget.viewModel.gratefullShowTextfield[widget.index] =
                            true;
                        if (widget.viewModel
                                .gratefulForControllers[widget.index].text !=
                            "") {
                          gratefulNameError = null;
                        }
                      });
                    },
                  ),
                )
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onChanged: (val) {
                      if (widget.viewModel.gratefulForControllers[widget.index]
                              .text ==
                          "") {
                        setState(() {
                          widget.viewModel
                              .gratefullShowTextfield[widget.index] = false;
                        });
                      }
                      print(val);
                      print(val.length);
                    },
                    focusNode: gratefulFocusNode,
                    textCapitalization: TextCapitalization.sentences,
                    controller:
                        widget.viewModel.gratefulForControllers[widget.index],
                    maxLines: null,
                    onSubmitted: (value) =>
                        widget.viewModel.cancelNotification(),
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.white,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'What are you thankful for today?',
                      contentPadding: EdgeInsets.only(
                          top: 0.01 * height, bottom: 0.01 * height),
                      isDense: true,
                      hintStyle: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.6)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
        ),
        Divider(
          color: Colors.white.withOpacity(0.2),
          indent: width * 0.01,
          endIndent: width * 0.01,
        )
      ],
    );
  }
}
