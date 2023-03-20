import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/main.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'edit_settings_page_view_model.dart';

class EditSettingsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var topPadding = MediaQuery.of(context).padding.top;
    return ViewModelBuilder<EditSettingsPageViewModel>.reactive(
      builder: (BuildContext context, EditSettingsPageViewModel viewModel,
          Widget _) {
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
                        physics: ClampingScrollPhysics(),
                        child: Container(
                          padding: EdgeInsets.only(top: topPadding + height * 0.01),
                          height: height,
                          width: width,
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              viewModel.navigateToProfilePage();
                                            }),
                                      ),
                                      SizedBox(width: width * 0.02,),
                                      Text("Settings",
                                          style: TextStyle(
                                            color:
                                                Colors.white,
                                            fontSize: width / 24,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Roboto',
                                          )),
                                    ],
                                  ),
                                  // Container(
                                  //   width: width * 0.9,
                                  //   padding:
                                  //       EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
                                  //   margin: EdgeInsets.only(top: height * 0.03),
                                  //   decoration: BoxDecoration(
                                  //     borderRadius:
                                  //         BorderRadius.all(Radius.circular(10)),
                                  //     color: Colors.white.withOpacity(0.1),
                                  //   ),
                                  //   child: Column(
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.start,
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceEvenly,
                                  //     children: [
                                  //       Text("Email ID",
                                  //           style: TextStyle(
                                  //               color: Colors.white,
                                  //               fontSize: width / 24,
                                  //               fontFamily: 'Roboto',
                                  //               fontWeight: FontWeight.w400)),
                                  //       Text(
                                  //           viewModel.email == null
                                  //               ? "Add Now"
                                  //               : viewModel.email,
                                  //           style: TextStyle(
                                  //               color: Colors.white.withOpacity(0.6),
                                  //               fontSize: width / 26,
                                  //               fontFamily: 'Roboto',
                                  //               fontWeight: FontWeight.w400))
                                  //     ],
                                  //   ),
                                  // ),
                                  GestureDetector(
                                    onTap: () {
                                      viewModel.inputDialog(
                                          context, width, height);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
                                      width: width * 0.9,
                                      margin:
                                          EdgeInsets.only(top: height * 0.02),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color:
                                            Colors.white.withOpacity(0.1),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Mobile No.",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width / 24,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400)),
                                          Text(
                                              viewModel.phno == null
                                                  ? "Add Now"
                                                  : viewModel.phno,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width / 26,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400))
                                        ],
                                      ),
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () => viewModel.passwordDialog(
                                  //       context, width, height),
                                  //   child: Container(
                                  //     width: width * 0.9,
                                  //     padding:EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
                                  //     margin:
                                  //         EdgeInsets.only(top: height * 0.02),
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(10)),
                                  //       color:
                                  //           Colors.white.withOpacity(0.1),
                                  //     ),
                                  //     child: Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceEvenly,
                                  //       children: [
                                  //         Text("Password",
                                  //             style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontSize: width / 24,
                                  //                 fontFamily: 'Roboto',
                                  //                 fontWeight: FontWeight.w400)),
                                  //         Text("**************",
                                  //             style: TextStyle(
                                  //                 color: Colors.white.withOpacity(0.6),
                                  //                 fontSize: width / 25,
                                  //                 fontFamily: 'Roboto',
                                  //                 fontWeight: FontWeight.w400)),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    margin: EdgeInsets.only(top: height * 0.03),
                                    alignment: Alignment.centerLeft,
                                    child: Text("Manage Subscriptions",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width / 24,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Roboto',
                                        )),
                                  ),
                                  Container(
                                    width: width * 0.9,
                                    padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
                                    margin: EdgeInsets.only(top: height * 0.02),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Your membership",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width / 24,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400)),
                                        Text("Coming soon!",
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.6),
                                                fontSize: width / 26,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400)),
                                        Text("\nUser ID",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width / 24,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400)),
                                        Text(viewModel.id,
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.6),
                                                fontSize: width / 26,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ),
                            GestureDetector(
                              onTap: null,
                              child: Container(
                                  width: width * 0.9,
                                  padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
                                  margin: EdgeInsets.only(top: height * 0.02),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                child: Text('Renew Subscription',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width / 24,
                                    fontFamily: 'Roboto',
                                  ),
                              )),
                            ),
                                  GestureDetector(
                                    onTap: null,
                                    child: Container(
                                        width: width * 0.9,
                                        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
                                        margin: EdgeInsets.only(top: height * 0.02),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                          color: Colors.white.withOpacity(0.1),
                                        ),
                                        child: Text('Cancel Subscription',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width / 24,
                                            fontFamily: 'Roboto',
                                          ),
                                        )),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(top: height * 0.03),
                                    alignment: Alignment.centerLeft,
                                    child: Text("Personalisation",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width / 24,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Roboto',
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: height * 0.02,
                                        bottom: height * 0.02),
                                    width: width * 0.9,
                                    padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('Background Music',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width / 24,
                                                  fontFamily: 'Roboto',
                                                )),
                                          ),
                                        Transform.scale(
                                              scale: 1.4,
                                              child: Switch(
                                                  activeColor:  Themes.color.withOpacity(0.5),
                                                  inactiveTrackColor:
                                                      Colors.white.withOpacity(0.3),
                                                  inactiveThumbColor:
                                                      Colors.white.withOpacity(0.6),
                                                  activeTrackColor:
                                                      Colors.white,
                                                  value: viewModel.switchValue,
                                                  onChanged: viewModel
                                                      .changeSwitchValue)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(bottom: height * 0.02),
                                    padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
                                    width: width * 0.9,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('App Lock',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width / 24,
                                                  fontFamily: 'Roboto',
                                                )),
                                          ),
                                        Transform.scale(
                                              scale: 1.4,
                                              child: Switch(
                                                  activeColor:  Themes.color.withOpacity(0.5),
                                                  inactiveTrackColor:
                                                  Colors.white.withOpacity(0.3),
                                                  inactiveThumbColor:
                                                  Colors.white.withOpacity(0.6),
                                                  activeTrackColor:
                                                  Colors.white,
                                                  value: viewModel.applock,
                                                  onChanged:
                                                      viewModel.changeAppLock)),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        )))));
      },
      viewModelBuilder: () => EditSettingsPageViewModel(),
    );
  }
}
