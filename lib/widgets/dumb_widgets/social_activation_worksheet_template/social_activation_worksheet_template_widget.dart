import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/widgets/smart_widgets/worksheets_details/worksheets_details_view_model.dart';

import '../Themes.dart';

class SocialActivationWorksheetTemplateWidget extends StatelessWidget {
  SocialActivationWorksheetTemplateWidget(
      this.selectedDay, this.viewModel, this.cameBackFromCBTPage);
  final DateTime selectedDay;
  final WorksheetsDetailsViewModel viewModel;
  final bool cameBackFromCBTPage;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        viewModel
            .updateData("SocialActivation", 7, "", selectedDay)
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
                  viewModel
                      .updateData("SocialActivation", 7, "", selectedDay)
                      .whenComplete(() =>
                          viewModel.goBackToPreviousPage(cameBackFromCBTPage));
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
                      "Social Activation",
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
                          itemCount:
                              viewModel.buildSocialActivationModelBoxes.length,
                          itemBuilder: (context, index) {
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
                                    viewModel.buildSocialActivationModelBoxes[
                                            index]["title"] +
                                        " •",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 0.015 * height),
                                    padding: EdgeInsets.only(
                                        top: 0.02 * height,
                                        left: 0.03 * width,
                                        right: 0.03 * width,
                                        bottom: 0.02 * height),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: TextField(
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      controller: viewModel
                                              .buildSocialActivationModelBoxes[
                                          index]["controller"],
                                      maxLines: null,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.white,
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
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
                                            color: Colors.white.withOpacity(0.7)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                  ),
                                ],
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
