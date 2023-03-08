import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/views/worksheets/worksheets_view.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'package:vitalminds/widgets/smart_widgets/videos_home_page/videos_home_page_widget.dart';
import 'therapy_screen_view_model.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class TherapyScreenView extends StatelessWidget {
  TherapyScreenView(this.index);
  final int index;
  @override
  Widget build(BuildContext context) {
    dynamic height = MediaQuery.of(context).size.height;
    dynamic width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<TherapyScreenViewModel>.reactive(
      builder:
          (BuildContext context, TherapyScreenViewModel viewModel, Widget _) {
        return DefaultTabController(
            length: 2,
            initialIndex: index ?? 0,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding:
                    EdgeInsets.only(left: 0.04 * width, right: 0.04 * width),
                child: Column(
                  children: [
                    ButtonsTabBar(
                        physics: BouncingScrollPhysics(),
                        height: height * 0.06,
                        radius: 12,
                        labelStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        unselectedLabelStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.7)),
                        backgroundColor: Themes.color,
                        unselectedBackgroundColor:
                            Colors.white.withOpacity(0.1),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: width * 0.03),
                        tabs: [
                          Tab(
                            text: "     VIDEOS     ",
                          ),
                          Tab(
                            text: " WORKSHEETS ",
                          ),
                        ]),
                    Expanded(
                      child: TabBarView(children: [
                        VideosHomePageWidget(),
                        WorksheetsView(selectedDay: DateTime.now(),),
                      ]),
                    )
                  ],
                ),
              ),
            ));
      },
      viewModelBuilder: () => TherapyScreenViewModel(),
    );
  }
}
