import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/widgets/dumb_widgets/info_dialog.dart';
import 'package:vitalminds/widgets/smart_widgets/worksheets_details/worksheets_details_view_model.dart';

import '../Themes.dart';

class Template2Widget extends StatefulWidget {
  final DateTime selectedDay;
  final String title;
  final WorksheetsDetailsViewModel viewModel;
  final bool cameBackFromCBTPage;
  Template2Widget(
      {Key key,
      @required this.selectedDay,
      @required this.viewModel,
      @required this.title,
      @required this.cameBackFromCBTPage})
      : super(key: key);
  @override
  _Template2WidgetState createState() => _Template2WidgetState();
}

class _Template2WidgetState extends State<Template2Widget> {
  Map topic;
  var nop;

  void addAnswer(int index) {
    setState(() {
      widget.title == "Turning Stress Into Action"
          ? widget.viewModel.template2Topic1["answers"][index]
              .add(new TextEditingController())
          : widget.title == "Rule of three"
              ? widget.viewModel.template2Topic2["answers"][index]
                  .add(new TextEditingController())
              : widget.title == "Stop worrying about the future"
                  ? widget.viewModel.template2Topic3["answers"][index]
                      .add(new TextEditingController())
                  : nop = nop;
    });
  }

  void removeAnswer(int index, int subIndex) {
    setState(() {
      widget.title == "Turning Stress Into Action"
          ? widget.viewModel.template2Topic1["answers"][index]
              .removeAt(subIndex)
          : widget.title == "Rule of three"
              ? widget.viewModel.template2Topic2["answers"][index]
                  .removeAt(subIndex)
              : widget.title == "Stop worrying about the future"
                  ? widget.viewModel.template2Topic3["answers"][index]
                      .removeAt(subIndex)
                  : nop = nop;
    });
  }

