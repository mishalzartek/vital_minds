import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/views/analytics_page/analytics_page_view_model.dart';
import '../Themes.dart';

class MoneyGraphWidget extends StatelessWidget {
  final AnalyticsPageViewModel viewModel;
  const MoneyGraphWidget({
    Key key,
    this.viewModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height / 1.8,
      width: width * 0.9,
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.02),
      padding: EdgeInsets.only(
          left: width * 0.01, right: width * 0.03, top: height * 0.01),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(color: Themes.color.withOpacity(0.2))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: width * 0.02, right: width * 0.03),
                alignment: Alignment.center,
                child: Text(
                  "Money Matters (in ₹)",
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
              margin:
                  EdgeInsets.only(left: width * 0.02, bottom: height * 0.03),
              child: Divider(
                thickness: 2,
                color: Colors.white.withOpacity(0.3),
              )),
          Container(
            width: width * 0.8,
            height: height * 0.45,
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
                      gridData: FlGridData(
                          drawVerticalLine: false, drawHorizontalLine: false),
                      backgroundColor: Colors.transparent,
                      alignment: BarChartAlignment.spaceEvenly,
                      groupsSpace: width * 0.03,
                      maxY: (viewModel.maximumIncomeValue >
                              viewModel.maximumExpenditureValue +
                                  (viewModel.maximumExpenditureValue / 10))
                          ? viewModel.maximumIncomeValue
                          : viewModel.maximumExpenditureValue +
                              (viewModel.maximumExpenditureValue / 10),
                      barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.transparent,
                            tooltipPadding:
                                const EdgeInsets.only(left: 10, right: 10),
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
                                      ? (viewModel.moneyGraphList[0]
                                                  [groupIndex] ==
                                              viewModel.maximumIncomeValue
                                          ? viewModel.maxColor
                                          : Colors.white)
                                      : (viewModel.moneyGraphList[1]
                                                  [groupIndex] ==
                                              viewModel.maximumExpenditureValue
                                          ? viewModel.maxColor.withOpacity(0.6)
                                          : Colors.white.withOpacity(0.6)),
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
                          interval: ((viewModel.maximumIncomeValue == 0 &&
                                  viewModel.maximumExpenditureValue == 0)
                              ? 5
                              : ((viewModel.maximumIncomeValue >
                                      viewModel.maximumExpenditureValue)
                                  ? viewModel.maximumIncomeValue / 10
                                  : viewModel.maximumExpenditureValue / 10)),
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
                                  toY: viewModel.moneyGraphList[0][index],
                                  width: width / 30,
                                  colors: [
                                    viewModel.moneyGraphList[0][index] ==
                                            viewModel.maximumIncomeValue
                                        ? viewModel.maxColor
                                        : Colors.white
                                  ],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(height / 200),
                                    topRight: Radius.circular(height / 200),
                                  )),
                              BarChartRodData(
                                  toY: viewModel.moneyGraphList[1][index],
                                  width: width / 30,
                                  colors: [
                                    viewModel.moneyGraphList[1][index] ==
                                            viewModel.maximumExpenditureValue
                                        ? viewModel.maxColor.withOpacity(0.5)
                                        : Colors.white.withOpacity(0.6)
                                  ],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(height / 200),
                                    topRight: Radius.circular(height / 200),
                                  )),
                            ],
                            showingTooltipIndicators: (viewModel
                                            .moneyGraphList[0][index] ==
                                        viewModel.maximumIncomeValue &&
                                    viewModel.maximumIncomeValue != 0 &&
                                    viewModel.moneyGraphList[1][index] ==
                                        viewModel.maximumExpenditureValue &&
                                    viewModel.maximumExpenditureValue != 0
                                ? [0, 1]
                                : (viewModel.moneyGraphList[0][index] ==
                                            viewModel.maximumIncomeValue &&
                                        viewModel.maximumIncomeValue != 0
                                    ? [0]
                                    : (viewModel.moneyGraphList[1][index] ==
                                                viewModel
                                                    .maximumExpenditureValue &&
                                            viewModel.maximumExpenditureValue !=
                                                0
                                        ? [1]
                                        : []))));
                      }),
                    ),
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: width * 0.4,
                ),
                CircleAvatar(
                    radius: width / 100, backgroundColor: Colors.white),
                Text(
                  "Income",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400),
                ),
                CircleAvatar(
                    radius: width / 100,
                    backgroundColor: Colors.white.withOpacity(0.6)),
                Text(
                  "Expenditure",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
