import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vitalminds/widgets/smart_widgets/journal/journal_view_model.dart';

import '../Themes.dart';

class MoodsWidget extends StatelessWidget {
  final int moodToday;
  final String type;
  final TextEditingController controller;
  final JournalViewModel viewModel;

  const MoodsWidget({
    Key key,
    this.moodToday,
    this.type,
    this.controller,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return viewModel.isBusy
        ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: SpinKitWanderingCubes(
              color: Colors.white,
              size: 40,
              duration: Duration(milliseconds: 1200),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.015, horizontal: width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: moodToday == 0
                              ? Colors.white
                              : Colors.transparent,
                          radius: 26,
                          child: SvgPicture.asset(
                            'assets/icons/Icon awesome-tired.svg',
                            height: 36.0,
                            width: 36.0,
                            color: moodToday == 0
                                ? Themes.color
                                : Colors.white.withOpacity(0.3),
                          ),
                        ),
                        onTap: () {
                          viewModel.changeMood(type, 0);
                          viewModel.cancelNotification();
                        },
                      ),
                      GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: moodToday == 1
                                ? Colors.white
                                : Colors.transparent,
                            radius: 26,
                            child: SvgPicture.asset(
                              'assets/icons/Icon awesome-angry.svg',
                              color: moodToday == 1
                                  ? Themes.color
                                  : Colors.white.withOpacity(0.3),
                              height: 36.0,
                              width: 36.0,
                            ),
                          ),
                          onTap: () {
                            viewModel.changeMood(type, 1);
                            viewModel.cancelNotification();
                          }),
                      GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: moodToday == 2
                                ? Colors.white
                                : Colors.transparent,
                            radius: 26,
                            child: SvgPicture.asset(
                              'assets/icons/Icon awesome-sad-tear.svg',
                              color: moodToday == 2
                                  ? Themes.color
                                  : Colors.white.withOpacity(0.3),
                              height: 36.0,
                              width: 36.0,
                            ),
                          ),
                          onTap: () {
                            viewModel.changeMood(type, 2);
                            viewModel.cancelNotification();
                          }),
                      GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: moodToday == 3
                                ? Colors.white
                                : Colors.transparent,
                            radius: 26,
                            child: SvgPicture.asset(
                              'assets/icons/Icon awesome-smile-1.svg',
                              color: moodToday == 3
                                  ? Themes.color
                                  : Colors.white.withOpacity(0.3),
                              height: 36.0,
                              width: 36.0,
                            ),
                          ),
                          onTap: () {
                            viewModel.changeMood(type, 3);
                            viewModel.cancelNotification();
                          }),
                      GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: moodToday == 4
                                ? Colors.white
                                : Colors.transparent,
                            radius: 26,
                            child: SvgPicture.asset(
                              'assets/icons/Icon awesome-smile.svg',
                              color: moodToday == 4
                                  ? Themes.color
                                  : Colors.white.withOpacity(0.3),
                              height: 36.0,
                              width: 36.0,
                            ),
                          ),
                          onTap: () {
                            viewModel.changeMood(type, 4);
                            viewModel.cancelNotification();
                          }),
                      GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: moodToday == 5
                                ? Colors.white
                                : Colors.transparent,
                            radius: 26,
                            child: SvgPicture.asset(
                              'assets/icons/Icon awesome-laugh.svg',
                              color: moodToday == 5
                                  ? Themes.color
                                  : Colors.white.withOpacity(0.3),
                              height: 36.0,
                              width: 36.0,
                            ),
                          ),
                          onTap: () {
                            viewModel.changeMood(type, 5);
                            viewModel.cancelNotification();
                          }),
                    ],
                  ),
                ),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: controller,
                  onSubmitted: (value) => viewModel.cancelNotification(),
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.white,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Add text',
                    isDense: true,
                    hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.6)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Themes.color)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.5))),
                  ),
                ),
                SizedBox(height: height * 0.02,),
              ],
            ));
  }
}
