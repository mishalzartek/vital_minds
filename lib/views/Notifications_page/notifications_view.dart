import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/main.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'notifications_page_view_model.dart';

class NotificationsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var topPadding = MediaQuery.of(context).padding.top;
    return ViewModelBuilder<NotificationsPageViewModel>.reactive(
        builder: (BuildContext context, NotificationsPageViewModel viewModel,
            Widget _) {
          return WillPopScope(
            onWillPop: () async {
              viewModel.saveNotificationSettingsData().whenComplete(() {
                return true;
              });
              return true;
            },
            child: Scaffold(
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(Themes.color, BlendMode.modulate),
                      image: myImage,
                      fit: BoxFit.cover),
                ),
                width: width,
                height: height,
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: topPadding + 0.02 * height),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white.withOpacity(0.2),
                                  radius: width / 30,
                                  child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(
                                        Icons.chevron_left,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        viewModel
                                            .saveNotificationSettingsData()
                                            .whenComplete(() =>
                                            viewModel.navigateToProfilePage(context));
                                      }),
                                ),
                                SizedBox(width: width * 0.02,),
                                Text("Notifications",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width / 24,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Roboto',
                                    )),
                              ],
                            ),
                            Container(
                                height: height / 9.5,
                                width: width * 0.9,
                                margin: EdgeInsets.only(top: height * 0.05),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white.withOpacity(0.1),
                                ),
                                child: Center(
                                  child: SwitchListTile(
                                    value: viewModel.switchValue,
                                    onChanged: viewModel.changeSwitchValue,
                                    activeColor: Themes.color.withOpacity(0.5),
                                    inactiveTrackColor: Colors.white.withOpacity(0.3),
                                    inactiveThumbColor:
                                        Colors.white.withOpacity(0.5),
                                    activeTrackColor: Colors.white,
                                    title: Text("Notifications",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width / 25,
                                          fontFamily: 'Roboto',
                                        )),
                                    subtitle: Text(
                                        "Enable notifications from app",
                                        style: TextStyle(
                                            color: Colors.white.withOpacity(0.6),
                                            fontSize: width / 30,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300)),
                                  ),
                                )),
                            viewModel.switchValue
                                ? Container(
                                    width: width * 0.9,
                                    padding: EdgeInsets.all(width * 0.03),
                                    margin: EdgeInsets.only(top: height * 0.03),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Set notifications",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width / 27,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600)),
                                        for (int i = 0; i < 3; i++)
                                          Theme(
                                            data: ThemeData(
                                              unselectedWidgetColor: Colors.white
                                            ),
                                            child: CheckboxListTile(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                              contentPadding: EdgeInsets.all(0),
                                              title: Text(viewModel.titles[i],
                                                  style: TextStyle(
                                                    color: Colors.white.withOpacity(0.6),
                                                    fontSize: width / 25,
                                                    fontFamily: 'Roboto',
                                                  )),
                                              value: viewModel.checkValues[i],
                                              onChanged: (v) {
                                                viewModel.changeCheckValue(v, i);
                                                if (!v) {
                                                  viewModel.deleteNotification(i);
                                                }
                                              },
                                              activeColor: Colors.white,
                                              checkColor: Themes.color,
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                : Container()
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => NotificationsPageViewModel());
  }
}
