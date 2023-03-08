import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/widgets/dumb_widgets/info_dialog.dart';
import 'package:vitalminds/widgets/smart_widgets/worksheets_details/worksheets_details_view_model.dart';

import '../Themes.dart';

class Template3Widget extends StatefulWidget {
  final DateTime selectedDay;
  final String title;
  final WorksheetsDetailsViewModel viewModel;
  final bool cameBackFromCBTPage;
  Template3Widget({
    Key key,
    @required this.selectedDay,
    @required this.viewModel,
    @required this.title,
    @required this.cameBackFromCBTPage
  }) : super(key: key);
  @override
  _Template3WidgetState createState() => _Template3WidgetState();
}

class _Template3WidgetState extends State<Template3Widget> {
  Map topic;
  // List answers;

  void addAnswer(int index) {
    setState(() {
      if (widget.title == "Reframing our SHOULD statements")
        widget.viewModel.template3Topic1["answers"][index]
            .add(new TextEditingController());
      else if (widget.title == "What's stopping you from taking a break")
        widget.viewModel.template3Topic2["answers"][index]
            .add(new TextEditingController());
      else if (widget.title == "Less is More")
        widget.viewModel.template3Topic3["answers"][index]
            .add(new TextEditingController());
      else if (widget.title == "Questioning Our Assumptions")
        widget.viewModel.template3Topic4["answers"][index]
            .add(new TextEditingController());
      else if (widget.title == "Tapping into our Resources")
        widget.viewModel.template3Topic5["answers"][index]
            .add(new TextEditingController());
      else if (widget.title == "Thought Record")
        widget.viewModel.template3Topic6["answers"][index]
            .add(new TextEditingController());
      else if (widget.title == "Tiny changes with big benefits")
        widget.viewModel.template3Topic7["answers"][index]
            .add(new TextEditingController());
      else if (widget.title == "Habits")
        widget.viewModel.template3Topic8["answers"][index]
            .add(new TextEditingController());
      // answers[index].add(new TextEditingController());
    });
  }

  void removeAnswer(int index, int subIndex) {
    setState(() {
      if (widget.title == "Reframing our SHOULD statements")
        widget.viewModel.template3Topic1["answers"][index].removeAt(subIndex);
      else if (widget.title == "What's stopping you from taking a break")
        widget.viewModel.template3Topic2["answers"][index].removeAt(subIndex);
      else if (widget.title == "Less is More")
        widget.viewModel.template3Topic3["answers"][index].removeAt(subIndex);
      else if (widget.title == "Questioning Our Assumptions")
        widget.viewModel.template3Topic4["answers"][index].removeAt(subIndex);
      else if (widget.title == "Tapping into our Resources")
        widget.viewModel.template3Topic5["answers"][index].removeAt(subIndex);
      else if (widget.title == "Thought Record")
        widget.viewModel.template3Topic6["answers"][index].removeAt(subIndex);
      else if (widget.title == "Tiny changes with big benefits")
        widget.viewModel.template3Topic7["answers"][index].removeAt(subIndex);
      else if (widget.title == "Habits")
        widget.viewModel.template3Topic8["answers"][index].removeAt(subIndex);
      // answers[index].removeAt(subIndex);
    });
  }

