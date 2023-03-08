import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'OTP_view_model.dart';
import 'dart:ui';

class OTPView extends StatelessWidget {
  final bool login;
  const OTPView({Key key, this.login}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return ViewModelBuilder<OTPViewModel>.reactive(
      builder: (BuildContext context, OTPViewModel viewModel, Widget _) {
        return GestureDetector(
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
                              top: height * 0.2, bottom: height * 0.355),
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
                                  controller: viewModel.otpController,
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
                                      labelText: "OTP",
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
                                        .withOpacity(0.25))),
                          ],
                        ),
                        Text(" \n", style: TextStyle(fontSize: 14),),
                        SizedBox(height: height * 0.08),
                        Text(" ", style: TextStyle(fontSize: 14),),
                        viewModel.isBusy
                            ? Center(
                            child: SpinKitWanderingCubes(
                              color: Colors.white,
                              size: 40,
                              duration: Duration(milliseconds: 1200),
                            ))
                            : GestureDetector(
                          onTap: () {
                            viewModel.verify(login);
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
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                                  color: Color(0xff5a5ed0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Text("VERIFY",
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
      viewModelBuilder: () => OTPViewModel(),
    );
  }
}
