import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/widgets/dumb_widgets/info_dialog.dart';
import 'package:vitalminds/widgets/smart_widgets/health/health_view_model.dart';

class ExerciseWidget extends StatelessWidget {
  final HealthViewModel viewModel;
  const ExerciseWidget({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 0.01),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.1),
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: <Widget>[
                Text(
                  "Exercise",
                  style: TextStyle(
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
                  decoration: BoxDecoration(color: Colors.white),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                InfoDialog(type: 6)
              ],
            ),
            GestureDetector(
              onTap: () => viewModel.addExcercise(),
              child: Text(
                "Add Exercise",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0),
                textAlign: TextAlign.left,
              ),
            ),
          ]),
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
              : viewModel.healthModel == null ||
                      viewModel.healthModel.excercise.length == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Were you active today?",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0),
                          textAlign: TextAlign.left),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: viewModel.healthModel.excercise.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                            startActionPane: ActionPane(
                              extentRatio: 0.25,
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  backgroundColor: Colors.transparent,
                                  icon: Icons.delete,
                                  foregroundColor: Colors.white,
                                  onPressed: (c) =>
                                      viewModel.deleteExcercise(index),
                                ),
                                SlidableAction(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  onPressed: (c) =>
                                      viewModel.editExcercise(index),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: width * 0.13,
                                        child: Text(
                                          "${viewModel.healthModel.excercise[index].time.trim()}",
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Roboto",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.0),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      SizedBox(width: 5.0),
                                      Container(
                                        width: 0,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              width: 0.5),
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Text(
                                          "${viewModel.healthModel.excercise[index].name.trim()}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Roboto",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.0,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 0,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              width: 0.5),
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Container(
                                        width: width * 0.285,
                                        child: Text(
                                          "${viewModel.healthModel.excercise[index].calories.trim()}",
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Roboto",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.0,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ));
                      },
                    ),
          viewModel.isBusy || viewModel.healthModel.excercise.length != 0
              ? Column(
                  children: [
                    Divider(color: Colors.white.withOpacity(0.6)),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text("Total calories burned",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.0),
                              textAlign: TextAlign.left),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text("${viewModel.caloriesBurnedSum} cal",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.0),
                              textAlign: TextAlign.left),
                        ),
                      ],
                    )
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
