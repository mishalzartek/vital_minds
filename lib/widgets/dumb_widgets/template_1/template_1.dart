import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/widgets/smart_widgets/worksheets_details/worksheets_details_view_model.dart';

import '../info_dialog.dart';

class Template1Widget extends StatefulWidget {
  final DateTime selectedDay;
  final String subtitle;
  final String title;
  final WorksheetsDetailsViewModel viewModel;
  final bool cameBackFromCBTPage;
  Template1Widget({
    Key key,
    @required this.selectedDay,
    @required this.viewModel,
    @required this.title,
    @required this.subtitle,
    @required this.cameBackFromCBTPage
  }) : super(key: key);
  @override
  _Template1WidgetState createState() => _Template1WidgetState();
}

class _Template1WidgetState extends State<Template1Widget> {
  List answers;
  Map topic;

  @override
  void initState() {
    setState(() {
      if (widget.title == "4 A's of stress")
        topic = widget.viewModel.template1Topic1;
      else if (widget.title == "Eisenhower's Time Management Matrix")
        topic = widget.viewModel.template1Topic2;
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
            .updateData(
                widget.title.replaceAll(
                  new RegExp(r"\s+"),
                  "",
                ),
                1,
                widget.subtitle,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.viewModel
                            .updateData(
                                widget.title.replaceAll(new RegExp(r"\s+"), ""),
                                1,
                                widget.subtitle,
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
                      width: 0.63 * width,
                      margin: EdgeInsets.only(left: 0.04 * width),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    InfoDialog(type: 2)
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.03, bottom: height * 0.02),
                  width: width * 0.9,
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.04),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(7)),
                  child: Text(
                    "Tap on a section to add or edit entries",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        fontSize: height * 0.014),
                  ),
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
                              : GridView.builder(
                                  padding: EdgeInsets.all(0),
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: width * 0.5,
                                          childAspectRatio: 4 / 7,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20),
                                  itemCount: topic['subtitles'].length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04,
                                          vertical: height * 0.01),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            topic['subtitles'][index],
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: height * 0.016,
                                              color: Colors.white
                                            ),
                                          ),
                                          Expanded(
                                            child: TextField(
                                              textCapitalization: TextCapitalization.sentences,
                                              controller: widget.title ==
                                                      "4 A's of stress"
                                                  ? widget.viewModel
                                                          .template1Topic1[
                                                      'answers'][index]
                                                  : widget.viewModel
                                                          .template1Topic2[
                                                      'answers'][index],
                                              maxLines: null,
                                              scrollPhysics:
                                                  BouncingScrollPhysics(),
                                              keyboardType: TextInputType.text,
                                              cursorColor: Colors.white,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: height * 0.013,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                hintText: 'No entries',
                                                contentPadding: EdgeInsets.only(
                                                    top: 0.01 * height),
                                                hintStyle: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: height * 0.013,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white.withOpacity(0.7)),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.white)),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                        }))
              ],
            ),
    );
  }
}
