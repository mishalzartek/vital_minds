import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:vitalminds/widgets/smart_widgets/worksheets_details/worksheets_details_view_model.dart';

import '../Themes.dart';

class BasicWorksheetTemplateWidget extends StatefulWidget {
  final DateTime selectedDay;
  final String category;
  final String title;
  final WorksheetsDetailsViewModel viewModel;
  final bool cameBackFromCBTPage;
  BasicWorksheetTemplateWidget(
      {Key key,
      @required this.selectedDay,
      @required this.viewModel,
      @required this.category,
      @required this.title,
      @required this.cameBackFromCBTPage
      })
      : super(key: key);
  @override
  _BasicWorksheetTemplateWidgetState createState() =>
      _BasicWorksheetTemplateWidgetState();
}

class _BasicWorksheetTemplateWidgetState
    extends State<BasicWorksheetTemplateWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        widget.viewModel
            .updateData(widget.title.replaceAll(new RegExp(r"\s+"), ""), 9, "",
                widget.selectedDay)
            .whenComplete(() {
          return true;
        });
        return true;
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  widget.viewModel
                      .updateData(
                          widget.title.replaceAll(new RegExp(r"\s+"), ""),
                          9,
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
                      color: Colors.white.withOpacity(0.5)),
                  child: Icon(Icons.chevron_left),
                ),
              ),
              Container(
                width: 0.7 * width,
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
                    Container(
                      child: Text(
                        widget.category + "\n\n",
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
                      : ListView(
                          padding: EdgeInsets.all(0),
                          children: [
                            buildOuterBox(
                                context,
                                "What am I worrying about? •",
                                TextField(
                                  textCapitalization: TextCapitalization.sentences,
                                  controller: widget.viewModel.worryingAbout,
                                  maxLines: null,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Themes.color,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(39, 51, 72, 1)),
                                  decoration: InputDecoration(
                                    hintText: 'Enter text here',
                                    hintMaxLines: 2,
                                    contentPadding: EdgeInsets.only(
                                        top: 0.01 * height,
                                        bottom: 0.01 * height),
                                    isDense: true,
                                    hintStyle: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Color.fromRGBO(123, 138, 160, 1)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Themes.color)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                                1),
                            buildOuterBox(
                                context,
                                "Is this a problem I can do something about? •",
                                Column(
                                  children: [
                                    Text(
                                      "Try to distinguish between:\n'Real worries' which you can do something about & 'Hypothetical worries' which you cannot do anything about.",
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12,
                                          color:
                                              Color.fromRGBO(123, 138, 160, 1)),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.viewModel
                                                  .markCheckBox("yes");
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 0.02 * height),
                                            width: 0.055 * width,
                                            height: 0.055 * width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: widget.viewModel.yes
                                                    ? Themes.color
                                                    : Colors.white),
                                            child: Icon(
                                              Icons.check,
                                              size: 18,
                                              color: widget.viewModel.yes
                                                  ? Colors.white
                                                  : Color.fromRGBO(
                                                      123, 138, 160, 1),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: 0.02 * height,
                                                left: 0.02 * width),
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      39, 51, 72, 1)),
                                            )),
                                        Container(width: width * 0.1),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.viewModel
                                                  .markCheckBox("no");
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 0.02 * height),
                                            width: 0.055 * width,
                                            height: 0.055 * width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: widget.viewModel.no
                                                    ? Themes.color
                                                    : Colors.white),
                                            child: Icon(
                                              Icons.close,
                                              size: 18,
                                              color: widget.viewModel.no
                                                  ? Colors.white
                                                  : Color.fromRGBO(
                                                      123, 138, 160, 1),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: 0.02 * height,
                                                left: 0.02 * width),
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      39, 51, 72, 1)),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                                2),
                            buildOuterBox(
                                context,
                                "Let the worry go, change focus of your attention",
                                Column(
                                  children: [
                                    Text(
                                      "Change your focus by:\n\nDistracting yourself with something more interesting. Using mindful awareness to pay attention to your surroundings.",
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12,
                                          color:
                                              Color.fromRGBO(123, 138, 160, 1)),
                                    ),
                                  ],
                                ),
                                3),
                            Container(
                              margin: EdgeInsets.only(top: 0.02 * height),
                              padding: EdgeInsets.only(
                                  top: 0.02 * height,
                                  left: 0.04 * width,
                                  right: 0.04 * width,
                                  bottom: 0.03 * height),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Themes.color.withOpacity(0.2),
                                        blurRadius: 8,
                                        spreadRadius: 0)
                                  ],
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: width * 0.7,
                                            child: SubstringHighlight(
                                              term: "•",
                                              text:
                                                  "What can I do about this? •\n",
                                              textStyle: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      39, 51, 72, 1)),
                                              textStyleHighlight: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Themes.color),
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget.viewModel.addNewElement();
                                          });
                                        },
                                        child: Text(
                                          "Add   ",
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Themes.color),
                                        ),
                                      )
                                    ],
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: widget
                                        .viewModel.buildBasicModelBoxes.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.01 * height),
                                        child: TextField(
                                          textCapitalization: TextCapitalization.sentences,
                                          controller: widget.viewModel
                                              .buildBasicModelBoxes[index],
                                          maxLines: null,
                                          keyboardType: TextInputType.text,
                                          cursorColor: Themes.color,
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  39, 51, 72, 1)),
                                          decoration: InputDecoration(
                                            prefixText: '•   ',
                                            prefixStyle: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Themes.color),
                                            hintText: 'Enter text here',
                                            hintMaxLines: 2,
                                            contentPadding: EdgeInsets.only(
                                                top: 0.01 * height,
                                                bottom: 0.01 * height),
                                            isDense: true,
                                            hintStyle: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    123, 138, 160, 1)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Themes.color)),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide.none),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
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

Widget buildOuterBox(
    BuildContext context, String title, Widget content, int boxNumber) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Container(
    margin: EdgeInsets.only(top: 0.02 * height),
    padding: EdgeInsets.only(
        top: 0.02 * height,
        left: 0.04 * width,
        right: 0.04 * width,
        bottom: 0.03 * height),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Themes.color.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 0)
        ],
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(7)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.75,
                  child: SubstringHighlight(
                    term: "•",
                    text: title + "\n",
                    textStyleHighlight: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        fontWeight:
                            boxNumber == 3 ? FontWeight.w600 : FontWeight.w500,
                        color: Themes.color),
                    textStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: boxNumber == 3 ? 13 : 12,
                        fontWeight:
                            boxNumber == 3 ? FontWeight.w600 : FontWeight.w500,
                        color: Color.fromRGBO(39, 51, 72, 1)),
                  ),
                ),
              ],
            ),
            boxNumber == 4
                ? GestureDetector(
                    child: Text(
                      "Add   ",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Themes.color),
                    ),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  )
          ],
        ),
        content
      ],
    ),
  );
}
