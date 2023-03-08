import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/widgets/dumb_widgets/info_dialog.dart';
import 'package:vitalminds/widgets/smart_widgets/journal/journal_view_model.dart';


class ThoughtOfTheDay extends StatelessWidget {
  final JournalViewModel viewModel;
  const ThoughtOfTheDay({
    Key key,
    this.viewModel,
  }) : super(key: key);

@override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.1),
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(children: [
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.03, right: width * 0.03, top: height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: [
                          Text("Thought of the day",
                              style: TextStyle(
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
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                    InfoDialog(type: 3)
                  ],
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.4),
                indent: width * 0.02,
                endIndent: width * 0.02,
              ),
              viewModel.isBusy ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: SpinKitWanderingCubes(
                color: Colors.white,
                size: 40,
                duration: Duration(milliseconds: 1200),
              ),
            ) :
              Container(
                margin: viewModel.thoughtOfTheDayControllers.length == 0
                    ? EdgeInsets.all(0)
                    : EdgeInsets.symmetric(vertical: height * 0.01),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: viewModel.thoughtOfTheDayControllers.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: width * 0.04),
                            child: Slidable(
                              startActionPane: ActionPane(
                                motion: DrawerMotion(),
                                children: [
                                  SlidableAction(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.transparent,
                                      icon: Icons.delete,
                                      onPressed: (c) {
                                        viewModel.deleteThoughtOfTheDayController(index);
                                      },
                                    ),
                                ],
                              ),
                              child: Container(
                                child: TextField(
                                  textCapitalization: TextCapitalization.sentences,
                                  controller:
                                      viewModel.thoughtOfTheDayControllers[index],
                                  maxLines: null,
                                  onSubmitted: (value) =>
                                      viewModel.cancelNotification(),
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.white,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText:
                                        'Enter thought of the day',
                                    contentPadding: EdgeInsets.only(
                                        top: 0.01 * height,
                                        bottom: 0.01 * height),
                                    isDense: true,
                                    hintStyle: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color:
                                        Colors.white.withOpacity(0.6)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.white.withOpacity(0.4),
                            indent: width * 0.02,
                            endIndent: width * 0.02,
                          )
                        ],
                      );
                    }),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: width * 0.03,
                    top: height * 0.02,
                    bottom: height * 0.02),
                child: GestureDetector(
                  onTap: () {
                    viewModel.addThoughtOfTheDayController();
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
    );
  }
}
