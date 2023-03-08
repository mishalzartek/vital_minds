import 'dart:developer';
import 'dart:ui';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/models/habits_model.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';

/// The type of dialog to show
enum DialogType { basic, reminder, todo, excercise, habit, password, nutrition }

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
    DialogType.reminder: (context, sheetRequest, completer) =>
        _ReminderDialog(request: sheetRequest, completer: completer),
    DialogType.todo: (context, sheetRequest, completer) =>
        _TodoDialog(request: sheetRequest, completer: completer),
    DialogType.excercise: (context, sheetRequest, completer) =>
        _ExcerciseDialog(request: sheetRequest, completer: completer),
    DialogType.habit: (context, sheetRequest, completer) =>
        _HabitDialog(request: sheetRequest, completer: completer),
    DialogType.password: (context, sheetRequest, completer) =>
        _PasswordDialog(request: sheetRequest, completer: completer),
    DialogType.nutrition: (context, sheetRequest, completer) =>
        _NutritionDialog(request: sheetRequest, completer: completer),
  };
  try {
    dialogService.registerCustomDialogBuilders(builders);
  } catch (e) {
    log(e.toString());
  }
}

class _NutritionDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const _NutritionDialog({Key key, this.request, this.completer})
      : super(key: key);
  @override
  __NutritionDialogState createState() => __NutritionDialogState();
}

class __NutritionDialogState extends State<_NutritionDialog> {
  TextEditingController nameController = new TextEditingController();
  Habit habitsModel = new Habit();
  FocusNode habitFocusNode = FocusNode();
  bool showTextField = false;
  bool checkboxesValidated = false;
  String habitNameError;
  String habitCheckboxError;
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> foodItems = [
    {
      "food": "Idly",
      "icon": 'assets/icons/food/png/32/beer.png',
    },
    {
      "food": "Dosa",
      "icon": 'assets/icons/food/png/32/cake.png',
    },
    {
      "food": "Bakery",
      "icon": 'assets/icons/food/png/32/cocktail.png',
    },
    {
      "food": "Cereal",
      "icon": 'assets/icons/food/png/32/french_fries.png',
    },
    {
      "food": "Eggs",
      "icon": 'assets/icons/food/png/32/hamburguer.png',
    },
    {
      "food": "Meat",
      "icon": 'assets/icons/food/png/32/pizza.png',
    },
    {
      "food": "fruits",
      "icon": 'assets/icons/food/png/32/toast.png',
    },
    {
      "food": "Vegetables",
      "icon": 'assets/icons/food/png/32/wine_cup.png',
    },
    {
      "food": "pizza",
      "icon": 'assets/icons/food/png/32/birthday.png',
    },
    {
      "food": "fruits",
      "icon": 'assets/icons/food/png/32/champagne.png',
    },
    {
      "food": "Vegetables",
      "icon": 'assets/icons/food/png/32/coffee_cup.png',
    },
    {
      "food": "pizza",
      "icon": 'assets/icons/food/png/32/diet.png',
    },
    {
      "food": "fruits",
      "icon": 'assets/icons/food/png/32/dish_1.png',
    },
    {
      "food": "Vegetables",
      "icon": 'assets/icons/food/png/32/toast_1.png',
    },
    {
      "food": "pizza",
      "icon": 'assets/icons/food/png/32/restaurant.png',
    },
    {
      "food": "pizza",
      "icon": 'assets/icons/food/png/32/airbrush.png',
    },
  ];

  List<Map<String, dynamic>> selectedFoodItems = [];