  @override
  void initState() {
    setState(() {
      if (widget.title == "Turning Stress Into Action")
        topic = widget.viewModel.template2Topic1;
      else if (widget.title == "Rule of three")
        topic = widget.viewModel.template2Topic2;
      else if (widget.title == "Stop worrying about the future")
        topic = widget.viewModel.template2Topic3;
      else {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        widget.viewModel
            .updateData(widget.title.replaceAll(new RegExp(r"\s+"), ""), 2, "",
                widget.selectedDay)
            .whenComplete(() {
          return true;
        });
        return true;
      },
      child: widget.viewModel.isBusy
          ? Center(
              child: SpinKitWanderingCubes(
                color: Colors.white,
                size: 100,
              ),
            )
          : Column(
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
                                    widget.title
                                        .replaceAll(new RegExp(r"\s+"), ""),
                                    2,
                                    "",
                                    widget.selectedDay)
                                .whenComplete(() => widget.viewModel
                                    .goBackToPreviousPage(
                                        widget.cameBackFromCBTPage));
                          },
                          child: Container(
                            width: width * 0.08,
                            height: width * 0.08,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1))
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
                        ),
                      ],
                    ),
                    InfoDialog(type: 1)
                  ],
                ),
                Expanded(
                  child: FutureBuilder(
                      future: widget.viewModel.futureForWorksheetModels,
                      builder: (buildContext, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? SpinKitWanderingCubes(
                                color: Colors.white,
                                size: 100,
                                duration: Duration(milliseconds: 1200),
                              )
                            : Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: height * 0.02),
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.015,
                                        horizontal: width * 0.04),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Themes.color.withOpacity(0.2),
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
                                        return Visibility(
                                          visible: !(widget.title ==
                                                  "Stop worrying about the future" &&
                                              index == 5 &&
                                              !widget.viewModel
                                                  .template2Topic3Yes &&
                                              !widget
                                                  .viewModel.template2Topic3No),
                                          child: Container(
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
                                                  color: Colors.white
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(7)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget.title ==
                                                                "Stop worrying about the future" &&
                                                            index == 5 &&
                                                            widget.viewModel
                                                                .template2Topic3Yes
                                                        ? "What can you do right now to ease some of that worry? (Start small)"
                                                        : widget.title ==
                                                                    "Stop worrying about the future" &&
                                                                index == 5 &&
                                                                widget.viewModel
                                                                    .template2Topic3No
                                                            ? "Let go of it and immerse yourself in the present moment with a few deep breaths."
                                                            : topic['questions']
                                                                [index],
                                                    style: TextStyle(
                                                      fontSize: height * 0.015,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  (widget.title ==
                                                              "Stop worrying about the future" &&
                                                          index == 4)
                                                      ? Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                widget.viewModel
                                                                    .template2Topic3MarkCheckBox(
                                                                        "Yes");
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: 0.02 *
                                                                            height),
                                                                    width: 0.055 *
                                                                        width,
                                                                    height:
                                                                        0.055 *
                                                                            width,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        color: widget.viewModel.template2Topic3Yes
                                                                            ? Colors.white
                                                                            : Colors.white.withOpacity(0.3)),
                                                                    child: Icon(
                                                                      Icons
                                                                          .check,
                                                                      size: 18,
                                                                      color: widget
                                                                              .viewModel
                                                                              .template2Topic3Yes
                                                                          ? Themes.color
                                                                          : Colors.white.withOpacity(0.7),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                      margin: EdgeInsets.only(
                                                                          top: 0.02 *
                                                                              height,
                                                                          left: 0.02 *
                                                                              width),
                                                                      child:
                                                                          Text(
                                                                        "Yes",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            color: widget.viewModel.template2Topic3Yes
                                                                                ? Colors.white
                                                                                : Colors.white.withOpacity(0.4)),
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                                width: width *
                                                                    0.1),
                                                            GestureDetector(
                                                              onTap: () {
                                                                widget.viewModel
                                                                    .template2Topic3MarkCheckBox(
                                                                        "No");
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: 0.02 *
                                                                            height),
                                                                    width: 0.055 *
                                                                        width,
                                                                    height:
                                                                        0.055 *
                                                                            width,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        color: widget.viewModel.template2Topic3No
                                                                            ? Colors.white
                                                                            : Colors.white.withOpacity(0.3)),
                                                                    child: Icon(
                                                                      Icons
                                                                          .close,
                                                                      size: 18,
                                                                      color: widget
                                                                              .viewModel
                                                                              .template2Topic3No
                                                                          ? Themes.color
                                                                          : Colors.white.withOpacity(0.7),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                      margin: EdgeInsets.only(
                                                                          top: 0.02 *
                                                                              height,
                                                                          left: 0.02 *
                                                                              width),
                                                                      child:
                                                                          Text(
                                                                        "No",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            color: widget.viewModel.template2Topic3No
                                                                                ? Colors.white
                                                                                : Colors.white.withOpacity(0.4)),
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : (widget.title ==
                                                                  "Stop worrying about the future" &&
                                                              index == 5 &&
                                                              widget.viewModel
                                                                  .template2Topic3No)
                                                          ? Container()
                                                          : ListView.builder(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      0),
                                                              itemCount: widget
                                                                          .title ==
                                                                      "Turning Stress Into Action"
                                                                  ? widget
                                                                      .viewModel
                                                                      .template2Topic1["answers"]
                                                                          [
                                                                          index]
                                                                      .length
                                                                  : widget.title ==
                                                                          "Rule of three"
                                                                      ? widget
                                                                          .viewModel
                                                                          .template2Topic2["answers"]
                                                                              [index]
                                                                          .length
                                                                      : widget.title == "Stop worrying about the future"
                                                                          ? widget.viewModel.template2Topic3["answers"][index].length
                                                                          : 0,
                                                              itemBuilder: (context, subIndex) {
                                                                return Slidable(
                                                                  enabled: topic[
                                                                          'multiple_answers']
                                                                      [index],
                                                                  startActionPane:
                                                                      ActionPane(
                                                                        motion: DrawerMotion(),
                                                                        extentRatio: 0.25,
                                                                        children: [
                                                                          SlidableAction(
                                                                            autoClose: true,
                                                                            label:'Delete',
                                                                            backgroundColor: Colors.transparent,
                                                                            icon: Icons.delete,
                                                                            foregroundColor: Colors.white,
                                                                            onPressed: (c) => removeAnswer(
                                                                                index,
                                                                                subIndex),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                  child:
                                                                      Container(
                                                                          margin: EdgeInsets.only(
                                                                              top: 0.015 *
                                                                                  height),
                                                                          padding: EdgeInsets.only(
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
                                                                            color:
                                                                                Colors.white.withOpacity(0.3),
                                                                            borderRadius:
                                                                                BorderRadius.circular(7),
                                                                          ),
                                                                          child:
                                                                              TextField(
                                                                            textCapitalization:
                                                                                TextCapitalization.sentences,
                                                                            controller: widget.title == "Turning Stress Into Action"
                                                                                ? widget.viewModel.template2Topic1["answers"][index][subIndex]
                                                                                : widget.title == "Rule of three"
                                                                                    ? widget.viewModel.template2Topic2["answers"][index][subIndex]
                                                                                    : widget.title == "Stop worrying about the future"
                                                                                        ? widget.viewModel.template2Topic3["answers"][index][subIndex]
                                                                                        : null,
                                                                            maxLines:
                                                                                null,
                                                                            keyboardType:
                                                                                TextInputType.text,
                                                                            cursorColor: Colors.white,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                fontSize: height * 0.015,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.white),
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: topic['hints'][index].length <= subIndex ? 'Enter text here' : topic['hints'][index][subIndex],
                                                                              contentPadding: EdgeInsets.only(top: 0.01 * height, bottom: 0.01 * height),
                                                                              isDense: true,
                                                                              hintMaxLines: 8,
                                                                              hintStyle: TextStyle(fontFamily: 'Roboto', fontSize: height * 0.015, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.7)),
                                                                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                                                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                                                                            ),
                                                                          )),
                                                                );
                                                              }),
                                                  topic['multiple_answers']
                                                          [index]
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: width *
                                                                      0.5,
                                                                  top: height *
                                                                      0.02),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () =>
                                                                addAnswer(
                                                                    index),
                                                            child: Text(
                                                              "+ Add Statement",
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontSize:
                                                                      width *
                                                                          0.032),
                                                            ),
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: height *
                                                                      0.01)),
                                                ],
                                              )),
                                        );
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