  @override
  void initState() {
    setState(() {
      if (widget.title == "Reframing our SHOULD statements")
        topic = widget.viewModel.template3Topic1;
      else if (widget.title == "What's stopping you from taking a break")
        topic = widget.viewModel.template3Topic2;
      else if (widget.title == "Less is More")
        topic = widget.viewModel.template3Topic3;
      else if (widget.title == "Questioning Our Assumptions")
        topic = widget.viewModel.template3Topic4;
      else if (widget.title == "Tapping into our Resources")
        topic = widget.viewModel.template3Topic5;
      else if (widget.title == "Thought Record")
        topic = widget.viewModel.template3Topic6;
      else if (widget.title == "Tiny changes with big benefits")
        topic = widget.viewModel.template3Topic7;
      else if (widget.title == "Habits")
        topic = widget.viewModel.template3Topic8;
      else {}
    });
    // answers = List.generate(
    //     topic['questions'].length, (index) => [new TextEditingController()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        widget.viewModel
            .updateData(widget.title.replaceAll(new RegExp(r"\s+"), ""), 3,"", widget.selectedDay)
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.viewModel
                          .updateData(
                              widget.title.replaceAll(new RegExp(r"\s+"), ""),
                              3,"", widget.selectedDay)
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
                    width: 0.6 * width,
                    margin: EdgeInsets.only(left: 0.04 * width),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              InfoDialog(type: 1)
            ],
          ),
          Expanded(
            child: FutureBuilder(
                future: widget.viewModel.futureForWorksheetModels,
                builder: (buildContext, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting ||
                          widget.viewModel.isBusy
                      ? SpinKitWanderingCubes(
                          color: Colors.white,
                          size: 100,
                          // duration: Duration(milliseconds: 1200),
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
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Text(
                                topic["summary"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: height * 0.015),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                itemCount: topic['questions'].length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.only(
                                          bottom: height * 0.02),
                                      padding: EdgeInsets.symmetric(
                                          vertical: height * 0.015,
                                          horizontal: width * 0.04),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Themes.color
                                                    .withOpacity(0.2),
                                                blurRadius: 8,
                                                spreadRadius: 0)
                                          ],
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            topic['questions'][index],
                                            style: TextStyle(
                                              fontSize: height * 0.015,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          (widget.title == "Reframing our SHOULD statements" &&
                                                      index == 3) ||
                                                  (widget.title ==
                                                          "Thought Record" &&
                                                      index == 6)
                                              ? Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        widget.title ==
                                                                "Reframing our SHOULD statements"
                                                            ? widget.viewModel
                                                                .template3Topic1MarkCheckBox(
                                                                    "Yes")
                                                            : widget.viewModel
                                                                .template3Topic6MarkCheckBox(
                                                                    "Yes");
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 0.02 *
                                                                        height),
                                                            width:
                                                                0.055 * width,
                                                            height:
                                                                0.055 * width,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: (widget.title ==
                                                                                "Reframing our SHOULD statements" &&
                                                                            widget
                                                                                .viewModel.template3Topic1Yes) ||
                                                                        (widget.title ==
                                                                                "Thought Record" &&
                                                                            widget
                                                                                .viewModel.template3Topic6Yes)
                                                                    ? Colors.white
                                                                    : Colors
                                                                        .white.withOpacity(0.3)),
                                                            child: Icon(
                                                              Icons.check,
                                                              size: 18,
                                                              color: (widget.title ==
                                                                              "Reframing our SHOULD statements" &&
                                                                          widget
                                                                              .viewModel
                                                                              .template3Topic1Yes) ||
                                                                      (widget.title ==
                                                                              "Thought Record" &&
                                                                          widget
                                                                              .viewModel
                                                                              .template3Topic6Yes)
                                                                  ? Themes.color
                                                                  : Colors.white.withOpacity(0.7),
                                                            ),
                                                          ),
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 0.02 *
                                                                          height,
                                                                      left: 0.02 *
                                                                          width),
                                                              child: Text(
                                                                "Yes",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: (widget.title == "Reframing our SHOULD statements" && widget.viewModel.template3Topic1Yes) ||
                                                                            (widget.title == "Thought Record" &&
                                                                                widget
                                                                                    .viewModel.template3Topic6Yes)
                                                                        ? Colors.white
                                                                        : Colors.white.withOpacity(0.4)),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                        width: width * 0.1),
                                                    GestureDetector(
                                                      onTap: () {
                                                        widget.title ==
                                                                "Reframing our SHOULD statements"
                                                            ? widget.viewModel
                                                                .template3Topic1MarkCheckBox(
                                                                    "No")
                                                            : widget.viewModel
                                                                .template3Topic6MarkCheckBox(
                                                                    "No");
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 0.02 *
                                                                        height),
                                                            width:
                                                                0.055 * width,
                                                            height:
                                                                0.055 * width,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: (widget.title ==
                                                                                "Reframing our SHOULD statements" &&
                                                                            widget
                                                                                .viewModel.template3Topic1No) ||
                                                                        (widget.title ==
                                                                                "Thought Record" &&
                                                                            widget
                                                                                .viewModel.template3Topic6No)
                                                                    ? Colors.white
                                                                    : Colors
                                                                        .white.withOpacity(0.3)),
                                                            child: Icon(
                                                              Icons.close,
                                                              size: 18,
                                                              color: (widget.title ==
                                                                              "Reframing our SHOULD statements" &&
                                                                          widget
                                                                              .viewModel
                                                                              .template3Topic1No) ||
                                                                      (widget.title ==
                                                                              "Thought Record" &&
                                                                          widget
                                                                              .viewModel
                                                                              .template3Topic6No)
                                                                  ? Themes.color
                                                                  : Colors.white.withOpacity(0.7),
                                                            ),
                                                          ),
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 0.02 *
                                                                          height,
                                                                      left: 0.02 *
                                                                          width),
                                                              child: Text(
                                                                "No",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: (widget.title == "Reframing our SHOULD statements" && widget.viewModel.template3Topic1No) ||
                                                                            (widget.title == "Thought Record" &&
                                                                                widget
                                                                                    .viewModel.template3Topic6No)
                                                                        ? Colors.white
                                                                        : Colors.white.withOpacity(0.4)),
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.all(0),
                                                  itemCount: widget.title ==
                                                          "Reframing our SHOULD statements"
                                                      ? widget
                                                          .viewModel
                                                          .template3Topic1["answers"]
                                                              [index]
                                                          .length
                                                      : widget.title ==
                                                              "What's stopping you from taking a break"
                                                          ? widget
                                                              .viewModel
                                                              .template3Topic2["answers"]
                                                                  [index]
                                                              .length
                                                          : widget.title ==
                                                                  "Less is More"
                                                              ? widget
                                                                  .viewModel
                                                                  .template3Topic3[
                                                                      "answers"]
                                                                      [index]
                                                                  .length
                                                              : widget.title ==
                                                                      "Questioning Our Assumptions"
                                                                  ? widget
                                                                      .viewModel
                                                                      .template3Topic4["answers"]
                                                                          [index]
                                                                      .length
                                                                  : widget.title == "Tapping into our Resources"
                                                                      ? widget.viewModel.template3Topic5["answers"][index].length
                                                                      : widget.title == "Thought Record"
                                                                          ? widget.viewModel.template3Topic6["answers"][index].length
                                                                          : widget.title == "Tiny changes with big benefits"
                                                                              ? widget.viewModel.template3Topic7["answers"][index].length
                                                                              : widget.title == "Habits"
                                                                                  ? widget.viewModel.template3Topic8["answers"][index].length
                                                                                  : 0,
                                                  // answers[index].length,
                                                  itemBuilder: (context, subIndex) {
                                                    return Slidable(
                                                      enabled: topic[
                                                              'multiple_answers']
                                                          [index],
                                                      startActionPane:
                                                          ActionPane(
                                                            extentRatio: 0.25,
                                                            motion: DrawerMotion(),
                                                            children: [
                                                              SlidableAction(
                                                                label: "Delete",
                                                                icon: Icons.delete,
                                                                foregroundColor: Colors.white,
                                                                backgroundColor: Colors.transparent,
                                                                onPressed: (c) =>
                                                                    removeAnswer(
                                                                        index,
                                                                        subIndex),
                                                              )
                                                            ],
                                                          ),
                                                      child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 0.015 *
                                                                      height),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 0.01 *
                                                                      height,
                                                                  left: 0.03 *
                                                                      width,
                                                                  right: 0.03 *
                                                                      width,
                                                                  bottom: 0.02 *
                                                                      height),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white.withOpacity(0.3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                          ),
                                                          child: TextField(
                                                            textCapitalization: TextCapitalization.sentences,
                                                            controller: widget
                                                                        .title ==
                                                                    "Reframing our SHOULD statements"
                                                                ? widget.viewModel
                                                                            .template3Topic1["answers"]
                                                                        [index]
                                                                    [subIndex]
                                                                : widget.title ==
                                                                        "What's stopping you from taking a break"
                                                                    ? widget.viewModel
                                                                            .template3Topic2["answers"][index]
                                                                        [
                                                                        subIndex]
                                                                    : widget.title ==
                                                                            "Less is More"
                                                                        ? widget
                                                                            .viewModel
                                                                            .template3Topic3["answers"][index][subIndex]
                                                                        : widget.title == "Questioning Our Assumptions"
                                                                            ? widget.viewModel.template3Topic4["answers"][index][subIndex]
                                                                            : widget.title == "Tapping into our Resources"
                                                                                ? widget.viewModel.template3Topic5["answers"][index][subIndex]
                                                                                : widget.title == "Thought Record"
                                                                                    ? widget.viewModel.template3Topic6["answers"][index][subIndex]
                                                                                    : widget.title == "Tiny changes with big benefits"
                                                                                        ? widget.viewModel.template3Topic7["answers"][index][subIndex]
                                                                                        : widget.title == "Habits"
                                                                                            ? widget.viewModel.template3Topic8["answers"][index][subIndex]
                                                                                            : null,
                                                            // answers[index][subIndex],
                                                            maxLines: null,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            cursorColor:
                                                                Colors.white,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontSize:
                                                                    height *
                                                                        0.015,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors.white),
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: topic['hints']
                                                                              [
                                                                              index]
                                                                          .length <=
                                                                      subIndex
                                                                  ? 'Enter text here'
                                                                  : topic['hints']
                                                                          [
                                                                          index]
                                                                      [
                                                                      subIndex],
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top: 0.01 *
                                                                          height,
                                                                      bottom: 0.01 *
                                                                          height),
                                                              isDense: true,
                                                              hintMaxLines: 8,
                                                              hintStyle: TextStyle(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontSize:
                                                                      height *
                                                                          0.015,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors.white.withOpacity(0.7)),
                                                              focusedBorder: UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.white)),
                                                              enabledBorder:
                                                                  UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide
                                                                              .none),
                                                            ),
                                                          )),
                                                    );
                                                  }),
                                          topic['multiple_answers'][index]
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.5,
                                                      top: height * 0.02),
                                                  child: GestureDetector(
                                                    onTap: () =>
                                                        addAnswer(index),
                                                    child: Text(
                                                      "+ Add Statement",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'Roboto',
                                                          fontSize:
                                                              width * 0.032),
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      top: height * 0.01)),
                                        ],
                                      ));
                                },
                              ),
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
