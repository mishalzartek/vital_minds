import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:vitalminds/views/analytics_page/analytics_page_view_model.dart';

import '../Themes.dart';

class HabitsGraphWidget extends StatelessWidget {
  final AnalyticsPageViewModel viewModel;
  const HabitsGraphWidget({
    Key key,
    this.viewModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.9,
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.02),
      padding: EdgeInsets.only(
          left: width * 0.03, right: width * 0.03, top: height * 0.015),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(color: Themes.color.withOpacity(0.2))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Habits",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: width / 40,
              ),
              CircleAvatar(radius: width / 100, backgroundColor: Colors.white),
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: height * 0.005),
              child: Divider(
                thickness: 2,
                color: Colors.white.withOpacity(0.3),
              )),
          Container(
            margin: EdgeInsets.only(bottom: height * 0.02),
            child: viewModel.isBusy || viewModel.loading
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SpinKitWanderingCubes(
                      color: Colors.white,
                      size: 80,
                      duration: Duration(milliseconds: 1200),
                    ),
                  )
                : viewModel.habitsData == null ||
                        viewModel.habitsData.length == 0
                    ? Text(
                        "\nNo habits have been tracked yet",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: viewModel.habitsData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "\n" +
                                              viewModel.habitsData[index]
                                                  ["habit"] +
                                              "\n",
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: height * 0.017),
                                          maxLines: null,
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        width: 2,
                                        // constraints: BoxConstraints.expand(),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children:
                                              List.generate(7, (listIndex) {
                                            return viewModel.habitsData[index]
                                                    ["active"][listIndex]
                                                ? CircleAvatar(
                                                    radius: height * 0.012,
                                                    backgroundColor:
                                                        viewModel.maxColor,
                                                    child: Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                      size: width * 0.04,
                                                    ),
                                                  )
                                                : viewModel.habitsData[index]
                                                        ["days"][listIndex]
                                                    ? CircleAvatar(
                                                        radius: height * 0.012,
                                                        backgroundColor:
                                                            Colors.white,
                                                      )
                                                    : CircleAvatar(
                                                        radius: height * 0.012,
                                                        backgroundColor: Colors
                                                            .white
                                                            .withOpacity(0.5),
                                                      );
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(height: 2),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 2,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 2,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "\nMon",
                                      style: TextStyle(
                                          fontSize: height * 0.015,
                                          color: Colors.white,
                                          fontFamily: 'Roboto'),
                                    ),
                                    Text("\nTue",
                                        style: TextStyle(
                                            fontSize: height * 0.015,
                                            color: Colors.white,
                                            fontFamily: 'Roboto')),
                                    Text("\nWed",
                                        style: TextStyle(
                                            fontSize: height * 0.015,
                                            color: Colors.white,
                                            fontFamily: 'Roboto')),
                                    Text("\nThu",
                                        style: TextStyle(
                                            fontSize: height * 0.015,
                                            color: Colors.white,
                                            fontFamily: 'Roboto')),
                                    Text("\nFri",
                                        style: TextStyle(
                                            fontSize: height * 0.015,
                                            color: Colors.white,
                                            fontFamily: 'Roboto')),
                                    Text("\nSat",
                                        style: TextStyle(
                                            fontSize: height * 0.015,
                                            color: Colors.white,
                                            fontFamily: 'Roboto')),
                                    Text("\nSun",
                                        style: TextStyle(
                                            fontSize: height * 0.015,
                                            color: Colors.white,
                                            fontFamily: 'Roboto')),
                                  ],
                                )),
                              ),
                            ],
                          )
                        ],
                      ),
          )
        ],
      ),
    );
  }
}
