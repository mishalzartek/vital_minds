import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/widgets/dumb_widgets/calories_graph/calories_graph_widget.dart';
import 'package:vitalminds/widgets/dumb_widgets/habits_graph/habits_graph_widget.dart';
import 'package:vitalminds/widgets/dumb_widgets/money_graph/money_graph_widget.dart';
import 'package:vitalminds/widgets/dumb_widgets/mood_graph/mood_graph_widget.dart';
import 'analytics_page_view_model.dart';

class AnalyticsPageView extends StatelessWidget {
  final DateTime selectedDate;
  AnalyticsPageView({Key key, @required this.selectedDate, reactive: true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<AnalyticsPageViewModel>.reactive(
      builder:
          (BuildContext context, AnalyticsPageViewModel viewModel, Widget _) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    radius: width / 30,
                    child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          viewModel.changeLoading();
                          viewModel
                              .goToPrevDate()
                              .whenComplete(() => viewModel.changeLoading());
                        }),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          viewModel.changeLoading();
                          viewModel
                              .selectDate(context)
                              .whenComplete(() => viewModel.changeLoading());
                        },
                        child: Text(
                            DateFormat('EEEE').format(viewModel.currentDate) +
                                ',  ' +
                                '${DateFormat('dd-MM-yyyy').format(viewModel.currentDate)}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                                fontSize: 15.0)),
                      ),
                      // IconButton(
                      //     padding: EdgeInsets.all(0),
                      //     icon: Icon(
                      //       Icons.calendar_today,
                      //       color: Colors.black,
                      //     ),
                      //     onPressed: () {
                      //       viewModel.changeLoading();
                      //       viewModel
                      //           .selectDate(context)
                      //           .whenComplete(() => viewModel.changeLoading());
                      //     }),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    radius: width / 30,
                    child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          viewModel.changeLoading();
                          viewModel
                              .goToNextDate()
                              .whenComplete(() => viewModel.changeLoading());
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  HabitsGraphWidget(
                    viewModel: viewModel,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width,
                    child: MoodGraphWidget(viewModel: viewModel),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width,
                    child: CaloriesGraphWidget(viewModel: viewModel),
                  ),
                  // Container(
                  //   width: width,
                  //   height: height / 1.5,
                  //   child: MoneyGraphWidget(
                  //     viewModel: viewModel,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        );
      },
      viewModelBuilder: () => AnalyticsPageViewModel(),
    );
  }
}
