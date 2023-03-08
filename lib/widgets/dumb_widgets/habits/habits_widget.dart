import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/views/edit_habits_page/edit_habits_page_view.dart';
import 'package:vitalminds/widgets/dumb_widgets/info_dialog.dart';
import 'package:vitalminds/widgets/smart_widgets/health/health_view_model.dart';

import '../Themes.dart';

class HabitsWidget extends StatelessWidget {
  final HealthViewModel viewModel;
  const HabitsWidget({
    Key key,
    this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 0.01),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Habits",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.02),
                    child: InfoDialog(type: 3),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditHabitsPageView(
                            selectedDate: viewModel.selectedDate)),
                  ).then((value) async => await viewModel.futureToRun());
                },
                child: Text(
                  "Add/Edit active habits",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.white.withOpacity(0.6),
          ),
          viewModel.isBusy
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SpinKitWanderingCubes(
                      color: Colors.white,
                      size: 40,
                      duration: Duration(milliseconds: 1200),
                    ),
                  ),
                )
              : viewModel.healthModel == null ||
                      viewModel.healthModel.habits == null ||
                      viewModel.healthModel.habits.length == 0
                  ? Center(
                      child: Text("\nLooks like you have a day off today!",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0),
                          textAlign: TextAlign.left),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: viewModel.healthModel.habits.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          startActionPane: ActionPane(
                            motion: DrawerMotion(),
                            extentRatio: 0.25,
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.transparent,
                                icon: Icons.delete,
                                foregroundColor: Colors.white,
                                onPressed: (c) => viewModel.deleteHabit(index),
                              ),
                            ],
                          ),
                          child: Theme(
                            data:
                                ThemeData(unselectedWidgetColor: Colors.white),
                            child: CheckboxListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "${index + 1}) ${viewModel.healthModel.habits[index].title.trim()}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.0),
                                textAlign: TextAlign.left,
                              ),
                              activeColor: Colors.white,
                              checkColor: Themes.color,
                              tileColor: Colors.white,
                              value: viewModel.healthModel.habits[index].status,
                              onChanged: (value) => viewModel
                                  .habitsCheckboxController(value, index),
                            ),
                          ),
                        );
                      },
                    ),
        ],
      ),
    );
  }
}
