import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vitalminds/views/analytics_page/analytics_page_view_model.dart';

import '../Themes.dart';

class MoodGraphWidget extends StatelessWidget {
  final AnalyticsPageViewModel viewModel;
  const MoodGraphWidget({
    Key key,
    this.viewModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.9,
      margin: EdgeInsets.symmetric(vertical: height * 0.02),
      padding: EdgeInsets.only(
          left: width * 0.01, right: width * 0.03, top: height * 0.015, bottom:height * 0.015),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(color: Themes.color.withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: width * 0.02, right: width * 0.03),
                child: Text(
                  "Mood",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400),
                ),
              ),
              CircleAvatar(radius: width / 100, backgroundColor: Colors.white),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.02),
            child: Divider(thickness: 2, color: Colors.white.withOpacity(0.3),),
          ),
          Container(
            height: height * 0.38,
            padding: EdgeInsets.only(top: height * 0.015, bottom: height * 0.04),
            child: Row(
              children: [
                Container(
                  height: height * 0.38,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: width * 0.02,
                          right: width * 0.02,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/Icon awesome-laugh.svg',
                          height: width * 0.06,
                          width: width * 0.06,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: width * 0.02,
                          right: width * 0.02,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/Icon awesome-smile.svg',
                          height: width * 0.06,
                          width: width * 0.06,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: width * 0.02,
                          right: width * 0.02,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/Icon awesome-smile-1.svg',
                          height: width * 0.06,
                          width: width * 0.06,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: width * 0.02,
                          right: width * 0.02,
                          //top: height/50
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/Icon awesome-sad-tear.svg',
                          height: width * 0.06,
                          width: width * 0.06,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: width * 0.02,
                          right: width * 0.02,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/Icon awesome-angry.svg',
                          height: width * 0.06,
                          width: width * 0.06,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: width * 0.02,
                            right: width * 0.02,
                            bottom: height / 20),
                        child: SvgPicture.asset(
                          'assets/icons/Icon awesome-tired.svg',
                          height: width * 0.06,
                          width: width * 0.06,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.38,
                  width: width * 0.74,
                  child: viewModel.isBusy || viewModel.loading
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SpinKitWanderingCubes(
                            color: Colors.white,
                            size: 80,
                            duration: Duration(milliseconds: 1200),
                          ),
                        )
                      : BarChart(
                          BarChartData(

                            backgroundColor: Colors.transparent,
                            alignment: BarChartAlignment.spaceAround,
                            //groupsSpace: width * 0.02,
                            maxY: 11 * 16.666666667,
                            barTouchData: BarTouchData(
                              enabled: false,
                              handleBuiltInTouches: true,
                              touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: Colors.transparent,
                                tooltipPadding: const EdgeInsets.all(0),
                                tooltipMargin: 8,
                              ),
                            ),
                            gridData: FlGridData(
                              drawHorizontalLine: false,
                              drawVerticalLine: false,
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: SideTitles(
                                showTitles: true,
                                getTextStyles: (c,value) => const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    fontSize: 12),
                                margin: 20,
                                getTitles: (double value) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return 'Mon';
                                    case 1:
                                      return 'Tue';
                                    case 2:
                                      return 'Wed';
                                    case 3:
                                      return 'Thu';
                                    case 4:
                                      return 'Fri';
                                    case 5:
                                      return 'Sat';
                                    case 6:
                                      return 'Sun';
                                    default:
                                      return '';
                                  }
                                },
                              ),
                              topTitles: SideTitles(showTitles: false),
                              leftTitles: SideTitles(showTitles: false),
                              rightTitles: SideTitles(showTitles: false),
                            ),
                            borderData: FlBorderData(
                              border: Border(
                                  top: BorderSide.none,
                                  right: BorderSide.none,
                                  left: BorderSide(color: Colors.white),
                                  bottom: BorderSide(color: Colors.white)),
                              show: true,
                            ),
                            barGroups: List.generate(7, (index) {
                              return BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                      toY: viewModel.moodGraphList[0][index],
                                      width: width / 46,
                                      colors: [
                                        viewModel.maximumMorningMood.toInt() ==
                                                viewModel.moodGraphList[0]
                                                        [index]
                                                    .toInt()
                                            ? viewModel.maxColor
                                            : Colors.white
                                      ],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(height / 500),
                                        topRight: Radius.circular(height / 500),
                                      )),
                                  BarChartRodData(
                                      toY: viewModel.moodGraphList[1][index],
                                      width: width / 46,
                                      colors: [
                                        viewModel.maximumAfternoonMood
                                                    .toInt() ==
                                                viewModel.moodGraphList[1]
                                                        [index]
                                                    .toInt()
                                            ? viewModel.maxColor.withOpacity(0.7)
                                            : Colors.white.withOpacity(0.7)
                                      ],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(height / 500),
                                        topRight: Radius.circular(height / 500),
                                      )),
                                  BarChartRodData(
                                      toY: viewModel.moodGraphList[2][index],
                                      width: width / 46,
                                      colors: [
                                        viewModel.maximumEveningMood.toInt() ==
                                                viewModel.moodGraphList[2]
                                                        [index]
                                                    .toInt()
                                            ? viewModel.maxColor.withOpacity(0.4)
                                            : Colors.white.withOpacity(0.4)
                                      ],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(height / 500),
                                        topRight: Radius.circular(height / 500),
                                      ))
                                ],
                              );
                            }),
                          ),
                        ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                        ),
                        width: width / 50,height: width/50,),
                    Text(" - ", style: TextStyle(color: Colors.white),),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: viewModel.maxColor
                      ),
                      width: width / 50,height: width/50,),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.01),
                      child: Text(
                        "Morning",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.7)
                      ),
                      width: width / 50,height: width/50,),
                    Text(" - ", style: TextStyle(color: Colors.white),),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: viewModel.maxColor.withOpacity(0.7)
                      ),
                      width: width / 50,height: width/50,),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.01),
                      child: Text(
                        "Afternoon",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.4) 
                      ),
                      width: width / 50,height: width/50,),
                    Text(" - ", style: TextStyle(color: Colors.white),),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: viewModel.maxColor.withOpacity(0.4)
                      ),
                      width: width / 50,height: width/50,),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.01),
                      child: Text(
                        "Evening",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
