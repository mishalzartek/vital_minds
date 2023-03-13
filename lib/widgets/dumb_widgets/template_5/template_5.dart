import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'package:vitalminds/widgets/dumb_widgets/info_dialog.dart';
import 'package:vitalminds/widgets/smart_widgets/worksheets_details/worksheets_details_view_model.dart';

class Template5Widget extends StatefulWidget {
  final DateTime selectedDay;
  final WorksheetsDetailsViewModel viewModel;
  final bool cameBackFromCBTPage;
  Template5Widget(
      {Key key, @required this.selectedDay, @required this.viewModel, @required this.cameBackFromCBTPage})
      : super(key: key);
  @override
  _Template5WidgetState createState() => _Template5WidgetState();
}

class _Template5WidgetState extends State<Template5Widget> {
  List hints = [
    "Ex. Identify presentation topic",
    "Ex. Observe others' presentation",
    "Ex. Practice presentation alone",
    "Ex. Practice presentation infront of family",
    "Ex. Give final presentation in class"
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        widget.viewModel
            .updateData(
                "DevelopingToleranceTowardsAnxiety", 5, "", widget.selectedDay)
            .whenComplete(() {
          return true;
        });
        return true;
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.viewModel
                          .updateData("Developingtolerancetowardsanxiety", 5,
                              "", widget.selectedDay)
                          .whenComplete(
                              () => widget.viewModel.goBackToPreviousPage(widget.cameBackFromCBTPage));
                    },
                    child: Container(
                      width: width * 0.08,
                      height: width * 0.08,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.1))
                          ],
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.5)),
                      child: Icon(Icons.chevron_left),
                    ),
                  ),
                  Container(
                    width: 0.6 * width,
                    margin: EdgeInsets.only(left: 0.04 * width),
                    child: Text(
                      "Developing Tolerance Towards Anxiety",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              InfoDialog(type: 2)
            ],
          ),
          Expanded(
            child: FutureBuilder(
                future: widget.viewModel.futureForWorksheetModels,
                builder: (buildContext, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? SpinKitWanderingCubes(
                          color: Themes.color,
                          size: 100,
                          duration: Duration(milliseconds: 1200),
                        )
                      : Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.symmetric(vertical: height * 0.02),
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.015,
                                  horizontal: width * 0.04),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Themes.color.withOpacity(0.2),
                                        blurRadius: 8,
                                        spreadRadius: 0)
                                  ],
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Text("The more we avoid a situation, the more our anxiety grows. Let's try this exposure ladder to get more comfortable with our anxious situation. Start from the bottom-most row with the smallest / easiest step, and as you move up, make each step slightly more challenging than the previous to expose yourself gradually to your fears.",
                                style: TextStyle(
                                    color: Color.fromRGBO(39, 51, 72, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: height * 0.015),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  itemCount: widget.viewModel.stepTexts.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          widget.viewModel.updateStep(index);
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          top: 0.02 * height,
                                        ),
                                        padding: EdgeInsets.only(
                                            top: 0.02 * height,
                                            left: 0.02 * width,
                                            right: 0.04 * width,
                                            bottom: 0.02 * height),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: index ==
                                                          widget.viewModel
                                                              .currentStep
                                                      ? Colors.black.withOpacity(
                                                          0.16)
                                                      : Themes.color.withOpacity(
                                                          0.2),
                                                  blurRadius:
                                                      index ==
                                                              widget.viewModel
                                                                  .currentStep
                                                          ? 10
                                                          : 8,
                                                  spreadRadius: index ==
                                                          widget.viewModel
                                                              .currentStep
                                                      ? 3
                                                      : 0,
                                                  offset: index ==
                                                          widget.viewModel
                                                              .currentStep
                                                      ? Offset(10, 10)
                                                      : Offset(0, 0))
                                            ],
                                            color: index ==
                                                    widget.viewModel.currentStep
                                                ? Themes.color
                                                : Colors.white.withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 0.13 * width,
                                              child: Column(
                                                children: [
                                                  Text("Step",
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize:
                                                              height * 0.013,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: index ==
                                                                  widget
                                                                      .viewModel
                                                                      .currentStep
                                                              ? Colors.white
                                                              : Themes.color)),
                                                  Text("${index + 1}",
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize:
                                                              height * 0.019,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: index ==
                                                                  widget
                                                                      .viewModel
                                                                      .currentStep
                                                              ? Colors.white
                                                              : Themes.color))
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  left: 0.01 * width,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: 0.02 * height,
                                                    left: 0.03 * width,
                                                    right: 0.03 * width,
                                                    bottom: 0.02 * height),
                                                decoration: BoxDecoration(
                                                    color: index ==
                                                            widget.viewModel
                                                                .currentStep
                                                        ? Color.fromRGBO(
                                                            248, 249, 250, 0.3)
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Themes.color
                                                              .withOpacity(0.2),
                                                          blurRadius: 8)
                                                    ]),
                                                child: TextField(
                                                  textCapitalization: TextCapitalization.sentences,
                                                  controller: widget.viewModel
                                                      .stepTexts[index],
                                                  maxLines: null,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  cursorColor: Themes.color,
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: height * 0.015,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: index ==
                                                              widget.viewModel
                                                                  .currentStep
                                                          ? Colors.white
                                                          : Color.fromRGBO(
                                                              39, 51, 72, 1)),
                                                  onTap: () {
                                                    widget.viewModel
                                                        .updateStep(index);
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: hints[index],
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 0.005 * height,
                                                            bottom:
                                                                0.005 * height),
                                                    isDense: true,
                                                    hintMaxLines: 3,
                                                    hintStyle: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize:
                                                            height * 0.015,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: index ==
                                                                widget.viewModel
                                                                    .currentStep
                                                            ? Colors.white
                                                            : Color.fromRGBO(
                                                                123,
                                                                138,
                                                                160,
                                                                1)),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Themes
                                                                        .color)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        );
                }),
          )
        ],
      ),
    );
  }
}
