import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'worksheets_widget_view_model.dart';

class WorksheetsWidget extends StatelessWidget {
  final DateTime selectedDay;
  WorksheetsWidget({Key key, @required this.selectedDay}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorksheetsWidgetViewModel>.reactive(
      builder: (BuildContext context, WorksheetsWidgetViewModel viewModel,
          Widget _) {
        return Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
          child:
              //TODO : ADD LOADING ANIMATION IF IT IS REQUIRED
              // viewModel.isBusy ? Center(
              //           child: SpinKitWanderingCubes(
              //             color: Themes.color,
              //             size: 40,
              //             duration: Duration(milliseconds: 1200),
              //           ),
              //         ):
              ListView(
            padding: EdgeInsets.all(0),
            physics: BouncingScrollPhysics(),
            children: [
              buildList(context, viewModel, "Stress relief",
                  viewModel.stressWorksheets),
              buildList(context, viewModel, "Increase your productivity",
                  viewModel.productivityorksheets),
              buildList(context, viewModel, "Simplifying Life",
                  viewModel.simplifyingLife),
              buildList(context, viewModel, "Reflection", viewModel.reflection),
              buildList(
                  context, viewModel, "Reduce Anxiety", viewModel.anxiety),
              buildList(
                  context, viewModel, "Fight Depression", viewModel.depression),
            ],
          ),
        );
      },
      viewModelBuilder: () => WorksheetsWidgetViewModel(selectedDay),
    );
  }
}

Widget buildList(BuildContext context, WorksheetsWidgetViewModel viewModel,
    String title, List list) {
  dynamic height = MediaQuery.of(context).size.height;
  dynamic width = MediaQuery.of(context).size.width;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$title",
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      Container(
        height: height * 0.19,
        width: width * 0.95,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  viewModel.navigateToDetailsPage(title, list[index]["title"], context);
                },
                child: Container(
                  margin:
                      EdgeInsets.only(top: height * 0.02, right: 0.02 * width),
                  height: 0.1 * height,
                  width: 0.38 * width,
                  padding: EdgeInsets.only(
                      top: 0.01 * height,
                      left: 0.027 * width,
                      right: 0.06 * width),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Color.fromRGBO(173, 173, 173, 0.15))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${list[index]["title"]}",
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.01 * height),
                            child: Text(
                              "${list[index]["time"]}",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                          )
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 0.015 * height),
                          child: viewModel.completedWorksheetsList.contains(
                                  list[index]["title"]
                                      .replaceAll(new RegExp(r"\s+"), ""))
                              ? Text(
                                  "Completed  ✓",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                )
                              : Text(
                                  "Not Completed",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.6)),
                                ))
                    ],
                  ),
                ),
              );
            }),
      ),
      Container(
        width: height * 0.95,
        height: 0.04 * height,
      )
    ],
  );
}
