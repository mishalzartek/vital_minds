import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/main.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'package:vitalminds/widgets/dumb_widgets/info_dialog.dart';
import 'edit_habits_page_view_model.dart';

class EditHabitsPageView extends StatelessWidget {
  final DateTime selectedDate;
  const EditHabitsPageView({Key key, this.selectedDate}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var topPadding = MediaQuery.of(context).padding.top;
    return ViewModelBuilder<EditHabitsPageViewModel>.reactive(
      builder:
          (BuildContext context, EditHabitsPageViewModel viewModel, Widget _) {
        return Scaffold(
            body: viewModel.isBusy
                ? Center(
                    child: SpinKitWanderingCubes(
                      color: Colors.white,
                      size: 40,
                      duration: Duration(milliseconds: 1200),
                    ),
                  )
                : Container(
                    height: height,
                    width: width,
                    padding: EdgeInsets.only(
                        top: height * 0.02 + topPadding,
                        bottom: height * 0.02,
                        left: width * 0.05,
                        right: width * 0.05),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Themes.color, BlendMode.modulate),
                          image: myImage,
                          fit: BoxFit.cover),
                    ),
                    child: new BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                    radius: width / 28,
                                    child: IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(
                                          Icons.chevron_left,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          viewModel.goBack();
                                        }),
                                  ),
                                  SizedBox(
                                    width: width * 0.06,
                                  ),
                                  Text(
                                    "Habits",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              InfoDialog(type: 6),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => viewModel.addHabit(),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.1),
                                    border:
                                        Border.all(color: Colors.transparent),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04,
                                    vertical: height * 0.015),
                                margin: EdgeInsets.only(
                                  top: topPadding,
                                ),
                                child: Text(
                                  "Add new habit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: viewModel.habitsModel.habits.length,
                              itemBuilder: (context, index) {
                                return Slidable(
                                    startActionPane: ActionPane(
                                      motion: DrawerMotion(),
                                      extentRatio: 0.25,
                                      children: [
                                        SlidableAction(
                                          label: 'Delete',
                                          backgroundColor:
                                              Colors.white.withOpacity(0.6),
                                          foregroundColor: Themes.color,
                                          icon: Icons.delete,
                                          onPressed: (c) =>
                                              viewModel.deleteHabit(index),
                                        ),
                                        // SlidableAction(
                                        //   label: 'Edit',
                                        //   backgroundColor: Colors.white,
                                        //   foregroundColor: Themes.color,
                                        //   icon: Icons.edit,
                                        //   onPressed: (c) =>
                                        //       viewModel.editHabit(index),
                                        // ),
                                      ],
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        top: height * 0.015,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.025,
                                          vertical: height * 0.02),
                                      width: width,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.1),
                                          border: Border.all(
                                              color: Colors.transparent),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: width * 0.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  viewModel.habitsModel
                                                      .habits[index].title
                                                      .trim(),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: height * 0.01),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "M ",
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12,
                                                          color: viewModel
                                                                          .habitsModel
                                                                          .habits[
                                                                              index]
                                                                          .days[
                                                                      0] ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.white
                                                                  .withOpacity(
                                                                      0.6),
                                                        ),
                                                      ),
                                                      Text(
                                                        "T ",
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12,
                                                          color: viewModel
                                                                          .habitsModel
                                                                          .habits[
                                                                              index]
                                                                          .days[
                                                                      1] ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.white
                                                                  .withOpacity(
                                                                      0.6),
                                                        ),
                                                      ),
                                                      Text(
                                                        "W ",
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12,
                                                          color: viewModel
                                                                          .habitsModel
                                                                          .habits[
                                                                              index]
                                                                          .days[
                                                                      2] ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.white
                                                                  .withOpacity(
                                                                      0.6),
                                                        ),
                                                      ),
                                                      Text(
                                                        "T ",
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12,
                                                          color: viewModel
                                                                          .habitsModel
                                                                          .habits[
                                                                              index]
                                                                          .days[
                                                                      3] ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.white
                                                                  .withOpacity(
                                                                      0.6),
                                                        ),
                                                      ),
                                                      Text(
                                                        "F ",
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12,
                                                          color: viewModel
                                                                          .habitsModel
                                                                          .habits[
                                                                              index]
                                                                          .days[
                                                                      4] ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.white
                                                                  .withOpacity(
                                                                      0.6),
                                                        ),
                                                      ),
                                                      Text(
                                                        "S ",
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12,
                                                          color: viewModel
                                                                          .habitsModel
                                                                          .habits[
                                                                              index]
                                                                          .days[
                                                                      5] ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.white
                                                                  .withOpacity(
                                                                      0.6),
                                                        ),
                                                      ),
                                                      Text(
                                                        "S",
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12,
                                                          color: viewModel
                                                                          .habitsModel
                                                                          .habits[
                                                                              index]
                                                                          .days[
                                                                      6] ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.white
                                                                  .withOpacity(
                                                                      0.6),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          viewModel.habitsModel.habits[index]
                                                      .status ==
                                                  true
                                              ? GestureDetector(
                                                  onTap: () => viewModel
                                                      .changeStatus(index),
                                                  child: Text(
                                                    "Active ✓",
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () => viewModel
                                                      .changeStatus(index),
                                                  child: Text(
                                                    "Inactive ✓",
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      color: Colors.white
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
      },
      viewModelBuilder: () => EditHabitsPageViewModel(selectedDate),
    );
  }
}
