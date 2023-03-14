// import 'dart:async';
// import 'dart:ui';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'package:vitalminds/views/email_verification_page/email_verification_view_model.dart';
// import 'package:vitalminds/views/home/home_view.dart';

// class EmailVerificcationView extends StatefulWidget {
//   const EmailVerificcationView({Key key}) : super(key: key);

//   @override
//   State<EmailVerificcationView> createState() => _EmailVerificcationViewState();
// }

// class _EmailVerificcationViewState extends State<EmailVerificcationView> {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return ViewModelBuilder<EmailVerificationViewModel>.reactive(
//       builder: (BuildContext context, EmailVerificationViewModel viewModel,
//           Widget _) {
//         return viewModel.isEmailVerified
//             ? HomeView()
//             : GestureDetector(
//                 onTap: () {
//                   FocusScope.of(context).requestFocus(new FocusNode());
//                 },
//                 child: Scaffold(
//                   body: SingleChildScrollView(
//                     child: Container(
//                       width: width,
//                       height: height,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                             colorFilter: ColorFilter.mode(
//                                 Color(0xff5a5ed0).withOpacity(0.28),
//                                 BlendMode.overlay),
//                             image: AssetImage(
//                               'assets/images/loginBG.png',
//                             ),
//                             fit: BoxFit.cover),
//                       ),
//                       child: new BackdropFilter(
//                         filter:
//                             new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.only(top: height * 0.2),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding:
//                                           EdgeInsets.only(left: width * 0.08),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text("Welcome to MyVitalMind",
//                                               style: TextStyle(
//                                                   fontFamily: 'Roboto',
//                                                   color:
//                                                       const Color(0xffffffff),
//                                                   fontWeight: FontWeight.w700,
//                                                   fontStyle: FontStyle.normal,
//                                                   fontSize: 25.0),
//                                               textAlign: TextAlign.left),
//                                           Text("",
//                                               style: TextStyle(fontSize: 8)),
//                                           Text(
//                                               "Prioritize your journey to well being",
//                                               style: TextStyle(
//                                                   color:
//                                                       const Color(0xffffffff),
//                                                   fontFamily: 'Roboto',
//                                                   fontWeight: FontWeight.w500,
//                                                   fontStyle: FontStyle.normal,
//                                                   fontSize: 15.0),
//                                               textAlign: TextAlign.left)
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.only(
//                                     top: height * 0.15, bottom: height * 0.03),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Text("Email Verification",
//                                             style: TextStyle(
//                                                 fontFamily: 'Roboto',
//                                                 color: const Color(0xffffffff),
//                                                 fontWeight: FontWeight.w700,
//                                                 fontStyle: FontStyle.normal,
//                                                 fontSize: 25.0),
//                                             textAlign: TextAlign.left),
//                                         Text("", style: TextStyle(fontSize: 8)),
//                                         Text(
//                                             "Kindly verify the verification email sent to your Email.",
//                                             style: TextStyle(
//                                                 color: const Color(0xffffffff),
//                                                 fontFamily: 'Roboto',
//                                                 fontWeight: FontWeight.w500,
//                                                 fontStyle: FontStyle.normal,
//                                                 fontSize: 15.0),
//                                             textAlign: TextAlign.left)
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   // FocusScope.of(context).unfocus();
//                                   // viewModel.login();
//                                   // if (viewModel.canResendEmail) {
//                                   viewModel.sendVerificationEmail();
//                                   // }
//                                 },
//                                 child: Opacity(
//                                   opacity: 1,
//                                   child: Container(
//                                     margin: EdgeInsets.only(
//                                       top: height * 0.03,
//                                     ),
//                                     width: width * 0.83,
//                                     height: height * 0.06,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(6)),
//                                         color: Color(0xff5a5ed0)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Text("Resend Email",
//                                             style: TextStyle(
//                                                 color: const Color(0xffffffff),
//                                                 fontWeight: FontWeight.w700,
//                                                 fontStyle: FontStyle.normal,
//                                                 fontSize: 16.0),
//                                             textAlign: TextAlign.left),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   viewModel.signOut();
//                                 },
//                                 // viewModel.navigateToRegister(),
//                                 child: Padding(
//                                   padding: EdgeInsets.only(top: height * 0.04),
//                                   child: Text("Cancel",
//                                       style: TextStyle(
//                                           fontFamily: 'Roboto',
//                                           color: const Color(0xffffffff),
//                                           fontWeight: FontWeight.w700,
//                                           fontStyle: FontStyle.normal,
//                                           fontSize: 14.0),
//                                       textAlign: TextAlign.left),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//       },
//       viewModelBuilder: () => EmailVerificationViewModel(),
//     );
//   }
// }
