import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/widgets/smart_widgets/worksheets_details/worksheets_details_view_model.dart';

import '../Themes.dart';

class AbcdeModelWorksheetTemplateWidget extends StatelessWidget {
  AbcdeModelWorksheetTemplateWidget(this.selectedDay, this.viewModel, this.cameBackFromCBTPage);
  final DateTime selectedDay;
  final WorksheetsDetailsViewModel viewModel;
  final bool cameBackFromCBTPage;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        viewModel.updateData("ABCDEModel", 6, "", selectedDay).whenComplete(() {
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
                  viewModel
                      .updateData("ABCDEModel", 6, "", selectedDay)
                      .whenComplete(() => viewModel.goBackToPreviousPage(cameBackFromCBTPage));
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
                      "ABCDE Model",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Container(
                      child: Text(
                        "\nLife events do not directly determine our emotions or behaviors. Instead, it’s our beliefs, and in particular, our irrational beliefs that do.\n\n",
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
                future: viewModel.futureForWorksheetModels,
                builder: (buildContext, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? SpinKitWanderingCubes(
                          color: Colors.white,
                          size: 100,
                          duration: Duration(milliseconds: 1200),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: viewModel.buildABCDEModelBoxes.length,
                          itemBuilder: (context, index) {
                            return buildOuterBox(
                                context,
                                viewModel.buildABCDEModelBoxes[index]["title"],
                                viewModel.buildABCDEModelBoxes[index]
                                    ["content"],
                                viewModel.buildABCDEModelBoxes[index]
                                    ["controller"]);
                          });
                }),
          )
        ],
      ),
    );
  }
}

Widget buildOuterBox(
    BuildContext context, String title, List contentList, List controllerList) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Container(
    margin: EdgeInsets.only(top: 0.02 * height),
    padding: EdgeInsets.only(
        top: 0.02 * height,
        left: 0.04 * width,
        right: 0.04 * width,
        bottom: 0.02 * height),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Themes.color.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 0)
        ],
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(7)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: contentList.length,
            itemBuilder: (context, index) {
              return buildInnerBox(
                  context, contentList[index], controllerList[index]);
            }),
      ],
    ),
  );
}

Widget buildInnerBox(
    BuildContext context, String title, TextEditingController controller) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Container(
    margin: EdgeInsets.only(top: 0.015 * height),
    padding: EdgeInsets.only(
        top: 0.02 * height,
        left: 0.03 * width,
        right: 0.03 * width,
        bottom: 0.03 * height),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.3),
      borderRadius: BorderRadius.circular(7),
    ),
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 0.02 * width),
          child: title == ""
              ? Container()
              : Text(
                  title + " :",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: height * 0.015,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
        ),
        Expanded(
          child: TextField(
            textCapitalization: TextCapitalization.sentences,
            controller: controller,
            maxLines: null,
            keyboardType: TextInputType.text,
            cursorColor: Colors.white,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: height * 0.015,
                fontWeight: FontWeight.w600,
                color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter text here',
              hintMaxLines: 2,
              contentPadding:
                  EdgeInsets.only(top: 0.01 * height, bottom: 0.01 * height),
              isDense: true,
              hintStyle: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: height * 0.015,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Themes.color)),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
      ],
    ),
  );
}
