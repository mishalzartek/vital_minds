// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:intl/intl.dart';
// import 'package:vitalminds/widgets/smart_widgets/journal/journal_view_model.dart';

// import '../Themes.dart';

// class EditMyFocusesWidget extends StatelessWidget {
//   final JournalViewModel viewModel;
//   final DateTime currentDate;
//   const EditMyFocusesWidget({Key key, this.viewModel, this.currentDate})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     var topPadding = MediaQuery.of(context).padding.top;
//     return Scaffold(
//         body: WillPopScope(
//       onWillPop: () async {
//         viewModel.updateFocusStatus().whenComplete(() {
//           return true;
//         });
//         return true;
//       },
//       child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 scale: 3,
//                 colorFilter: Themes.bgMode,
//                 image: AssetImage(
//                   'assets/images/frosted2.png',
//                 ),
//                 fit: BoxFit.none),
//           ),
//           width: width,
//           height: height,
//           child: new BackdropFilter(
//             filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//             child: Container(
//               margin: EdgeInsets.only(
//                 top: 1.4 * topPadding,
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           viewModel
//                               .updateFocusStatus()
//                               .whenComplete(() => viewModel.goBack());
//                         },
//                         child: Container(
//                           margin: EdgeInsets.only(left: width * 0.05),
//                           width: width * 0.08,
//                           height: width * 0.08,
//                           decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(color: Colors.black.withOpacity(0.1))
//                               ],
//                               shape: BoxShape.circle,
//                               color: Colors.white.withOpacity(0.5)),
//                           child: Icon(Icons.chevron_left),
//                         ),
//                       ),
//                       Padding(
//                           padding: EdgeInsets.only(left: width * 0.03),
//                           child: Text(
//                             DateFormat.yMMMMd().format(currentDate).toString(),
//                             style: TextStyle(
//                                 color: const Color(0xff273348),
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: "SofiaPro",
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 16.0),
//                           )),
//                     ],
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.only(top: height * 0.03),
//                       color: Colors.white.withOpacity(0.6),
//                       child: SingleChildScrollView(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: height * 0.03,
//                               horizontal: width * 0.05),
//                           child: Container(
//                             height: height * 0.75,
//                             child: Column(children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   Text("My Focusses",
//                                       style: const TextStyle(
//                                           color: const Color(0xff273348),
//                                           fontWeight: FontWeight.w600,
//                                           fontFamily: "SofiaPro",
//                                           fontStyle: FontStyle.normal,
//                                           fontSize: 20.0),
//                                       textAlign: TextAlign.left),
//                                 ],
//                               ),
//                               FutureBuilder(
//                                   future: viewModel.futureForMyFocusses,
//                                   builder: (context, snapshot) {
//                                     return snapshot.connectionState ==
//                                             ConnectionState.waiting
//                                         ? Padding(
//                                             padding: const EdgeInsets.all(15.0),
//                                             child: SpinKitWanderingCubes(
//                                               color: Themes.color,
//                                               size: 40,
//                                               duration:
//                                                   Duration(milliseconds: 1200),
//                                             ),
//                                           )
//                                         : viewModel.myFocuses.length == 0
//                                             ? Container(
//                                                 margin: EdgeInsets.only(
//                                                     top: height * 0.04),
//                                                 padding: EdgeInsets.all(15),
//                                                 decoration: BoxDecoration(
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                         color: Themes.color
//                                                             .withOpacity(0.2),
//                                                         blurRadius: 12)
//                                                   ],
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   color: Colors.white
//                                                       .withOpacity(0.7),
//                                                 ),
//                                                 child: Column(
//                                                   children: [
//                                                     Text("NO DATA AVAILABLE!\n",
//                                                         style: TextStyle(
//                                                             color: Colors.red,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontFamily:
//                                                                 "SofiaPro",
//                                                             fontStyle: FontStyle
//                                                                 .normal,
//                                                             fontSize: 16.0)),
//                                                     Text(
//                                                         "No focusses entered in journal entry. Click the add button to add data.\n",
//                                                         style: TextStyle(
//                                                             color: const Color(
//                                                                 0xff273348),
//                                                             fontWeight:
//                                                                 FontWeight.w700,
//                                                             fontFamily:
//                                                                 "SofiaPro",
//                                                             fontStyle: FontStyle
//                                                                 .normal,
//                                                             fontSize: 14.0)),
//                                                   ],
//                                                 ),
//                                               )
//                                             : Expanded(
//                                                 child: ListView.builder(
//                                                   shrinkWrap: true,
//                                                   itemCount: viewModel
//                                                       .myFocuses.length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int index) {
//                                                     return FocusList(
//                                                         index,
//                                                         viewModel
//                                                             .myFocuses[index],
//                                                         viewModel);
//                                                   },
//                                                 ),
//                                               );
//                                   }),
//                             ]),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     ));
//   }
// }

// class FocusList extends StatefulWidget {
//   final String title;
//   final int index;
//   final JournalViewModel viewModel;
//   FocusList(this.index, this.title, this.viewModel);
//   @override
//   _FocusListState createState() => _FocusListState();
// }

// class _FocusListState extends State<FocusList> {
//   bool selected;
//   @override
//   void initState() {
//     selected = widget.viewModel.statusOfFocusses[widget.index];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(widget.title),
//       trailing: Checkbox(
//         activeColor: Themes.color,
//         // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
//         value: selected,
//         onChanged: (bool val) {
//           setState(() {
//             selected = val;
//             widget.viewModel.statusOfFocusses[widget.index] = val;
//             print("status : " + widget.viewModel.statusOfFocusses.toString());
//           });
//         },
//       ),
//     );
//   }
// }
