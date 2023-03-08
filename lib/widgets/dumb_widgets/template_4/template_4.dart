import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/widgets/dumb_widgets/info_dialog.dart';
import 'package:vitalminds/widgets/smart_widgets/worksheets_details/worksheets_details_view_model.dart';

import '../Themes.dart';

class Template4Widget extends StatefulWidget {
  final DateTime selectedDay;
  final String title;
  final WorksheetsDetailsViewModel viewModel;
  final bool cameBackFromCBTPage;
  Template4Widget({
    Key key,
    @required this.selectedDay,
    @required this.viewModel,
    @required this.title,
    @required this.cameBackFromCBTPage
  }) : super(key: key);
  @override
  _Template4WidgetState createState() => _Template4WidgetState();
}

class _Template4WidgetState extends State<Template4Widget> {
  List options;
  Map topic;

  @override
  void initState() {
    setState(() {
      if (widget.title == "Living a life of meaning and purpose") {
        topic = widget.viewModel.template4Topic1;
        options = [
          ["a", "b", "c"],
          ["a", "b", "c"],
          ["a", "b", "c"],
          ["a", "b", "c"],
          ["a", "b", "c"]
        ];
      } else if (widget.title == "Taking charge") {
        topic = widget.viewModel.template4Topic2;
        options = [
          ["a", "b", "c"],
          ["a"],
          ["a"]
        ];
      } else {}
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
            .updateData(widget.title.replaceAll(new RegExp(r"\s+"), ""), 4, "",
                widget.selectedDay)
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
                              4,
                              "",
                              widget.selectedDay)
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
              InfoDialog(type: 2)
            ],
          ),
          Expanded(
            child: FutureBuilder(
                future: widget.viewModel.futureForWorksheetModels,
                builder: (buildContext, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? SpinKitWanderingCubes(
                          color: Colors.white,
                          size: 100,
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
                                          ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              padding: EdgeInsets.all(0),
                                              itemCount: options[index].length,
                                              itemBuilder: (context, subIndex) {
                                                return Container(
                                                    margin: EdgeInsets.only(
                                                        top: 0.015 * height),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                0.02 * height,
                                                            horizontal:
                                                                0.03 * width),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white.withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    ),
                                                    child: DropdownButton(
                                                      dropdownColor: Themes.color,
                                                      isExpanded: true,
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_drop_down_sharp,
                                                        color: Colors.white.withOpacity(0.7),
                                                      ),
                                                      underline: Container(),
                                                      iconEnabledColor:
                                                          Colors.transparent,
                                                      isDense: false,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          widget.viewModel.changeAnswer(
                                                              widget.title,
                                                              (index + 1)
                                                                      .toString() +
                                                                  options[index]
                                                                      [
                                                                      subIndex],
                                                              value);
                                                        });
                                                      },
                                                      items: topic['options']
                                                          [index],
                                                      value: widget.title ==
                                                              "Living a life of meaning and purpose"
                                                          ? (index == 0
                                                              ? (subIndex == 0
                                                                  ? widget
                                                                      .viewModel
                                                                      .template4Topic1Answer1a
                                                                  : subIndex ==
                                                                          1
                                                                      ? widget
                                                                          .viewModel
                                                                          .template4Topic1Answer1b
                                                                      : widget
                                                                          .viewModel
                                                                          .template4Topic1Answer1c)
                                                              : index == 1
                                                                  ? (subIndex ==
                                                                          0
                                                                      ? widget
                                                                          .viewModel
                                                                          .template4Topic1Answer2a
                                                                      : subIndex ==
                                                                              1
                                                                          ? widget
                                                                              .viewModel
                                                                              .template4Topic1Answer2b
                                                                          : widget
                                                                              .viewModel
                                                                              .template4Topic1Answer2c)
                                                                  : index == 2
                                                                      ? (subIndex ==
                                                                              0
                                                                          ? widget
                                                                              .viewModel
                                                                              .template4Topic1Answer3a
                                                                          : subIndex ==
                                                                                  1
                                                                              ? widget
                                                                                  .viewModel.template4Topic1Answer3b
                                                                              : widget
                                                                                  .viewModel.template4Topic1Answer3c)
                                                                      : index ==
                                                                              3
                                                                          ? (subIndex ==
                                                                                  0
                                                                              ? widget
                                                                                  .viewModel.template4Topic1Answer4a
                                                                              : subIndex ==
                                                                                      1
                                                                                  ? widget
                                                                                      .viewModel.template4Topic1Answer4b
                                                                                  : widget
                                                                                      .viewModel.template4Topic1Answer4c)
                                                                          : (subIndex ==
                                                                                  0
                                                                              ? widget
                                                                                  .viewModel.template4Topic1Answer5a
                                                                              : subIndex ==
                                                                                      1
                                                                                  ? widget
                                                                                      .viewModel.template4Topic1Answer5b
                                                                                  : widget
                                                                                      .viewModel.template4Topic1Answer5c))
                                                          : (index == 0
                                                              ? (subIndex == 0
                                                                  ? widget
                                                                      .viewModel
                                                                      .template4Topic2Answer1a
                                                                  : subIndex ==
                                                                          1
                                                                      ? widget
                                                                          .viewModel
                                                                          .template4Topic2Answer1b
                                                                      : widget
                                                                          .viewModel
                                                                          .template4Topic2Answer1c)
                                                              : index == 1
                                                                  ? widget
                                                                      .viewModel
                                                                      .template4Topic2Answer2a
                                                                  : widget
                                                                      .viewModel
                                                                      .template4Topic2Answer3a),
                                                      hint: Text(
                                                        "Choose",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize:
                                                                height * 0.015,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white.withOpacity(0.7)),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ));
                                              }),
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