  void handleFoodSelection(int index) {
    setState(() {
      selectedFoodItems.add(foodItems[index]);
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.request.data != null) {
      nameController.text = widget.request.data[0].title;
      habitsModel.status = widget.request.data[0].status;
    } else {
      habitsModel.status = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus.unfocus();
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(widget.request.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    textAlign: TextAlign.center),
                Form(
                  key: _formKey,
                  child: Container(
                    // height: 50,
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Food",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            children: List.generate(selectedFoodItems.length,
                                (index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                child: Image.asset(
                                    selectedFoodItems[index]["icon"]),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // child: Container(
                  //   padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                  //   child: !showTextField
                  //       ? DropdownButton(
                  //           menuMaxHeight: 400,
                  //           items: <DropdownMenuItem>[
                  //             DropdownMenuItem(
                  //               child: Text("Get up early"),
                  //               value: "Get up early",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Make my bed"),
                  //               value: "Make my bed",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Call a friend"),
                  //               value: "Call a friend",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Exercise"),
                  //               value: "Exercise",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Meditate"),
                  //               value: "Meditate",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Family time"),
                  //               value: "Family time",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Practice gratitude"),
                  //               value: "Practice gratitude",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Read"),
                  //               value: "Read",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("News"),
                  //               value: "News",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Hobby"),
                  //               value: "Hobby",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Blog"),
                  //               value: "Blog",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Journal"),
                  //               value: "Journal",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Limit screen time"),
                  //               value: "Limit screen time",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Reduce sweets "),
                  //               value: "Reduce sweets ",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Quit smoking"),
                  //               value: "Quit smoking",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Drink water"),
                  //               value: "Drink water",
                  //             ),
                  //             DropdownMenuItem(
                  //               child: Text("Other"),
                  //               value: "Other",
                  //             ),
                  //           ],
                  //           hint: Text("Name of the habit"),
                  //           onChanged: (value) {
                  //             setState(() {
                  //               nameController.text =
                  //                   value.compareTo("Other") == 0 ? "" : value;
                  //               habitFocusNode.requestFocus();
                  //               showTextField = true;
                  //               if (nameController.text != "") {
                  //                 habitNameError = null;
                  //               }
                  //             });
                  //           },
                  //         )
                  //       : TextFormField(
                  //           autovalidateMode:
                  //               AutovalidateMode.onUserInteraction,
                  //           validator: (value) {
                  //             if (value == "" ||
                  //                 value.isEmpty ||
                  //                 value == null) {
                  //               return "Habit can't be empty";
                  //             }
                  //             return null;
                  //           },
                  //           focusNode: habitFocusNode,
                  //           maxLength: 50,
                  //           textCapitalization: TextCapitalization.sentences,
                  //           textInputAction: TextInputAction.done,
                  //           cursorColor: Themes.color,
                  //           decoration: InputDecoration(
                  //             focusedBorder: UnderlineInputBorder(
                  //               borderSide: BorderSide(
                  //                 color: Themes.color,
                  //               ),
                  //             ),
                  //             labelStyle: TextStyle(color: Themes.color),
                  //             focusColor: Themes.color,
                  //             labelText: "Name of the habit",
                  //           ),
                  //           controller: nameController,
                  //         ),
                  // ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  height: 360,
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    children: List.generate(foodItems.length, (foodIndex) {
                      return GestureDetector(
                        onTap: () {
                          handleFoodSelection(foodIndex);
                        },
                        child: Container(
                          color: Themes.color.withOpacity(0.2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(foodItems[foodIndex]["icon"]),

                              // FaIcon(
                              //   foodItems[foodIndex]["icon"],
                              //   color: Themes.color,
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(foodItems[foodIndex]["food"]),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                habitCheckboxError != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          habitCheckboxError,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  // Complete the dialog when you're done with it to return some data
                  onTap: () {
                    widget.completer(
                      DialogResponse(
                        data: selectedFoodItems,
                      ),
                    );
                  },
                  child: Container(
                    child: widget.request.showIconInMainButton
                        ? Icon(Icons.check_circle)
                        : Text(
                            widget.request.mainButtonTitle,
                            style: TextStyle(color: Colors.white),
                          ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Themes.color.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _BasicDialog({Key key, this.request, this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                request.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                request.description,
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                // Complete the dialog when you're done with it to return some data
                onTap: () => completer(DialogResponse(confirmed: true)),
                child: Container(
                  child: request.showIconInMainButton
                      ? Icon(Icons.check_circle)
                      : Text(request.mainButtonTitle,
                          style: TextStyle(color: Colors.white)),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Themes.color.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReminderDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _ReminderDialog({Key key, this.request, this.completer})
      : super(key: key);

  @override
  _ReminderDialogState createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<_ReminderDialog> {
  TextEditingController reminderController = new TextEditingController();
  TextEditingController _timeController = new TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  String _hour, _minute, _time, setTime;
  final _reminderFormKey = GlobalKey<FormState>();
  SnackbarService snackbarService = locator<SnackbarService>();

  @override
  void initState() {
    super.initState();
    if (widget.request.data != null) {
      reminderController.text = widget.request.data[0];
      _timeController.text = widget.request.data[1];
    } else
      _timeController.text = formatDate(
          DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
          [hh, ':', nn, " ", am]).toString();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus.unfocus();
          },
          child: Form(
            key: _reminderFormKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.request.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty || val == "")
                        return "Reminder can't be empty";
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    cursorColor: Themes.color,
                    decoration: InputDecoration(
                        focusColor: Themes.color,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Themes.color,
                          ),
                        ),
                        labelStyle: TextStyle(color: Themes.color),
                        labelText: "Enter reminder"),
                    controller: reminderController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Choose Time',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, letterSpacing: 0.5),
                      ),
                      InkWell(
                        onTap: () async {
                          final TimeOfDay picked = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Themes
                                          .color, // header background color
                                      onPrimary:
                                          Colors.white, // header text color
                                      onSurface:
                                          Colors.black, // body text color
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor:
                                            Themes.color, // button text color
                                      ),
                                    ),
                                  ),
                                  child: child,
                                );
                              });
                          if (picked != null)
                            setState(() {
                              selectedTime = picked;
                              _hour = selectedTime.hour.toString();
                              _minute = selectedTime.minute.toString();
                              _time = _hour + ' : ' + _minute;
                              _timeController.text = _time;
                              _timeController.text = formatDate(
                                  DateTime(2019, 08, 1, selectedTime.hour,
                                      selectedTime.minute),
                                  [hh, ':', nn, " ", am]).toString();
                            });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 30),
                          // width: _width / 1.7,
                          // height: _height / 9,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          child: TextFormField(
                            style: TextStyle(fontSize: 40),
                            textAlign: TextAlign.center,
                            onSaved: (String val) {
                              setTime = val;
                            },
                            enabled: false,
                            keyboardType: TextInputType.text,
                            controller: _timeController,
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              // labelText: 'Time',
                              contentPadding: EdgeInsets.all(5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    // Complete the dialog when you're done with it to return some data
                    onTap: () => {
                      if (_reminderFormKey.currentState.validate())
                        {
                          widget.completer(
                            DialogResponse(
                              data: [
                                reminderController.text,
                                _timeController.text,
                              ],
                            ),
                          )
                        }
                    },
                    child: Container(
                      child: widget.request.showIconInMainButton
                          ? Icon(Icons.check_circle)
                          : Text(widget.request.mainButtonTitle,
                              style: TextStyle(color: Colors.white)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Themes.color.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TodoDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const _TodoDialog({Key key, this.request, this.completer}) : super(key: key);
  @override
  _TodoDialogState createState() => _TodoDialogState();
}

class _TodoDialogState extends State<_TodoDialog> {
  TextEditingController todoController = new TextEditingController();
  SnackbarService snackbarService = locator<SnackbarService>();
  final _toDoFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.request.data != null) {
      todoController.text = widget.request.data[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus.unfocus();
          },
          child: Form(
            key: _toDoFormKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.request.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty || val == "")
                        return "ToDo can't be empty";
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    cursorColor: Themes.color,
                    decoration: InputDecoration(
                        focusColor: Themes.color,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Themes.color,
                          ),
                        ),
                        labelStyle: TextStyle(
                            color: Themes.color, fontFamily: 'Roboto'),
                        labelText: "Enter To Do"),
                    controller: todoController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    // Complete the dialog when you're done with it to return some data
                    onTap: () => {
                      if (_toDoFormKey.currentState.validate())
                        {
                          widget.completer(
                            DialogResponse(
                              data: [
                                todoController.text,
                              ],
                            ),
                          )
                        }
                    },
                    child: Container(
                      child: widget.request.showIconInMainButton
                          ? Icon(Icons.check_circle)
                          : Text(widget.request.mainButtonTitle,
                              style: TextStyle(color: Colors.white)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Themes.color.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExcerciseDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const _ExcerciseDialog({Key key, this.request, this.completer})
      : super(key: key);
  @override
  __ExcerciseDialogState createState() => __ExcerciseDialogState();
}

class __ExcerciseDialogState extends State<_ExcerciseDialog> {
  TextEditingController timeController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController caloriesController = new TextEditingController();

  String exerciseErrorText;
  String exerciseCaloriesErrorText;

  FocusNode exerciseNameFocusNode = FocusNode();
  FocusNode exerciseCaloriesFocusNode = FocusNode();

  bool showExerciseNameTextField = false;
  bool showExerciseCaloriesTextField = false;

  final exerciseFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.request.data != null) {
      nameController.text = widget.request.data[0];
      timeController.text = widget.request.data[1];
      caloriesController.text = widget.request.data[2];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus.unfocus();
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Form(
              key: exerciseFormKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Text(
                    widget.request.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  !showExerciseNameTextField
                      ? DropdownButton(
                          items: <DropdownMenuItem>[
                            DropdownMenuItem(
                              child: Text("Cardio"),
                              value: "Cardio",
                            ),
                            DropdownMenuItem(
                              child: Text("Weights"),
                              value: "Weights",
                            ),
                            DropdownMenuItem(
                              child: Text("Jog"),
                              value: "Jog",
                            ),
                            DropdownMenuItem(
                              child: Text("Walk"),
                              value: "Walk",
                            ),
                            DropdownMenuItem(
                              child: Text("Yoga"),
                              value: "Yoga",
                            ),
                            DropdownMenuItem(
                              child: Text("Pilates"),
                              value: "Pilates",
                            ),
                            DropdownMenuItem(
                              child: Text("Swim"),
                              value: "Swim",
                            ),
                            DropdownMenuItem(
                              child: Text("Other"),
                              value: "Other",
                            ),
                          ],
                          hint: Text("Name of the exercise"),
                          onChanged: (value) {
                            setState(() {
                              nameController.text =
                                  value.compareTo("Other") == 0 ? "" : value;
                              exerciseNameFocusNode.requestFocus();
                              showExerciseNameTextField = true;
                            });
                          },
                        )
                      : TextFormField(
                          focusNode: exerciseNameFocusNode,
                          validator: (name) {
                            if (nameController.text.isEmpty ||
                                nameController.text == "") {
                              return "Name can't be empty";
                            }

                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Themes.color,
                          decoration: InputDecoration(
                            labelText: "Name of the exercise",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Themes.color,
                              ),
                            ),
                            labelStyle: TextStyle(color: Themes.color),
                          ),
                          controller: nameController,
                        ),
                  exerciseErrorText != null && !showExerciseNameTextField
                      ? Text(
                          exerciseErrorText,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (min) {
                      if (min.isEmpty)
                        return "Duration can't be empty";
                      else if (min == "0") return "Can't be 0";
                      return null;
                    },
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    cursorColor: Themes.color,
                    decoration: InputDecoration(
                      focusColor: Themes.color,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Themes.color,
                        ),
                      ),
                      labelStyle: TextStyle(color: Themes.color),
                      labelText: "Duration of the exercise",
                      suffixText: "min",
                    ),
                    controller: timeController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  !showExerciseCaloriesTextField
                      ? DropdownButton(
                          items: [
                            DropdownMenuItem(
                              child: Text("50"),
                              value: "50",
                            ),
                            DropdownMenuItem(
                              child: Text("100"),
                              value: "100",
                            ),
                            DropdownMenuItem(
                              child: Text("150"),
                              value: "150",
                            ),
                            DropdownMenuItem(
                              child: Text("200"),
                              value: "200",
                            ),
                            DropdownMenuItem(
                              child: Text("250"),
                              value: "250",
                            ),
                            DropdownMenuItem(
                              child: Text("300"),
                              value: "300",
                            ),
                            DropdownMenuItem(
                              child: Text("350"),
                              value: "350",
                            ),
                            DropdownMenuItem(
                              child: Text("400"),
                              value: "400",
                            ),
                            DropdownMenuItem(
                              child: Text("Other"),
                              value: "Other",
                            ),
                          ],
                          hint: Text("Calories burned"),
                          onChanged: (value) {
                            setState(() {
                              caloriesController.text =
                                  value.compareTo("Other") == 0 ? "" : value;
                              exerciseCaloriesFocusNode.requestFocus();
                              showExerciseCaloriesTextField = true;
                            });
                          },
                        )
                      : TextFormField(
                          validator: (name) {
                            if (caloriesController.text.isEmpty ||
                                caloriesController.text == "") {
                              return "Calorie can't be empty";
                            }

                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          focusNode: exerciseCaloriesFocusNode,
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Themes.color,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusColor: Themes.color,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Themes.color,
                              ),
                            ),
                            labelStyle: TextStyle(color: Themes.color),
                            labelText: "Calories burned during the exercise",
                            suffixText: "cal",
                          ),
                          controller: caloriesController,
                        ),
                  exerciseCaloriesErrorText != null &&
                          !showExerciseCaloriesTextField
                      ? Text(
                          exerciseCaloriesErrorText,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    // Complete the dialog when you're done with it to return some data
                    onTap: () => {
                      // if (exce.text == null)
                      //   {
                      //     snackbarService.showSnackbar(
                      //         message: "To Do cannot be empty")
                      //   }
                      // else
                      //   {
                      if (nameController.text == "")
                        {
                          setState(() {
                            exerciseErrorText = "Name can't be empty";
                          })
                        }
                      else
                        {
                          setState(() {
                            exerciseErrorText = null;
                          })
                        },

                      if (caloriesController.text == "")
                        {
                          setState(() {
                            exerciseCaloriesErrorText =
                                "Calories can't be empty";
                          })
                        }
                      else
                        {
                          setState(() {
                            exerciseCaloriesErrorText = null;
                          })
                        },
                      if (exerciseFormKey.currentState.validate() &&
                          nameController.text != "" &&
                          caloriesController.text != "")
                        {
                          widget.completer(
                            DialogResponse(
                              data: [
                                nameController.text,
                                timeController.text,
                                caloriesController.text
                              ],
                            ),
                          )
                        }
                      // }
                    },
                    child: Container(
                      child: widget.request.showIconInMainButton
                          ? Icon(Icons.check_circle)
                          : Text(widget.request.mainButtonTitle,
                              style: TextStyle(color: Colors.white)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Themes.color.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HabitDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const _HabitDialog({Key key, this.request, this.completer}) : super(key: key);
  @override
  __HabitDialogState createState() => __HabitDialogState();
}

class __HabitDialogState extends State<_HabitDialog> {
  TextEditingController nameController = new TextEditingController();
  Habit habitsModel = new Habit();
  FocusNode habitFocusNode = FocusNode();
  bool showTextField = false;
  bool checkboxesValidated = false;
  String habitNameError;
  String habitCheckboxError;
  final _formKey = GlobalKey<FormState>();
  Map<String, bool> days = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
    "Sunday": false,
  };
  void changeCheckbox(int index, bool value) {
    setState(() {
      days[days.keys.elementAt(index)] = value;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.request.data != null) {
      nameController.text = widget.request.data[0].title;
      days["Monday"] = widget.request.data[0].days[0];
      days["Tuesday"] = widget.request.data[0].days[1];
      days["Wednesday"] = widget.request.data[0].days[2];
      days["Thursday"] = widget.request.data[0].days[3];
      days["Friday"] = widget.request.data[0].days[4];
      days["Saturday"] = widget.request.data[0].days[5];
      days["Sunday"] = widget.request.data[0].days[6];
      habitsModel.status = widget.request.data[0].status;
    } else {
      habitsModel.status = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus.unfocus();
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(widget.request.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    textAlign: TextAlign.center),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    child: !showTextField
                        ? DropdownButton(
                            menuMaxHeight: 400,
                            items: <DropdownMenuItem>[
                              DropdownMenuItem(
                                child: Text("Get up early"),
                                value: "Get up early",
                              ),
                              DropdownMenuItem(
                                child: Text("Make my bed"),
                                value: "Make my bed",
                              ),
                              DropdownMenuItem(
                                child: Text("Call a friend"),
                                value: "Call a friend",
                              ),
                              DropdownMenuItem(
                                child: Text("Exercise"),
                                value: "Exercise",
                              ),
                              DropdownMenuItem(
                                child: Text("Meditate"),
                                value: "Meditate",
                              ),
                              DropdownMenuItem(
                                child: Text("Family time"),
                                value: "Family time",
                              ),
                              DropdownMenuItem(
                                child: Text("Practice gratitude"),
                                value: "Practice gratitude",
                              ),
                              DropdownMenuItem(
                                child: Text("Read"),
                                value: "Read",
                              ),
                              DropdownMenuItem(
                                child: Text("News"),
                                value: "News",
                              ),
                              DropdownMenuItem(
                                child: Text("Hobby"),
                                value: "Hobby",
                              ),
                              DropdownMenuItem(
                                child: Text("Blog"),
                                value: "Blog",
                              ),
                              DropdownMenuItem(
                                child: Text("Journal"),
                                value: "Journal",
                              ),
                              DropdownMenuItem(
                                child: Text("Limit screen time"),
                                value: "Limit screen time",
                              ),
                              DropdownMenuItem(
                                child: Text("Reduce sweets "),
                                value: "Reduce sweets ",
                              ),
                              DropdownMenuItem(
                                child: Text("Quit smoking"),
                                value: "Quit smoking",
                              ),
                              DropdownMenuItem(
                                child: Text("Drink water"),
                                value: "Drink water",
                              ),
                              DropdownMenuItem(
                                child: Text("Other"),
                                value: "Other",
                              ),
                            ],
                            hint: Text("Name of the habit"),
                            onChanged: (value) {
                              setState(() {
                                nameController.text =
                                    value.compareTo("Other") == 0 ? "" : value;
                                habitFocusNode.requestFocus();
                                showTextField = true;
                                if (nameController.text != "") {
                                  habitNameError = null;
                                }
                              });
                            },
                          )
                        : TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == "" ||
                                  value.isEmpty ||
                                  value == null) {
                                return "Habit can't be empty";
                              }
                              return null;
                            },
                            focusNode: habitFocusNode,
                            maxLength: 50,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.done,
                            cursorColor: Themes.color,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Themes.color,
                                  ),
                                ),
                                labelStyle: TextStyle(color: Themes.color),
                                focusColor: Themes.color,
                                labelText: "Name of the habit"),
                            controller: nameController,
                          ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: days.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      activeColor: Themes.color,
                      title: Text(days.keys.elementAt(index)),
                      value: days[days.keys.elementAt(index)],
                      onChanged: (value) => {
                        changeCheckbox(index, value),
                      },
                    );
                  },
                ),
                habitCheckboxError != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          habitCheckboxError,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  // Complete the dialog when you're done with it to return some data
                  onTap: () {
                    days.forEach((key, value) {
                      if (value) {
                        checkboxesValidated = true;
                      }
                    });
                    if (checkboxesValidated) {
                      setState(() {
                        habitCheckboxError = null;
                      });
                    } else {
                      setState(() {
                        habitCheckboxError = "Name & Day can't be empty.";
                      });
                    }
                    if (nameController.text == "") {
                      setState(() {
                        habitNameError = "Name can't be empty";
                      });
                    } else {
                      setState(() {
                        habitNameError = null;
                      });
                    }
                    if (_formKey.currentState.validate() &&
                        nameController.text != "" &&
                        checkboxesValidated) {
                      habitsModel.title = nameController.text;
                      habitsModel.days = [
                        days["Monday"],
                        days["Tuesday"],
                        days["Wednesday"],
                        days["Thursday"],
                        days["Friday"],
                        days["Saturday"],
                        days["Sunday"]
                      ];
                      widget.completer(
                        DialogResponse(
                          data: [habitsModel],
                        ),
                      );
                    }
                  },
                  child: Container(
                    child: widget.request.showIconInMainButton
                        ? Icon(Icons.check_circle)
                        : Text(
                            widget.request.mainButtonTitle,
                            style: TextStyle(color: Colors.white),
                          ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Themes.color.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _PasswordDialog({Key key, this.request, this.completer})
      : super(key: key);

  @override
  __PasswordDialogState createState() => __PasswordDialogState();
}

class __PasswordDialogState extends State<_PasswordDialog> {
  TextEditingController emailController = TextEditingController();
  String error;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text(
                widget.request.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                cursorColor: Themes.color,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: "Email",
                  errorText: error,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Themes.color,
                    ),
                  ),
                  labelStyle: TextStyle(color: Themes.color),
                ),
                controller: emailController,
              ),
              SizedBox(height: 10.0),
              GestureDetector(
                // Complete the dialog when you're done with it to return some data
                onTap: () {
                  if (emailController.text.isNotEmpty) {
                    widget.completer(
                      DialogResponse(
                        data: [emailController.text],
                      ),
                    );
                  } else {
                    setState(() {
                      error = "Invalid Email";
                      print(error);
                    });
                  }
                },
                child: Container(
                  child: widget.request.showIconInMainButton
                      ? Icon(Icons.check_circle)
                      : Text(widget.request.mainButtonTitle,
                          style: TextStyle(color: Colors.white)),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Themes.color.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
