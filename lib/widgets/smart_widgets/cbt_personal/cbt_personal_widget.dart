import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'cbt_personal_view_model.dart';

class CbtPersonalWidget extends StatelessWidget {
  final DateTime selectedDate;

  const CbtPersonalWidget({Key key, this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CbtPersonalViewModel>.reactive(
      builder:
          (BuildContext context, CbtPersonalViewModel viewModel, Widget _) {
        return viewModel.cbtTitle.length == 0 &&
                viewModel.worksheets.length == 0
            ? Padding(
              padding: EdgeInsets.symmetric(vertical : MediaQuery.of(context).size.height * 0.05, horizontal : MediaQuery.of(context).size.width * 0.05),            
              child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          "You have neither watched any video nor finished any worksheet today. Head over to the therapy section to make the entries !",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () => viewModel.gotToWorksheets(0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.04,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.015),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.1),
                              border: Border.all(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text("Go to Therapy Section",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ],
                  ),
                ),
            )
            : Container(
                height: MediaQuery.of(context).size.height * 0.9,
                padding: const EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("CBT Videos",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0),
                        textAlign: TextAlign.left),
                    viewModel.cbtTitle.length != 0
                        ? Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                              itemCount: viewModel.cbtTitle.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(viewModel.worksheets);
                                Map m = viewModel.worksheets.isEmpty?{}:viewModel
                                    .worksheets[index].data();
                                List titles = [];
                                List answers = [];
                                m.forEach((key, value) {
                                  titles.add(key);
                                  answers.add(value);
                                });
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 10.0),
                                  child: GestureDetector(
                                    // onTap: () => viewModel.cbtListTile(index),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  viewModel.radius))),
                                      child: ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,
                                        onExpansionChanged: (val) =>
                                            viewModel.changeRadius(val),
                                        expandedCrossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        expandedAlignment: Alignment.centerLeft,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, bottom: 5),
                                            child: Text(
                                                "Videos You've Watched :",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0),
                                                textAlign: TextAlign.left),
                                          ),
                                          for (int i = 0;
                                              i <
                                                  viewModel
                                                      .cbtValue[index].length;
                                              i++)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, bottom: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(""),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "${i + 1}. ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16.0),
                                                      children: [
                                                        TextSpan(
                                                          text: viewModel
                                                                  .cbtValue[
                                                                      index][i]
                                                                  .keys
                                                                  .first ??
                                                              " ",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(""),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 7.0),
                                                    child: Text(
                                                      "Your Questions and Answers :\n",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15.0),
                                                    ),
                                                  ),
                                                  for (int j = 0;
                                                      j <
                                                          viewModel
                                                              .cbtValue[index]
                                                                  [i]
                                                              .values
                                                              .first
                                                              .length;
                                                      j++)
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            viewModel
                                                                .cbtValue[index]
                                                                    [i]
                                                                .values
                                                                .last[j],
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 15.0),
                                                          ),
                                                        SizedBox(height: 3,),
                                                        Text(
                                                            viewModel
                                                                    .cbtValue[
                                                                        index]
                                                                        [i]
                                                                    .values
                                                                    .first[j] ??
                                                                " ",
                                                            style: TextStyle(
                                                                color: Colors.white.withOpacity(0.6),
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 15.0),
                                                          ),
                                                        Text("")
                                                      ],
                                                    )
                                                ],
                                              ),
                                            ),
                                        ],
                                        title: Text(viewModel.cbtTitle[index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18.0),
                                            textAlign: TextAlign.left),
                                        // trailing: Icon(
                                        //   Icons.check,
                                        //   color: Colors.white,
                                        // ),
                                        initiallyExpanded: false,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Padding(
                          padding: EdgeInsets.symmetric(vertical : MediaQuery.of(context).size.height * 0.05, horizontal : MediaQuery.of(context).size.width * 0.05),
                          child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("You have not watched any videos today.",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14.0),
                                      textAlign: TextAlign.center),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  GestureDetector(
                                    onTap: () => viewModel.gotToWorksheets(0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              MediaQuery.of(context).size.width *
                                                  0.04,
                                          vertical:
                                              MediaQuery.of(context).size.height *
                                                  0.015),
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 0.1),
                                          border: Border.all(
                                              color: Colors.transparent),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Text("Go to Videos",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Roboto",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.0),
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ),
                    Text("Worksheets",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0),
                        textAlign: TextAlign.left),
                    viewModel.worksheets.length != 0 ?
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 8),
                        itemCount: viewModel.completedWorksheets.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                            child: GestureDetector(
                              onTap: () {
                                viewModel.navigateToDetailsPage(viewModel.completedWorksheets[index].entries.first.key);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(viewModel.radius))),
                                child: ListTile(
                                  title: Text(
                                      viewModel.getWorksheetNameFromDoc(viewModel.completedWorksheets[index].entries
                                              .first.key),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                      textAlign: TextAlign.left),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ) :
                    Padding(
                          padding: EdgeInsets.symmetric(vertical : MediaQuery.of(context).size.height * 0.05, horizontal : MediaQuery.of(context).size.width * 0.05),
                          child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("You have not done any worksheets today.",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14.0),
                                      textAlign: TextAlign.center),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  GestureDetector(
                                    onTap: () => viewModel.gotToWorksheets(1),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              MediaQuery.of(context).size.width *
                                                  0.04,
                                          vertical:
                                              MediaQuery.of(context).size.height *
                                                  0.015),
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 0.1),
                                          border: Border.all(
                                              color: Colors.transparent),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Text("Go to Worksheets",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Roboto",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.0),
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ),
                  ],
                ),
              );
      },
      viewModelBuilder: () => CbtPersonalViewModel(selectedDate, context),
    );
  }
}
