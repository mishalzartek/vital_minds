import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/widgets/dumb_widgets/info_dialog.dart';
import 'package:vitalminds/widgets/smart_widgets/health/health_view_model.dart';

import '../Themes.dart';

class NutritionWidget extends StatefulWidget {
  final HealthViewModel viewModel;
  const NutritionWidget({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  State<NutritionWidget> createState() => _NutritionWidgetState();
}

class _NutritionWidgetState extends State<NutritionWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.viewModel.selectedFoodItems);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.03),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.1),
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Text("Nutrition",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.left),
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
                    SizedBox(
                      width: width * 0.02,
                    ),
                  ],
                ),
                InfoDialog(type: 2)
              ],
            ),
            Divider(
              color: Colors.white.withOpacity(0.6),
            ),
            widget.viewModel.isBusy
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
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: height * 0.01, bottom: height * 0.03),
                        child: DropdownButton(
                          dropdownColor: Themes.color,
                          underline: Container(),
                          iconEnabledColor: Colors.transparent,
                          isDense: true,
                          onChanged: (value) =>
                              widget.viewModel.changeFeeling(value),
                          items: widget.viewModel.feelingItems,
                          value: widget.viewModel.healthModel.nutrition.feeling,
                          hint: Text(
                            "How are you feeling today?",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Breakfast",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        widget.viewModel.addNutrition();
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        color: Colors.transparent,
                                        constraints: BoxConstraints(
                                          minHeight: 40,
                                        ),
                                        child: widget.viewModel
                                                    .selectedFoodItems.length ==
                                                0
                                            ? Text(
                                                "What did you have for breakfast?",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : Row(
                                                children: List.generate(
                                                    widget
                                                        .viewModel
                                                        .selectedFoodItems
                                                        .length, (index) {
                                                  return Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 3,
                                                    ),
                                                    child: Image.asset(widget
                                                            .viewModel
                                                            .selectedFoodItems[
                                                        index]["icon"]),
                                                  );
                                                }),
                                              ),
                                      ),
                                    ),
                                    // TextFormField(
                                    //   onTap: () {
                                    //     viewModel.addNutrition();
                                    //   },
                                    //   onChanged: (val) {
                                    //     if (val == "")
                                    //       viewModel.onEditing("breakfast", "0");
                                    //   },
                                    //   textInputAction: TextInputAction.done,
                                    //   keyboardType: TextInputType.text,
                                    //   maxLines: null,
                                    //   textCapitalization:
                                    //       TextCapitalization.sentences,
                                    //   cursorColor: Colors.white,
                                    //   controller: viewModel.breakfastController,
                                    //   decoration: InputDecoration(
                                    //     contentPadding: EdgeInsets.zero,
                                    //     border: InputBorder.none,
                                    //     hintText:
                                    //         "What did you have for breakfast?",
                                    //     hintStyle: TextStyle(
                                    //         fontSize: 12.0,
                                    //         color: Colors.white),
                                    //   ),
                                    //   style: TextStyle(
                                    //       color: Colors.white,
                                    //       fontWeight: FontWeight.w600,
                                    //       fontFamily: "Roboto",
                                    //       fontStyle: FontStyle.normal,
                                    //       fontSize: 15.0),
                                    //   textAlign: TextAlign.left,
                                    // ),
                                  ],
                                ),
                              ),
                              Container(
                                  height: height / 25,
                                  width: width / 10,
                                  child: VerticalDivider(
                                    color: Colors.white.withOpacity(0.6),
                                    thickness: 1,
                                    width: 0.5,
                                  )),
                              Expanded(
                                child: widget
                                                .viewModel
                                                .breakfastCalloriesController
                                                .text ==
                                            null ||
                                        widget
                                                .viewModel
                                                .breakfastCalloriesController
                                                .text ==
                                            ""
                                    ? DropdownButton(
                                        items:
                                            widget.viewModel.caloriesDropdown,
                                        iconEnabledColor: Colors.white,
                                        hint: Text(
                                          "Calories",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.0),
                                        ),
                                        onChanged: (v) => widget.viewModel
                                            .onEditing("breakfast", v),
                                      )
                                    : TextField(
                                        textInputAction: TextInputAction.go,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        cursorColor: Colors.white,
                                        onChanged: (v) {
                                          widget.viewModel
                                              .onEditing("breakfast", v);
                                        },
                                        controller: widget.viewModel
                                            .breakfastCalloriesController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                            hintText: "Enter calories",
                                            hintStyle:
                                                TextStyle(fontSize: 12.0),
                                            suffixStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            suffixText: " cal"),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Roboto",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0),
                                        textAlign: TextAlign.right),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Lunch",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.5,
                                child: TextField(
                                    onChanged: (val) {
                                      if (val == "")
                                        widget.viewModel
                                            .onEditing("lunch", "0");
                                    },
                                    textInputAction: TextInputAction.done,
                                    maxLines: null,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    cursorColor: Colors.white,
                                    controller:
                                        widget.viewModel.lunchController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "What did you have for lunch?",
                                      hintStyle: TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0),
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                  height: height / 24,
                                  width: width / 10,
                                  child: VerticalDivider(
                                    color: Colors.white.withOpacity(0.6),
                                    thickness: 1,
                                    width: 0.5,
                                  )),
                              Expanded(
                                child: widget.viewModel.lunchCalloriesController.text ==
                                            null ||
                                        widget
                                                .viewModel
                                                .lunchCalloriesController
                                                .text ==
                                            ""
                                    ? DropdownButton(
                                        items:
                                            widget.viewModel.caloriesDropdown,
                                        iconEnabledColor: Colors.white,
                                        hint: Text(
                                          "Calories",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.0),
                                        ),
                                        onChanged: (v) => widget.viewModel
                                            .onEditing("lunch", v),
                                      )
                                    : TextField(
                                        textInputAction: TextInputAction.go,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        cursorColor: Colors.white,
                                        onChanged: (v) => widget.viewModel
                                            .onEditing("lunch", v),
                                        controller: widget
                                            .viewModel.lunchCalloriesController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                            hintText: "Enter calories",
                                            suffixStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            hintStyle:
                                                TextStyle(fontSize: 12.0),
                                            suffixText: "cal"),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Roboto",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0),
                                        textAlign: TextAlign.right),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Snacks",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.5,
                                child: TextField(
                                    onChanged: (val) {
                                      if (val == "")
                                        widget.viewModel
                                            .onEditing("snacks", "0");
                                    },
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    textInputAction: TextInputAction.done,
                                    maxLines: null,
                                    cursorColor: Colors.white,
                                    controller:
                                        widget.viewModel.snacksController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "What did you have for snacks?",
                                      hintStyle: TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0),
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                  height: height / 24,
                                  width: width / 10,
                                  child: VerticalDivider(
                                    thickness: 1,
                                    color: Colors.white.withOpacity(0.6),
                                    width: 0.5,
                                  )),
                              Expanded(
                                child: widget.viewModel.snacksCalloriesController.text == null ||
                                        widget
                                                .viewModel
                                                .snacksCalloriesController
                                                .text ==
                                            ""
                                    ? DropdownButton(
                                        items:
                                            widget.viewModel.caloriesDropdown,
                                        iconEnabledColor: Colors.white,
                                        hint: Text(
                                          "Calories",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.0),
                                        ),
                                        onChanged: (v) => widget.viewModel
                                            .onEditing("snacks", v),
                                      )
                                    : TextField(
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        cursorColor: Colors.white,
                                        onChanged: (v) => widget.viewModel
                                            .onEditing("snacks", v),
                                        controller: widget.viewModel
                                            .snacksCalloriesController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter calories",
                                            hintStyle:
                                                TextStyle(fontSize: 12.0),
                                            suffixStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            suffixText: "cal"),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Roboto",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0),
                                        textAlign: TextAlign.right),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Dinner",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.5,
                                child: TextField(
                                    onChanged: (val) {
                                      if (val == "")
                                        widget.viewModel
                                            .onEditing("dinner", "0");
                                    },
                                    textInputAction: TextInputAction.done,
                                    maxLines: null,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    cursorColor: Colors.white,
                                    controller:
                                        widget.viewModel.dinnerController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "What did you have for dinner?",
                                      hintStyle: TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0),
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                  height: height / 24,
                                  width: width / 10,
                                  child: VerticalDivider(
                                    thickness: 1,
                                    color: Colors.white.withOpacity(0.6),
                                    width: 0.5,
                                  )),
                              Expanded(
                                child: widget.viewModel.dinnerCalloriesController.text == null ||
                                        widget.viewModel.dinnerCalloriesController.text ==
                                            ""
                                    ? DropdownButton(
                                        items:
                                            widget.viewModel.caloriesDropdown,
                                        iconEnabledColor: Colors.white,
                                        hint: Text(
                                          "Calories",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.0),
                                        ),
                                        onChanged: (v) => widget.viewModel
                                            .onEditing("dinner", v),
                                      )
                                    : TextField(
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        cursorColor:
                                            Colors.white.withOpacity(0.6),
                                        textInputAction: TextInputAction.go,
                                        onChanged: (v) => widget.viewModel
                                            .onEditing("dinner", v),
                                        controller: widget.viewModel
                                            .dinnerCalloriesController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter calories",
                                            suffixStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            hintStyle:
                                                TextStyle(fontSize: 12.0),
                                            suffixText: "cal"),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Roboto",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0),
                                        textAlign: TextAlign.right),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Divider(color: Colors.white.withOpacity(0.6)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Text("Total calories today",
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
                                child: Text(
                                    "${widget.viewModel.nutritionSum} cal",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0),
                                    textAlign: TextAlign.left),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
