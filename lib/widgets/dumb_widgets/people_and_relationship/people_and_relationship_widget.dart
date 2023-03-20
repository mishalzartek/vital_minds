import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vitalminds/widgets/smart_widgets/journal/journal_view_model.dart';

import '../Themes.dart';
class PeopleAndRelationship extends StatelessWidget {
  final JournalViewModel viewModel;
  const PeopleAndRelationship({
    Key key,
    this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic height = MediaQuery.of(context).size.height;
    dynamic width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.1),
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Text("People and relationships",
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
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.cancelNotification();
                    // viewModel.goToEditRelationshipsPage(viewModel, 0);
                  },
                  child: Text(
                          viewModel.peopleAndRelationshipsArray.length == 0
                              ? "Add"
                              : "Edit",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto",
                              fontSize: 12.0)),
                )
              ],
            ),
          Divider(
            color: Colors.white.withOpacity(0.4)
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              viewModel.isBusy
                  ? Container(
                      margin: EdgeInsets.only(
                          left: width * 0.4, bottom: height * 0.01),
                      child: SpinKitWanderingCubes(
                        color: Colors.white,
                        size: 40,
                        duration: Duration(milliseconds: 1200),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(
                        top: height * 0.01,
                        bottom: height * 0.01,
                      ),
                      child: viewModel.peopleAndRelationshipsArray.length == 0
                          ? Text(
                                  "Who did you meet today? Who did you think of?",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.6)),
                                  textAlign: TextAlign.left)
                          : Container(
                              width: width * 0.8,
                              margin: EdgeInsets.only(
                                left: width * 0.04,
                              ),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: viewModel
                                    .peopleAndRelationshipsArray.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      viewModel.cancelNotification();
                                      // viewModel.goToEditRelationshipsPage(
                                          // viewModel, index);
                                    },
                                    child: Container(
                                      width: width,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    width: width * 0.6,
                                                    child: Text(
                                                      viewModel.peopleAndRelationshipsArray[
                                                                      index]
                                                                  ['person'] !=
                                                              ''
                                                          ? '${viewModel.peopleAndRelationshipsArray[index]['person']}'
                                                          : 'Tap to add name',
                                                      maxLines: null,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.6,
                                                    child: Text(
                                                      viewModel.peopleAndRelationshipsArray[
                                                                      index]
                                                                  ['notes'] !=
                                                              ''
                                                          ? '${viewModel.peopleAndRelationshipsArray[index]['notes']}'
                                                          : viewModel.peopleAndRelationshipsArray[
                                                                          index][
                                                                      'relationship'] ==
                                                                  -1
                                                              ? 'Tap to add relationship and notes'
                                                              : 'Tap to add notes',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white.withOpacity(0.6),
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      maxLines: null,
                                                    ),
                                                  ),
                                                  viewModel.peopleAndRelationshipsArray[
                                                                      index][
                                                                  'relationship'] ==
                                                              -1 &&
                                                          viewModel.peopleAndRelationshipsArray[
                                                                      index]
                                                                  ['notes'] !=
                                                              ''
                                                      ? Text(
                                                          'Tap to add relationship',
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color:Colors.white.withOpacity(0.6),
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          maxLines: null,
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: height * 0.01),
                                                child: CircleAvatar(
                                                  radius: 26,
                                                  backgroundColor:
                                                      viewModel.peopleAndRelationshipsArray[
                                                                      index][
                                                                  'relationship'] !=
                                                              -1
                                                          ? Colors.white
                                                          : Colors.white.withOpacity(0.3),
                                                  child: viewModel.peopleAndRelationshipsArray[
                                                                  index][
                                                              'relationship'] !=
                                                          -1
                                                      ? SvgPicture.asset(
                                                          viewModel.peopleAndRelationshipsArray[
                                                                          index][
                                                                      'relationship'] ==
                                                                  0
                                                              ? 'assets/icons/Icon awesome-tired.svg'
                                                              : (viewModel.peopleAndRelationshipsArray[index]
                                                                          [
                                                                          'relationship'] ==
                                                                      1
                                                                  ? 'assets/icons/Icon awesome-angry.svg'
                                                                  : (viewModel.peopleAndRelationshipsArray[index]
                                                                              [
                                                                              'relationship'] ==
                                                                          2
                                                                      ? 'assets/icons/Icon awesome-sad-tear.svg'
                                                                      : (viewModel.peopleAndRelationshipsArray[index]['relationship'] ==
                                                                              3
                                                                          ? 'assets/icons/Icon awesome-smile-1.svg'
                                                                          : (viewModel.peopleAndRelationshipsArray[index]['relationship'] == 4
                                                                              ? 'assets/icons/Icon awesome-smile.svg'
                                                                              : 'assets/icons/Icon awesome-laugh.svg')))),
                                                          color: Themes.color,
                                                          height: 36.0,
                                                          width: 36.0,
                                                        )
                                                      : Container(
                                                          height: 36.0,
                                                          width: 36.0),
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.white.withOpacity(0.4),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    )
            ],
          )
        ],
      ),
    );
  }
}
