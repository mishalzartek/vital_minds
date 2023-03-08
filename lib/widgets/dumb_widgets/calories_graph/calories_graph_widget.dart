import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/views/analytics_page/analytics_page_view_model.dart';
import '../Themes.dart';

class CaloriesGraphWidget extends StatelessWidget {
  final AnalyticsPageViewModel viewModel;
  const CaloriesGraphWidget({
    Key key,
    this.viewModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(viewModel.maximumCaloriesBurned);
    print(viewModel.maximumCaloriesGained);
    return Container(
      height: viewModel.isBusy || viewModel.loading
          ? MediaQuery.of(context).size.height / 1.7
          : viewModel.maximumCaloriesGained == 0.0 &&
                  viewModel.maximumCaloriesBurned == 0.0
              ? 120
              : MediaQuery.of(context).size.height / 1.7,
      width: width * 0.9,
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.02),
      padding: EdgeInsets.only(
          left: width * 0.03, right: width * 0.03, top: height * 0.02),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(color: Themes.color.withOpacity(0.2))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: width * 0.02,
                  right: width * 0.03,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Calories (in cal)",
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
          Container(
              padding: EdgeInsets.only(
                top: height * 0.01,
              ),
              child: Divider(
                thickness: 2,
                color: Colors.white.withOpacity(0.3),
              )),
          Container(
            width: width * 0.8,
            alignment: Alignment.topCenter,
            height: viewModel.isBusy || viewModel.loading
                ? height * 0.45
                : viewModel.maximumCaloriesGained == 0.0 &&
                        viewModel.maximumCaloriesBurned == 0.0
                    ? 45
                    : height * 0.45,
            child: viewModel.isBusy || viewModel.loading
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SpinKitWanderingCubes(
                      color: Colors.white,
                      size: 80,
                      duration: Duration(milliseconds: 1200),
                    ),
                  )
                : viewModel.maximumCaloriesGained == 0.0 &&
                        viewModel.maximumCaloriesBurned == 0.0
                    ? Text(
                        "\nNo Calories have been tracked yet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: height * 0.02,
                        ),
                        child: BarChart(
                          BarChartData(
                            gridData: FlGridData(
                                drawVerticalLine: false,
                                drawHorizontalLine: false),
                            backgroundColor: Colors.transparent,
                            alignment: BarChartAlignment.spaceEvenly,
                            groupsSpace: width * 0.03,
                            maxY: (viewModel.maximumCaloriesGained >
                                    viewModel.maximumCaloriesBurned +
                                        (viewModel.maximumCaloriesBurned / 10))
                                ? viewModel.maximumCaloriesGained
                                : viewModel.maximumCaloriesBurned +
                                    (viewModel.maximumCaloriesBurned / 10),
                            barTouchData: BarTouchData(
                                enabled: true,
                                touchTooltipData: BarTouchTooltipData(
                                  tooltipBgColor: Colors.transparent,
                                  tooltipPadding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  tooltipMargin: 4,
                                  getTooltipItem: (
                                    BarChartGroupData group,
                                    int groupIndex,
                                    BarChartRodData rod,
                                    int rodIndex,
                                  ) {
                                    return BarTooltipItem(
                                      rod.toY.round().toString(),
                                      TextStyle(
                                        color: rodIndex == 0
                                            ? (viewModel.caloriesGraphList[0]
                                                        [groupIndex] ==
                                                    viewModel
                                                        .maximumCaloriesGained
                                                ? viewModel.maxColor
                                                : Colors.white)
                                            : (viewModel.caloriesGraphList[1]
                                                        [groupIndex] ==
                                                    viewModel
                                                        .maximumCaloriesBurned
                                                ? viewModel.maxColor
                                                    .withOpacity(0.6)
                                                : Colors.white
                                                    .withOpacity(0.6)),
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                )),
                            titlesData: FlTitlesData(
                              show: true,
                              topTitles: SideTitles(showTitles: false),
                              bottomTitles: SideTitles(
                                showTitles: true,
                                getTextStyles: (c, value) => const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    fontSize: 11),
                                margin: 10,
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
                              leftTitles: SideTitles(
                                reservedSize: width * 0.08,
                                showTitles: true,
                                interval: ((viewModel.maximumCaloriesGained ==
                                            0 &&
                                        viewModel.maximumCaloriesBurned == 0)
                                    ? 5
                                    : ((viewModel.maximumCaloriesGained >
                                            viewModel.maximumCaloriesBurned)
                                        ? viewModel.maximumCaloriesGained / 10
                                        : viewModel.maximumCaloriesBurned /
                                            10)),
                                getTitles: (value) {
                                  return value.round().toString();
                                },
                                getTextStyles: (c, value) => const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    fontSize: 12),
                              ),
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
                                  barsSpace: width * 0.01,
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                        toY: viewModel.caloriesGraphList[0]
                                            [index],
                                        width: width / 40,
                                        colors: [viewModel.maxColor],
                                        borderRadius: BorderRadius.only(
                                          topLeft:
                                              Radius.circular(height / 200),
                                          topRight:
                                              Radius.circular(height / 200),
                                        )),
                                    BarChartRodData(
                                        toY: viewModel.caloriesGraphList[1]
                                            [index],
                                        width: width / 40,
                                        colors: [
                                          viewModel.maxColor.withOpacity(0.6)
                                        ],
                                        borderRadius: BorderRadius.only(
                                          topLeft:
                                              Radius.circular(height / 200),
                                          topRight:
                                              Radius.circular(height / 200),
                                        )),
                                  ],
                                  showingTooltipIndicators: (viewModel
                                                      .caloriesGraphList[0]
                                                  [index] ==
                                              viewModel.maximumCaloriesGained &&
                                          viewModel.maximumCaloriesGained !=
                                              0 &&
                                          viewModel.caloriesGraphList[1]
                                                  [index] ==
                                              viewModel.maximumCaloriesBurned &&
                                          viewModel.maximumCaloriesBurned != 0
                                      ? [0, 1]
                                      : (viewModel.caloriesGraphList[0]
                                                      [index] ==
                                                  viewModel
                                                      .maximumCaloriesGained &&
                                              viewModel.maximumCaloriesGained !=
                                                  0
                                          ? [0]
                                          : (viewModel.caloriesGraphList[1]
                                                          [index] ==
                                                      viewModel
                                                          .maximumCaloriesBurned &&
                                                  viewModel.maximumCaloriesBurned !=
                                                      0
                                              ? [1]
                                              : []))));
                            }),
                          ),
                        ),
                      ),
          ),
          viewModel.maximumCaloriesGained != 0.0 &&
                  viewModel.maximumCaloriesBurned != 0.0
              ? Padding(
                  padding: EdgeInsets.only(bottom: height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: width * 0.4,
                      ),
                      CircleAvatar(
                        radius: width / 100,
                        backgroundColor: viewModel.maxColor,
                      ),
                      Text(
                        "Gained",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400),
                      ),
                      CircleAvatar(
                        radius: width / 100,
                        backgroundColor: viewModel.maxColor.withOpacity(0.6),
                      ),
                      Text(
                        "Burned",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:vitalminds/views/analytics_page/analytics_page_view_model.dart';
// import 'package:vitalminds/widgets/smart_widgets/health/health_view_model.dart';

// import '../Themes.dart';

// class CaloriesGraphWidget extends StatelessWidget {
//   final AnalyticsPageViewModel viewModel;
//   final HealthViewModel healthViewModel;
//   const CaloriesGraphWidget({
//     Key key,
//     this.viewModel,
//     this.healthViewModel,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Container(
//       width: width * 0.9,
//       margin: EdgeInsets.symmetric(vertical: height * 0.02),
//       padding: EdgeInsets.only(
//           left: width * 0.01,
//           right: width * 0.03,
//           top: height * 0.015,
//           bottom: height * 0.015),
//       decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(width * 0.03),
//           border: Border.all(color: Themes.color.withOpacity(0.2))),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 margin:
//                     EdgeInsets.only(left: width * 0.02, right: width * 0.03),
//                 child: Text(
//                   "Calories",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//               CircleAvatar(radius: width / 100, backgroundColor: Colors.white),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: width * 0.02),
//             child: Divider(
//               thickness: 2,
//               color: Colors.white.withOpacity(0.3),
//             ),
//           ),
//           Container(
//             height: height * 0.50,
//             alignment: Alignment.topRight,
//             padding:
//                 EdgeInsets.only(top: height * 0.015, bottom: height * 0.04),
//             child: Row(
//               children: [
//                 Container(
//                   height: height * 0.45,
//                   color: Colors.red,
//                   padding: EdgeInsets.only(
//                     right: height * 0.01,
//                     left: height * 0.005,
//                     bottom: height * 0.06,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text(
//                         '4K',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         '3.5K',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         '3K',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         '2.5K',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         '2K',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         '1.5K',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         '1K',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         '500',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: height * 0.55,
//                   width: width * 0.74,
//                   child: viewModel.isBusy || viewModel.loading
//                       ? Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: SpinKitWanderingCubes(
//                             color: Colors.white,
//                             size: 80,
//                             duration: Duration(milliseconds: 1200),
//                           ),
//                         )
//                       : BarChart(
//                           BarChartData(
//                             backgroundColor: Colors.transparent,
//                             alignment: BarChartAlignment.spaceAround,
//                             //groupsSpace: width * 0.02,
//                             maxY: 4000,
//                             barTouchData: BarTouchData(
//                               enabled: false,
//                               handleBuiltInTouches: true,
//                               touchTooltipData: BarTouchTooltipData(
//                                 tooltipBgColor: Colors.transparent,
//                                 tooltipPadding: const EdgeInsets.all(0),
//                                 tooltipMargin: 8,
//                               ),
//                             ),
//                             gridData: FlGridData(
//                               drawHorizontalLine: false,
//                               drawVerticalLine: false,
//                             ),
//                             titlesData: FlTitlesData(
//                               show: true,
//                               bottomTitles: SideTitles(
//                                 showTitles: true,
//                                 getTextStyles: (c, value) => const TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'Roboto',
//                                     fontSize: 12),
//                                 margin: 20,
//                                 getTitles: (double value) {
//                                   switch (value.toInt()) {
//                                     case 0:
//                                       return 'Mon';
//                                     case 1:
//                                       return 'Tue';
//                                     case 2:
//                                       return 'Wed';
//                                     case 3:
//                                       return 'Thu';
//                                     case 4:
//                                       return 'Fri';
//                                     case 5:
//                                       return 'Sat';
//                                     case 6:
//                                       return 'Sun';
//                                     default:
//                                       return '';
//                                   }
//                                 },
//                               ),
//                               topTitles: SideTitles(showTitles: false),
//                               leftTitles: SideTitles(showTitles: false),
//                               rightTitles: SideTitles(showTitles: false),
//                             ),
//                             borderData: FlBorderData(
//                               border: Border(
//                                   top: BorderSide.none,
//                                   right: BorderSide.none,
//                                   left: BorderSide(color: Colors.white),
//                                   bottom: BorderSide(color: Colors.white)),
//                               show: true,
//                             ),
//                             barGroups: List.generate(7, (index) {
//                               return BarChartGroupData(
//                                 x: index,
//                                 barRods: [
//                                   BarChartRodData(
//                                     toY: 1500,
//                                     width: width / 46,
//                                     colors: [Colors.white],
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(height / 500),
//                                       topRight: Radius.circular(height / 500),
//                                     ),
//                                   ),
//                                   BarChartRodData(
//                                     // toY: healthViewModel.caloriesBurnedSum,
//                                     toY: 2000,
//                                     width: width / 46,
//                                     colors: [Colors.white.withOpacity(0.7)],
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(height / 500),
//                                       topRight: Radius.circular(height / 500),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             }),
//                           ),
//                         ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(bottom: height * 0.01),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle, color: Colors.white),
//                       width: width / 50,
//                       height: width / 50,
//                     ),
//                     Text(
//                       " - ",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle, color: viewModel.maxColor),
//                       width: width / 50,
//                       height: width / 50,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: width * 0.01),
//                       child: Text(
//                         "Morning",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w400),
//                       ),
//                     )
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white.withOpacity(0.7)),
//                       width: width / 50,
//                       height: width / 50,
//                     ),
//                     Text(
//                       " - ",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: viewModel.maxColor.withOpacity(0.7)),
//                       width: width / 50,
//                       height: width / 50,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: width * 0.01),
//                       child: Text(
//                         "Afternoon",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white.withOpacity(0.4)),
//                       width: width / 50,
//                       height: width / 50,
//                     ),
//                     Text(
//                       " - ",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: viewModel.maxColor.withOpacity(0.4)),
//                       width: width / 50,
//                       height: width / 50,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: width * 0.01),
//                       child: Text(
//                         "Evening",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w400),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
