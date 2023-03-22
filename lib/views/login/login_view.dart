import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (BuildContext context, LoginViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Color(0xff5a5ed0).withOpacity(0.28),
                          BlendMode.overlay),
                      image: AssetImage(
                        'assets/images/loginBG.png',
                      ),
                      fit: BoxFit.cover),
                ),
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: height * 0.2, bottom: height * 0.27),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.08),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Welcome to MyVitalMind",
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 25.0),
                                        textAlign: TextAlign.left),
                                    Text("", style: TextStyle(fontSize: 8)),
                                    Text(
                                        "Prioritize your journey to well being",
                                        style: TextStyle(
                                            color: const Color(0xffffffff),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0),
                                        textAlign: TextAlign.left)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: viewModel.loginSwitch == 1
                        //       ? height * 0.05 + height * 0.075 + height * 0.01
                        //       : height * 0.05,
                        // ),
                        Column(
                          children: [
                            Container(
                              width: width * 0.9,
                              height: height * 0.075,
                              child: Stack(
                                children: [
                                  // IconButton(onPressed: (){}, icon: Icon(Icons.cancel_outlined)),
                                  TextFormField(
                                    onChanged: (value) {
                                      //? disable textfield if user entered phone number more than 10 digitis
                                      // viewModel.enabledTextField();
                                      // log(viewModel.enabled.toString());
                                    },
                                    enabled: viewModel.enabled,
                                    focusNode: viewModel.email,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        // color: const Color(0xff273348),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16.0),
                                    controller: viewModel.phNumberController,
                                    // onEditingComplete: () {
                                    //   viewModel.changeOpacity(
                                    //       0,
                                    //       viewModel.loginSwitch == 0
                                    //           ? viewModel.emailController
                                    //           : viewModel.phNumberController);
                                    //   FocusScope.of(context).nextFocus();
                                    // },
                                    keyboardType: TextInputType.number,
                                    decoration: new InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: height * 0.020,
                                          bottom: height * 0.020,
                                          left: width * 0.05),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      labelText: "Phone Number",
                                      labelStyle: TextStyle(
                                          color: viewModel.flags[0]
                                              ? Color.fromRGBO(39, 51, 72, 1)
                                              : Colors.white,
                                          fontFamily: 'Roboto',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                color: const Color(0xffffffff)
                                    .withOpacity(viewModel.op[0]),
                              ),
                            ),
                            // Column(
                            //   children: [
                            //     SizedBox(
                            //       height: height * 0.01,
                            //     ),
                            //     Container(
                            //         width: width * 0.9,
                            //         height: height * 0.075,
                            //         child: TextField(
                            //           obscureText: true,
                            //           style: TextStyle(
                            //               fontFamily: 'Roboto',
                            //               // color: const Color(0xff273348),
                            //               color: Colors.white,
                            //               fontWeight: FontWeight.w600,
                            //               fontStyle: FontStyle.normal,
                            //               fontSize: 16.0),
                            //           controller: viewModel.passwordController,
                            //           // onSubmitted: (_) {
                            //           //   viewModel.changeOpacity(1,
                            //           //       viewModel.passwordController);
                            //           //   FocusScope.of(context).unfocus();
                            //           // },
                            //           decoration: new InputDecoration(
                            //               contentPadding: EdgeInsets.only(
                            //                   top: height * 0.020,
                            //                   bottom: height * 0.020,
                            //                   left: width * 0.05),
                            //               border: InputBorder.none,
                            //               focusedBorder: InputBorder.none,
                            //               enabledBorder: InputBorder.none,
                            //               errorBorder: InputBorder.none,
                            //               disabledBorder: InputBorder.none,
                            //               labelText: "Password",
                            //               labelStyle: TextStyle(
                            //                   color: viewModel.flags[1]
                            //                       ? Color.fromRGBO(
                            //                           39, 51, 72, 1)
                            //                       : Colors.white,
                            //                   fontFamily: 'Roboto',
                            //                   fontSize: 15,
                            //                   fontWeight: FontWeight.w500)),
                            //         ),
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.all(
                            //                 Radius.circular(6)),
                            //             color: const Color(0xffffffff)
                            //                 .withOpacity(viewModel.op[1]))),
                            //   ],
                            // ),
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Container(
                            //     width: width * 0.9,
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         Padding(
                            //           padding:
                            //               EdgeInsets.only(top: height * 0.01),
                            //           child: Text("\n" + 'kk',
                            //               style: TextStyle(
                            //                   fontFamily: 'Roboto',
                            //                   color: const Color(0xffffffff),
                            //                   fontWeight: FontWeight.w600,
                            //                   fontStyle: FontStyle.normal,
                            //                   fontSize: 14.0),
                            //               textAlign: TextAlign.left),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Container(
                              width: width * 0.9,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // if (viewModel.loginSwitch == 0)
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.08),
                                    child: SizedBox()
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: height * 0.08),
                                        child: Text("New User?  ",
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.left),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                        // FirebaseCrashlytics.instance.crash(),
                                            viewModel.navigateToRegister();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.08),
                                          child: Text("Register",
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color:
                                                      const Color(0xffffffff),
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.left),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: height * 0.05,
                        // ),
                        viewModel.isBusy
                            ? Center(
                                child: SpinKitWanderingCubes(
                                color: Themes.color,
                                size: 40,
                                duration: Duration(milliseconds: 1200),
                              ))
                            : GestureDetector(
                                onTap: () {
                                  // FocusScope.of(context).unfocus();
                                  viewModel.login();
                                },
                                child: Opacity(
                                  opacity: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: height * 0.03,
                                        bottom: height * 0.03),
                                    width: width * 0.83,
                                    height: height * 0.07,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        color: Color(0xff5a5ed0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("LOGIN",
                                            style: TextStyle(
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16.0),
                                            textAlign: TextAlign.left),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
