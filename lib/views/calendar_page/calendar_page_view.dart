import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'package:vitalminds/widgets/dumb_widgets/table_calendar/table_calendar_widget.dart';
import 'calendar_page_view_model.dart';

class CalendarPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ViewModelBuilder<CalendarPageViewModel>.reactive(
      onModelReady: (viewModel) => viewModel.initialise(),
      builder:
          (BuildContext context, CalendarPageViewModel viewModel, Widget _) {
        return Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.1),
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  padding: EdgeInsets.only(
                    top: height * 0.02,
                    left: width * 0.05,
                    bottom: height * 0.02,
                    right: width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: Text("Quote of the day",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                // color: Color.fromRGBO(123, 138, 160, 1),
                              color: Colors.white,
                                fontSize: width / 27.5,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400)),
                      ),
                      Text(viewModel.data,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              // color: Color.fromRGBO(39, 51, 74, 1),
                            color: Colors.white,
                              fontSize: width / 27.5,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                TableCalendarWidget(
                  viewModel: viewModel,
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.05, bottom: height * 0.02),
                  height: height * 0.07,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Themes.color),
                  child: new TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors.black;
                        },
                      ),
                    ),
                    onPressed: () {
                      viewModel.navigateToDetailsTabPage();
                    },
                    child: Text("Go To Journal",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width / 24,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => CalendarPageViewModel(),
    );
  }
}
