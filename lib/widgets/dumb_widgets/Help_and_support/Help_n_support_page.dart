import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/main.dart';
import 'package:vitalminds/views/settings_page/settings_page_view.dart';
import 'package:vitalminds/views/settings_page/settings_page_view_model.dart';

import '../Themes.dart';

class HelpandSupportWidget extends StatelessWidget {
  final SettingsPageViewModel viewModel;
  const HelpandSupportWidget({
    Key key,
    this.viewModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
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
                  padding: EdgeInsets.only(top: topPadding + height * 0.01),
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
                                    NavigationService navigationService =
                                    locator<NavigationService>();
                                    navigationService.navigateWithTransition(
                                        SettingsPageView(),
                                        transition: 'leftToRight');
                                  }),
                            ),
                            SizedBox(width: width * 0.02,),
                            Text("Help and Support",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width / 24,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Roboto',
                                )),
                          ],
                        ),
                        Container(
                            width: width * 0.9,
                            margin: EdgeInsets.only(top: height * 0.03),
                            padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white.withOpacity(0.1)
                            ),
                            child: RichText(
                              text: new TextSpan(
                                  text: "For any Queries\n",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width / 26,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                        text:
                                            "\nMail us at: myvitalmind3@gmail.com",
                                        style: TextStyle(
                                            color: Colors.white.withOpacity(0.6),
                                            fontSize: width / 28,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400))
                                  ]),
                            )),
                        Container(
                            width: width * 0.9,
                            margin: EdgeInsets.only(top: height * 0.03),
                            padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: RichText(
                              text: new TextSpan(
                                  text: "Terms and Conditions\n",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width / 26,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                        text: "\nAdd content here",
                                        style: TextStyle(
                                            color: Colors.white.withOpacity(0.6),
                                            fontSize: width / 28,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400))
                                  ]),
                            ))
                      ]),
                ),
              ),
            )));
  }
}
