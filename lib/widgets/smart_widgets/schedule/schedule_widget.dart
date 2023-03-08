import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'package:vitalminds/widgets/dumb_widgets/info_dialog.dart';
import 'schedule_view_model.dart';

class ScheduleWidget extends StatelessWidget {
  final DateTime selectedDate;

  const ScheduleWidget({Key key, this.selectedDate}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<ScheduleViewModel>.reactive(
      builder: (BuildContext context, ScheduleViewModel viewModel, Widget _) {
        return Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width * 0.04),
          child: ListView(
            padding: EdgeInsets.all(0),
            physics: BouncingScrollPhysics(),
            children: [
              // AbsorbPointer(
              //   absorbing: viewModel.dateCheck,
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
              //     decoration: BoxDecoration(
              //         color: Color.fromRGBO(255, 255, 255, 0.1),
              //         border: Border.all(color: Colors.transparent),
              //         borderRadius: BorderRadius.all(Radius.circular(5))),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: <Widget>[
              //               Row(
              //                 children: [
              //                   Text("Reminders",
              //                       style: TextStyle(
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.w500,
              //                           fontFamily: "Roboto",
              //                           fontStyle: FontStyle.normal,
              //                           fontSize: 14.0),
              //                       textAlign: TextAlign.left),
              //                   SizedBox(
              //                     width: 7.0,
              //                   ),
              //                   Container(
              //                     width: 3,
              //                     height: 3,
              //                     decoration: BoxDecoration(
              //                       color: Colors.white,
              //                     ),
              //                   ),
              //                   SizedBox(width: width * 0.02,),
              //                   InfoDialog(type: 4)
              //                 ],
              //               ),
              //               GestureDetector(
              //                 onTap: () {
              //                   viewModel.addReminderDialog();
              //                 },
              //                 child: Text(
              //                   "Add",
              //                   style: TextStyle(
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.w600,
              //                       fontFamily: "Roboto",
              //                       fontStyle: FontStyle.normal,
              //                       fontSize: 12.0),
              //                   textAlign: TextAlign.left,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         Divider(
              //           color: Colors.white.withOpacity(0.4),
              //         ),
              //         viewModel.isBusy
              //             ? Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Center(
              //                   child: SpinKitWanderingCubes(
              //                     color: Colors.white,
              //                     size: 40,
              //                     duration: Duration(milliseconds: 1200),
              //                   ),
              //                 ),
              //               )
              //             : viewModel.scheduleModel.reminders.length == 0
              //                 ?
              //         Center(
              //                       child: Text("\nNo reminders for today\n",
              //                           style: TextStyle(
              //                               color: Colors.white.withOpacity(0.6),
              //                               fontWeight: FontWeight.w400,
              //                               fontFamily: "Roboto",
              //                               fontStyle: FontStyle.normal,
              //                               fontSize: 14.0),
              //                           textAlign: TextAlign.left),
              //                     )
              //                 : ListView.builder(
              //                     padding: EdgeInsets.zero,
              //                     shrinkWrap: true,
              //                     physics: NeverScrollableScrollPhysics(),
              //                     itemCount:
              //                         viewModel.scheduleModel.reminders.length,
              //                     itemBuilder: (BuildContext context, int index) {
              //                       return Slidable(
              //                         startActionPane: ActionPane(
              //                           motion: const DrawerMotion(),
              //                           extentRatio: 0.25,
              //                           children: [
              //                             SlidableAction(
              //                               backgroundColor: Colors.transparent,
              //                               foregroundColor: Colors.white,
              //                               icon: Icons.edit,
              //                               onPressed: (context) =>
              //                                   viewModel.editReminder(index),
              //                             ),
              //                             SlidableAction(
              //                               backgroundColor: Colors.transparent,
              //                               foregroundColor: Colors.white,
              //                               icon: Icons.delete,
              //                               onPressed: (context) =>
              //                                   viewModel.deleteReminder(index),
              //                             ),
              //                           ],
              //                         ),
              //                         child: Theme(
              //                           data: ThemeData(unselectedWidgetColor: Colors.white),
              //                           child: CheckboxListTile(
              //                             dense: true,
              //                             contentPadding: EdgeInsets.zero,
              //                             checkColor: Themes.color,
              //                             activeColor: Colors.white,
              //                             value: viewModel.scheduleModel
              //                                 .reminders[index].status,
              //                             onChanged: (value) => viewModel
              //                                 .updateReminderCheckbox(value, index),
              //                             title: Row(
              //                               children: <Widget>[
              //                                 Text(
              //                                   "${viewModel.scheduleModel.reminders[index].time}",
              //                                   style: TextStyle(
              //                                       color: Colors.white.withOpacity(0.6),
              //                                       fontWeight: FontWeight.w600,
              //                                       fontFamily: "Roboto",
              //                                       fontStyle: FontStyle.normal,
              //                                       fontSize: 14.0),
              //                                   textAlign: TextAlign.left,
              //                                 ),
              //                                 SizedBox(width: 8.0),
              //                                 Container(
              //                                   width: 0,
              //                                   height: 24,
              //                                   decoration: BoxDecoration(
              //                                     border: Border.all(
              //                                         color: Colors.white.withOpacity(0.6),
              //                                         width: 0.5),
              //                                   ),
              //                                 ),
              //                                 SizedBox(width: 8.0),
              //                                 Expanded(
              //                                   child: Text(
              //                                     "${viewModel.scheduleModel.reminders[index].title}",
              //                                     maxLines: null,
              //                                     style: TextStyle(
              //                                       color: Colors.white,
              //                                       fontWeight: FontWeight.w600,
              //                                       fontFamily: "Roboto",
              //                                       fontStyle: FontStyle.normal,
              //                                       fontSize: 14.0,
              //                                     ),
              //                                     textAlign: TextAlign.left,
              //                                   ),
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                         ),
              //                       );
              //                     },
              //                   ),
              //       ],
              //     ),
              //   ),
              // ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.02,
              // ),

              AbsorbPointer(
                absorbing: viewModel.dateCheck,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.01),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.1),
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Text("To Do List",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                width: 7.0,
                              ),
                              Container(
                                width: 3,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              InfoDialog(type: 5)
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              viewModel.addTodo();
                            },
                            child: Text(
                              "Add",
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
                        color: Colors.white.withOpacity(0.4),
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
                          : viewModel.scheduleModel.todo.length == 0
                              ? Center(
                                  child: Text(
                                      "\nLooks like you have a day off today!\n",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.6),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14.0),
                                      textAlign: TextAlign.left),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      viewModel.scheduleModel.todo.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Slidable(
                                      startActionPane: ActionPane(
                                        motion: const DrawerMotion(),
                                        extentRatio: 0.25,
                                        children: [
                                          SlidableAction(
                                            backgroundColor: Colors.transparent,
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            onPressed: (c) =>
                                                viewModel.deleteTodo(index),
                                          ),
                                          SlidableAction(
                                            backgroundColor: Colors.transparent,
                                            foregroundColor: Colors.white,
                                            icon: Icons.edit,
                                            onPressed: (context) =>
                                                viewModel.editTodo(index),
                                          ),
                                        ],
                                      ),
                                      child: Theme(
                                        data: ThemeData(
                                            unselectedWidgetColor:
                                                Colors.white),
                                        child: CheckboxListTile(
                                          title: Text(
                                            "${viewModel.scheduleModel.todo[index].title}",
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
                                          contentPadding: EdgeInsets.zero,
                                          value: viewModel
                                              .scheduleModel.todo[index].status,
                                          onChanged: (value) => viewModel
                                              .updateToDoCheckbox(value, index),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      viewModelBuilder: () => ScheduleViewModel(selectedDate),
    );
  }
}
