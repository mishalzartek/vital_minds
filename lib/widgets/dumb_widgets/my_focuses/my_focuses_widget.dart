// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:vitalminds/widgets/smart_widgets/journal/journal_view_model.dart';

// import '../Themes.dart';

// class MyFocuses extends StatelessWidget {
//   final JournalViewModel viewModel;
//   const MyFocuses({
//     Key key,
//     this.viewModel,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Container(
//       decoration: BoxDecoration(
//           color: Color.fromRGBO(255, 255, 255, 0.65),
//           border: Border.all(color: Colors.transparent),
//           borderRadius: BorderRadius.all(Radius.circular(5))),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Container(
//                   child: Row(
//                     children: [
//                       Text("My focuses",
//                           style: const TextStyle(
//                               color: const Color(0xff273348),
//                               fontWeight: FontWeight.w500,
//                               fontFamily: "Roboto",
//                               fontStyle: FontStyle.normal,
//                               fontSize: 12.0),
//                           textAlign: TextAlign.left),
//                       SizedBox(
//                         width: 7.0,
//                       ),
//                       Container(
//                         width: 3,
//                         height: 3,
//                         decoration: BoxDecoration(
//                           color: Themes.color,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         viewModel.enterMyFocussesAlert(context);
//                       },
//                       child: Container(
//                           margin: EdgeInsets.only(right: width * 0.1),
//                           child: Text("Add",
//                               style: TextStyle(
//                                   color: Themes.color,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: "Roboto",
//                                   fontSize: 12.0))),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         viewModel.goToEditFocussesPage(viewModel);
//                       },
//                       child: Container(
//                           margin: EdgeInsets.only(right: width * 0.05),
//                           child: Text("Edit",
//                               style: TextStyle(
//                                   color: Themes.color,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: "Roboto",
//                                   fontSize: 12.0))),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Opacity(
//             opacity: 0.30000001192092896,
//             child: Container(
//                 width: 348,
//                 height: 0,
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                         color: const Color(0xff7b8aa0), width: 0.5))),
//           ),
//           FutureBuilder(
//               future: viewModel.futureForMyFocusses,
//               builder: (context, snapshot) {
//                 return snapshot.connectionState == ConnectionState.waiting
//                     ? Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: SpinKitWanderingCubes(
//                           color: Themes.color,
//                           size: 40,
//                           duration: Duration(milliseconds: 1200),
//                         ),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: viewModel.myFocuses.length == 0
//                             ? Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                     "What about yourself would you like to change?",
//                                     style: const TextStyle(
//                                         color: const Color(0xffadb7c4),
//                                         fontWeight: FontWeight.w400,
//                                         fontFamily: "Roboto",
//                                         fontStyle: FontStyle.normal,
//                                         fontSize: 14.0),
//                                     textAlign: TextAlign.left),
//                               )
//                             : ListView.builder(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: viewModel.myFocuses.length,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return viewModel.statusOfFocusses[index]
//                                       ? Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: height * 0.01,
//                                               horizontal: width * 0.02),
//                                           child: Text(
//                                               viewModel.myFocuses[index],
//                                               style: const TextStyle(
//                                                   color:
//                                                       const Color(0xff273348),
//                                                   fontWeight: FontWeight.w600,
//                                                   fontFamily: "Roboto",
//                                                   fontStyle: FontStyle.normal,
//                                                   fontSize: 14.0),
//                                               textAlign: TextAlign.left),
//                                         )
//                                       : Container();
//                                 },
//                               ),
//                       );
//               }),
//         ],
//       ),
//     );
//   }
// }
