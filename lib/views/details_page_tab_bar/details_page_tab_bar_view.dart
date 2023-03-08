import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/main.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'package:vitalminds/widgets/smart_widgets/cbt_personal/cbt_personal_widget.dart';
import 'package:vitalminds/widgets/smart_widgets/health/health_widget.dart';
import 'package:vitalminds/widgets/smart_widgets/journal/journal_widget.dart';
import 'package:vitalminds/widgets/smart_widgets/schedule/schedule_widget.dart';
import 'details_page_tab_bar_view_model.dart';

class DetailsPageTabBarView extends StatelessWidget {
  final DateTime selectedDate;
  final int index;

  DetailsPageTabBarView({Key key, @required this.selectedDate,this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var topPadding = MediaQuery.of(context).padding.top;
    return ViewModelBuilder<DetailsPageTabBarViewModel>.reactive(
      builder: (BuildContext context, DetailsPageTabBarViewModel viewModel,
          Widget _) {
        return DefaultTabController(
          initialIndex: index??0,
          length: 4,
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(Themes.color, BlendMode.modulate),
                    image: myImage,
                    fit: BoxFit.cover),
              ),
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: topPadding + height * 0.02,
                            left: width * 0.05,
                            right: width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                radius: width / 30,
                                child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      viewModel.navigateToHome(1);
                                    }),
                              ),
                            Container(
                              width: width * 0.25,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white.withOpacity(0.2),
                                    radius: width / 30,
                                    child: IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(
                                          Icons.chevron_left,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          viewModel.goToPrevDate(context);
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.001, right: width * 0.001),
                                child: Text(
                                  DateFormat('dd/MM/yyyy, EEEE')
                                      .format(selectedDate),
                                  // "11th November, 2020",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )),
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.2),
                              radius: width / 30,
                              child: IconButton(
                                  color: Colors.white.withOpacity(0.2),
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(
                                    Icons.chevron_right,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    viewModel.goToNextDate(context);
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.035, vertical: height * 0.02),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            border: Border.all(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: TabBar(
                          labelColor: Colors.white,
                          labelStyle: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          unselectedLabelColor: Colors.white.withOpacity(0.4),
                          unselectedLabelStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                          indicator: UnderlineTabIndicator(
                            borderSide:
                                BorderSide(width: 3, color: Colors.white),
                          ),
                          indicatorPadding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          indicatorWeight: 5.0,
                          tabs: [
                            Tab(text: "Journal"),
                            Tab(text: "Health"),
                            Tab(text: "Schedule"),
                            Tab(text: "CBT")
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.73,
                        width: width,
                        child: TabBarView(
                          children: [
                            JournalWidget(selectedDate: viewModel.selectedDate),
                            HealthWidget(selectedDate: viewModel.selectedDate),
                            ScheduleWidget(
                                selectedDate: viewModel.selectedDate),
                            CbtPersonalWidget(
                                selectedDate: viewModel.selectedDate),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => DetailsPageTabBarViewModel(selectedDate),
    );
  }
}
