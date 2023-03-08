import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'package:vitalminds/widgets/smart_widgets/worksheets_details/worksheets_details_view_model.dart';

class BehavioralActivationWorksheetTemplateWidget extends StatefulWidget {
  final DateTime selectedDay;
  final WorksheetsDetailsViewModel viewModel;
  final bool cameBackFromCBTPage;
  BehavioralActivationWorksheetTemplateWidget(
      {Key key, @required this.selectedDay, @required this.viewModel, @required this.cameBackFromCBTPage})
      : super(key: key);
  @override
  _BehavioralActivationWorksheetTemplateWidgetState createState() =>
      _BehavioralActivationWorksheetTemplateWidgetState();
}

class _BehavioralActivationWorksheetTemplateWidgetState
    extends State<BehavioralActivationWorksheetTemplateWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        widget.viewModel.updateData("BehavioralActivation", 8,"", widget.selectedDay).whenComplete(() {
          return true;
        });
        return true;
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.04 * width),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.viewModel
                        .updateData("BehavioralActivation", 8,"", widget.selectedDay)
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
                        color: Colors.white.withOpacity(0.2)),
                    child: Icon(Icons.chevron_left, color: Colors.white,),
                  ),
                ),
                Container(
                  width: 0.7 * width,
                  margin: EdgeInsets.only(left: 0.04 * width),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Behavioral activation",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Container(
                        child: Text(
                          "\nAnalyze how your actions can improve or worsen your current mood. Use this as a guide to adopt behaviors that move you up the ladder to your best mood!\n",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: widget.viewModel.futureForWorksheetModels,
                builder: (buildContext, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? SpinKitWanderingCubes(
                          color: Colors.white,
                          size: 100,
                          duration: Duration(milliseconds: 1200),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: widget.viewModel
                              .buildBehavioralActivationModelBoxes.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.viewModel.updateRank(
                                      widget.viewModel
                                              .buildBehavioralActivationModelBoxes[
                                          index]["rank"],
                                      widget.viewModel);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 0.02 * height,
                                    left: 0.15 * width - ((4 - index).abs()) * 0.02 * width ,
                                    right: 0.15 * width - ((4 - index).abs()) * 0.02 * width),
                                padding: EdgeInsets.only(
                                    top: 0.02 * height,
                                    left: 0.015 * width,
                                    right: 0.03 * width,
                                    bottom: 0.02 * height),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: widget.viewModel.buildBehavioralActivationModelBoxes[index]
                                                      ["rank"] ==
                                                  widget.viewModel.currentRank
                                              ? Colors.white.withOpacity(0.1)
                                              : Themes.color.withOpacity(0.2),
                                          blurRadius: widget.viewModel.buildBehavioralActivationModelBoxes[index]
                                                      ["rank"] ==
                                                  widget.viewModel.currentRank
                                              ? 10
                                              : 8,
                                          spreadRadius: widget.viewModel
                                                          .buildBehavioralActivationModelBoxes[index]
                                                      ["rank"] ==
                                                  widget.viewModel.currentRank
                                              ? 3
                                              : 0,
                                          offset: widget.viewModel.buildBehavioralActivationModelBoxes[index]
                                                      ["rank"] ==
                                                  widget.viewModel.currentRank
                                              ? Offset(10, 10)
                                              : Offset(0, 0))
                                    ],
                                    color: widget.viewModel
                                                    .buildBehavioralActivationModelBoxes[
                                                index]["rank"] ==
                                            widget.viewModel.currentRank
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 0.13 * width,
                                      child: Column(
                                        children: [
                                          Text(
                                              "${widget.viewModel.buildBehavioralActivationModelBoxes[index]["rank"]}",
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: width * 0.04,
                                                  fontWeight: FontWeight.w600,
                                                  color: widget.viewModel
                                                                  .buildBehavioralActivationModelBoxes[
                                                              index]["rank"] ==
                                                          widget.viewModel
                                                              .currentRank
                                                      ? Themes.color
                                                      : Colors.white)),
                                                      widget.viewModel.buildBehavioralActivationModelBoxes[index]["rank"] ==
                                                  1 ?Text("Worst",
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: widget.viewModel.buildBehavioralActivationModelBoxes[index]
                                                                  ["rank"] ==
                                                              widget.viewModel
                                                                  .currentRank
                                                          ? Themes.color
                                                          : Colors.white)):
                                          widget.viewModel.buildBehavioralActivationModelBoxes[index]["rank"] ==
                                                  9
                                              ? Text("Best",
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: widget.viewModel.buildBehavioralActivationModelBoxes[index]
                                                                  ["rank"] ==
                                                              widget.viewModel
                                                                  .currentRank
                                                          ? Themes.color
                                                          : Colors.white))
                                              : (widget.viewModel.buildBehavioralActivationModelBoxes[index]
                                                          ["rank"] ==
                                                      widget
                                                          .viewModel.currentRank
                                                  ? Text("Current",
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w600,
                                                          color: widget.viewModel.buildBehavioralActivationModelBoxes[index]["rank"] == widget.viewModel.currentRank ? Themes.color :Colors.white ))
                                                  : Container(
                                                      height: 0,
                                                      width: 0,
                                                    ))
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
                                            color: widget.viewModel
                                                            .buildBehavioralActivationModelBoxes[
                                                        index]["rank"] ==
                                                    widget.viewModel.currentRank
                                                ? Themes.color
                                                : Colors.white.withOpacity(0.4),
                                            borderRadius: BorderRadius.circular(7),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Themes.color
                                                      .withOpacity(0.2),
                                                  blurRadius: 8)
                                            ]),
                                        child: Text(
                                            widget.viewModel
                                                    .buildBehavioralActivationModelBoxes[
                                                index]["content"],
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: width * 0.03,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                }),
          )
        ],
      ),
    );
  }
}
