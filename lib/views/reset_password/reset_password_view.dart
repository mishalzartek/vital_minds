import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/views/reset_password/reset_password_view_model.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';

class ResetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<ResetViewModel>.reactive(
      builder: (BuildContext context, ResetViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
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
                          height: height * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.08),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Reset Password",
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 22.0),
                                        textAlign: TextAlign.left),
                                    Text(""),
                                    Text("           ",
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
                        SizedBox(
                          height: height * 0.05 + height * 0.075 + height * 0.01
                        ),
                        Column(
                          children: [
                            Container(
                                width: width * 0.9,
                                height: height * 0.075,
                                child: TextField(
                                  onTap: () {
                                    viewModel.email.requestFocus();
                                  },
                                  focusNode: viewModel.email,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      // color: const Color(0xff273348),
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0),
                                  controller: viewModel.passwordController,
                                  onEditingComplete: () {
                                    viewModel.changeOpacity(
                                        0,
                                        viewModel.passwordController);
                                    FocusScope.of(context).nextFocus();
                                  },
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
                                      labelText: "New Password",
                                      labelStyle: TextStyle(
                                          color: viewModel.flags[0]
                                              ? Color.fromRGBO(39, 51, 72, 1)
                                              : Colors.white,
                                          fontFamily: 'Roboto',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                    color: const Color(0xffffffff)
                                        .withOpacity(viewModel.op[0]))),

                            Container(
                              width: width * 0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: height * 0.08),
                                        child: Text(
                                            "New User?  ",
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.left),
                                      ),
                                      GestureDetector(
                                        onTap: () => viewModel.navigateToRegister(),
                                        child: Padding(
                                          padding:
                                          EdgeInsets.only(top: height * 0.08),
                                          child: Text(
                                              "Register",
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color: const Color(0xffffffff),
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
                            FocusScope.of(context).unfocus();
                            viewModel.forgotPassword();
                          },
                          child: Opacity(
                            opacity: 1,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.07,
                                  bottom: height * 0.03),
                              width: width * 0.83,
                              height: height * 0.07,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                                  color: Color(0xff5a5ed0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Text("RESET PASSWORD",
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
      viewModelBuilder: () => ResetViewModel(),
    );
  }
}
