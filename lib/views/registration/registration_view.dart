import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/views/registration/registration_view_model.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';

// ignore: must_be_immutable
class RegistrationView extends StatelessWidget {
  RegistrationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double op1 = 0.25;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<RegistrationViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Color(0xff5a5ed0).withOpacity(0.28), BlendMode.overlay),
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
                            top: height * 0.2, bottom: height * 0.1),
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
                                  Text(
                                    " ",
                                    style: TextStyle(fontSize: 8),
                                  ),
                                  Text(" Prioritize your journey to well being",
                                      style: TextStyle(
                                          color: const Color(0xffffffff),
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 15.0),
                                      textAlign: TextAlign.left)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                              width: width * 0.9,
                              height: height * 0.075,
                              child: TextField(
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    // color: const Color(0xff273348),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0),
                                controller: viewModel.nameController,
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
                                    labelText: "Name",
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  color: const Color(0xffffffff)
                                      .withOpacity(op1))),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                              width: width * 0.9,
                              height: height * 0.075,
                              child: TextField(
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    // color: const Color(0xff273348),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0),
                                controller: viewModel.ageController,
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
                                    labelText: "Age",
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  color: const Color(0xffffffff)
                                      .withOpacity(op1))),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                              width: width * 0.9,
                              height: height * 0.075,
                              child: TextField(
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    // color: const Color(0xff273348),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0),
                                controller: viewModel.loginSwitch == 0
                                    ? viewModel.emailController
                                    : viewModel.phNumberController,
                                keyboardType: viewModel.loginSwitch == 0
                                    ? TextInputType.emailAddress
                                    : TextInputType.number,
                                decoration: new InputDecoration(
                                    prefixText:
                                        viewModel.loginSwitch == 1 ? "+91" : "",
                                    prefixStyle: TextStyle(
                                        fontFamily: 'Roboto',
                                        // color: const Color(0xff273348),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16.0),
                                    contentPadding: EdgeInsets.only(
                                        top: height * 0.020,
                                        bottom: height * 0.012,
                                        left: width * 0.05),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    labelText: viewModel.loginSwitch == 0
                                        ? "Email"
                                        : "Phone Number",
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  color: const Color(0xffffffff)
                                      .withOpacity(op1))),

                          viewModel.loginSwitch == 1
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: height * 0.085,
                                      width: width * 0.9,
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Container(
                                        width: width * 0.9,
                                        height: height * 0.075,
                                        child: TextField(
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              // color: const Color(0xff273348),
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.0),
                                          controller:
                                              viewModel.passwordController,
                                          obscureText: true,
                                          decoration: new InputDecoration(
                                              prefixStyle: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  // color: const Color(0xff273348),
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.0),
                                              contentPadding: EdgeInsets.only(
                                                  top: height * 0.020,
                                                  bottom: height * 0.012,
                                                  left: width * 0.05),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              labelText: "Password",
                                              labelStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6)),
                                            color: const Color(0xffffffff)
                                                .withOpacity(op1))),
                                  ],
                                ),
                          GestureDetector(
                            onTap: () => viewModel.loginToggle(),
                            child: Container(
                              width: width * 0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.01),
                                    child: Text("\n" + viewModel.switchText,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.0),
                                        textAlign: TextAlign.left),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //SizedBox(height: height * 0.1,),
                          Container(
                            width: width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.08),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Existing user?  ",
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.0),
                                        textAlign: TextAlign.left,
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            viewModel.navigateToLogin(),
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              color: const Color(0xffffffff),
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.0),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      viewModel.isBusy
                          ? Center(
                              child: SpinKitWanderingCubes(
                              color: Themes.color,
                              size: 40,
                              duration: Duration(milliseconds: 1200),
                            ))
                          : GestureDetector(
                              onTap: () {
                                viewModel.register();
                              },
                              child: Opacity(
                                opacity: 1,
                                child: Container(
                                  width: width * 0.83,
                                  height: height * 0.07,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    // color: const Color(0xff6d71f9)
                                    color: Color(0xff5a5ed0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("REGISTER",
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
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
      ),
      viewModelBuilder: () => RegistrationViewModel(),
    );
  }
}
