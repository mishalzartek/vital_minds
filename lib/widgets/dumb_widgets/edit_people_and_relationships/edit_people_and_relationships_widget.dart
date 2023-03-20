// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
// import 'package:substring_highlight/substring_highlight.dart';
// import 'package:vitalminds/core/app/logger.dart';
// import 'package:vitalminds/main.dart';
// import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
// import 'package:vitalminds/widgets/dumb_widgets/info_dialog.dart';
// import 'package:vitalminds/widgets/smart_widgets/journal/journal_view_model.dart';

// class EditPeopleAndRelationshipsWidget extends StatefulWidget {
//   final JournalViewModel viewModel;
//   final DateTime currentDate;
//   final int position;
//   const EditPeopleAndRelationshipsWidget(
//       {Key key, this.viewModel, this.currentDate, this.position})
//       : super(key: key);

//   @override
//   _EditPeopleAndRelationshipsWidgetState createState() =>
//       _EditPeopleAndRelationshipsWidgetState();
// }

// class _EditPeopleAndRelationshipsWidgetState
//     extends State<EditPeopleAndRelationshipsWidget> {
//   ScrollController _controller = new ScrollController();
//   List<FocusNode> focusNodes = [];
//   String term;
//   List suggestions;
//   Logger log;

//   void buildSuggestions(String value, List names) {
//     suggestions = [];
//     setState(() {
//       term = value;
//       for (String name in names) {
//         if (name.contains(new RegExp('$value', caseSensitive: false))) {
//           suggestions.add(name);
//         }
//       }
//     });
//   }

//   void initiateScroll(int height) async {
//     setState(() {
//       _controller = ScrollController(initialScrollOffset: height * 200.0);
//     });
//   }

//   void _onFocusChange(FocusNode nameFocusNode, int index) {
//     log.i("Index $index ");
//     if (!nameFocusNode.hasFocus) {
//       String name = widget.viewModel.peopleAndRelationshipsControllers[index]
//           .person_controller.text;
//       name.length >= 2
//           ? widget.viewModel.names
//               .add(name[0].toUpperCase() + name.toLowerCase().substring(1))
//           : name.trim() == ''
//               ? name = name
//               : widget.viewModel.names.add(name.toUpperCase());
//       widget.viewModel.names = widget.viewModel.names.toSet().toList();
//       widget.viewModel.names.sort();
//       buildSuggestions('', widget.viewModel.names);
//     }
//     log.i("Focus : " + nameFocusNode.hasFocus.toString());
//   }

//   void createFocusNodes() {
//     for (int i = 0;
//         i < widget.viewModel.peopleAndRelationshipsArray.length;
//         i++) {
//       FocusNode nameFocusNode = new FocusNode();
//       nameFocusNode.addListener(() {
//         _onFocusChange(nameFocusNode, i);
//       });
//       focusNodes.add(nameFocusNode);
//     }
//   }

//   @override
//   void initState() {
//     this.log = getLogger(this.runtimeType.toString());
//     widget.viewModel.names = widget.viewModel.names.toSet().toList();
//     widget.viewModel.names.sort();
//     buildSuggestions('', widget.viewModel.names);
//     initiateScroll(widget.position);
//     createFocusNodes();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     //_controller.dispose();
//     super.dispose();
//   }

//   void changeMood(int index, int mood) {
//     setState(() {
//       widget.viewModel.peopleAndRelationshipsControllers[index].relationship =
//           mood;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     var topPadding = MediaQuery.of(context).padding.top;
//     return WillPopScope(
//       onWillPop: () async {
//         widget.viewModel.createPeopleAndRelationshipsArray().whenComplete(() {
//           widget.viewModel.cancelNotification();
//           return true;
//         });
//         return true;
//       },
//       child: Scaffold(
//           body: Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                     colorFilter:
//                         ColorFilter.mode(Themes.color, BlendMode.modulate),
//                     image: myImage,
//                     fit: BoxFit.cover),
//               ),
//               width: width,
//               height: height,
//               child: new BackdropFilter(
//                 filter: new ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
//                 child: Container(
//                   margin: EdgeInsets.only(
//                     top: 1.4 * topPadding,
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(left: width * 0.05),
//                                 child: CircleAvatar(
//                                   backgroundColor:
//                                       Colors.white.withOpacity(0.2),
//                                   radius: width / 30,
//                                   child: IconButton(
//                                       padding: EdgeInsets.all(0),
//                                       icon: Icon(
//                                         Icons.chevron_left,
//                                         color: Colors.white,
//                                         size: 20,
//                                       ),
//                                       onPressed: () {
//                                         widget.viewModel
//                                             .createPeopleAndRelationshipsArray()
//                                             .whenComplete(() => {
//                                                   widget.viewModel
//                                                       .cancelNotification(),
//                                                   widget.viewModel.goBack()
//                                                 });
//                                       }),
//                                 ),
//                               ),
//                               Padding(
//                                   padding: EdgeInsets.only(left: width * 0.03),
//                                   child: Text(
//                                     DateFormat.yMMMMd()
//                                         .format(widget.currentDate)
//                                         .toString(),
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w600,
//                                         fontFamily: "Roboto",
//                                         fontStyle: FontStyle.normal,
//                                         fontSize: 16.0),
//                                   )),
//                             ],
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(right: width * 0.05),
//                             child: InfoDialog(type: 3),
//                           )
//                         ],
//                       ),
//                       Expanded(
//                         child: Container(
//                           margin: EdgeInsets.only(top: height * 0.03),
//                           color: Colors.white.withOpacity(0.1),
//                           child: SingleChildScrollView(
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: height * 0.03,
//                                   horizontal: width * 0.05),
//                               child: Container(
//                                 height: height * 0.82,
//                                 child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Text("People and relationships",
//                                               style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.w600,
//                                                   fontFamily: "Roboto",
//                                                   fontStyle: FontStyle.normal,
//                                                   fontSize: 20.0),
//                                               textAlign: TextAlign.left),
//                                           Column(
//                                             children: <Widget>[
//                                               Container(
//                                                 margin: EdgeInsets.only(
//                                                     left: 10,
//                                                     right: 10,
//                                                     bottom: 5),
//                                                 decoration: BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   color: Colors.white
//                                                       .withOpacity(0.1),
//                                                 ),
//                                                 width: 40,
//                                                 height: 40,
//                                                 child: IconButton(
//                                                     padding: EdgeInsets.all(0),
//                                                     onPressed: () {
//                                                       FocusNode nameFocusNode =
//                                                           new FocusNode();
//                                                       nameFocusNode
//                                                           .addListener(() {
//                                                         _onFocusChange(
//                                                             nameFocusNode,
//                                                             widget
//                                                                     .viewModel
//                                                                     .peopleAndRelationshipsControllers
//                                                                     .length -
//                                                                 1);
//                                                       });
//                                                       setState(() {
//                                                         widget.viewModel
//                                                             .addPeopleAndRelationships();
//                                                         focusNodes
//                                                             .add(nameFocusNode);
//                                                         if (_controller
//                                                             .hasClients) {
//                                                           _controller.animateTo(
//                                                             _controller.position
//                                                                     .maxScrollExtent +
//                                                                 height * 0.2,
//                                                             curve: Curves
//                                                                 .fastOutSlowIn,
//                                                             duration:
//                                                                 const Duration(
//                                                                     milliseconds:
//                                                                         800),
//                                                           );
//                                                         }
//                                                       });
//                                                     },
//                                                     icon: Icon(
//                                                         Icons.group_outlined,
//                                                         color: Colors.white)),
//                                               ),
//                                               Text("Add",
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       fontFamily: "Roboto",
//                                                       fontStyle:
//                                                           FontStyle.normal,
//                                                       fontSize: 14.0),
//                                                   textAlign: TextAlign.left),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                       widget
//                                                   .viewModel
//                                                   .peopleAndRelationshipsControllers
//                                                   .length ==
//                                               0
//                                           ? Container(
//                                               margin: EdgeInsets.only(
//                                                   top: height * 0.04),
//                                               padding: EdgeInsets.all(15),
//                                               decoration: BoxDecoration(
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                       color: Themes.color
//                                                           .withOpacity(0.2),
//                                                       blurRadius: 12)
//                                                 ],
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 color: Colors.white
//                                                     .withOpacity(0.1),
//                                               ),
//                                               child: Column(
//                                                 children: [
//                                                   Text(
//                                                       'No data has been entered for this page, click the "Add" button to add data.',
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontFamily: "Roboto",
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                           fontStyle:
//                                                               FontStyle.normal,
//                                                           fontSize: 14.0)),
//                                                 ],
//                                               ),
//                                             )
//                                           : Expanded(
//                                               child: ListView.builder(
//                                                 controller: _controller,
//                                                 padding: EdgeInsets.only(
//                                                     top: height * 0.03),
//                                                 shrinkWrap: true,
//                                                 itemCount: widget
//                                                     .viewModel
//                                                     .peopleAndRelationshipsControllers
//                                                     .length,
//                                                 itemBuilder:
//                                                     (BuildContext context,
//                                                         int index) {
//                                                   return Slidable(
//                                                     startActionPane: ActionPane(
//                                                       extentRatio: 0.25,
//                                                       motion: StretchMotion(),
//                                                       children: [
//                                                         SlidableAction(
//                                                           label: 'Delete',
//                                                           icon: Icons.delete,
//                                                           foregroundColor:
//                                                               Colors.white,
//                                                           backgroundColor:
//                                                               Colors
//                                                                   .transparent,
//                                                           onPressed: (c) {
//                                                             setState(() {
//                                                               widget.viewModel
//                                                                   .peopleAndRelationshipsControllers
//                                                                   .removeAt(
//                                                                       index);
//                                                               focusNodes
//                                                                   .removeAt(
//                                                                       index);
//                                                             });
//                                                           },
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     child: Container(
//                                                       margin: EdgeInsets.only(
//                                                           bottom: MediaQuery.of(
//                                                                       context)
//                                                                   .size
//                                                                   .height *
//                                                               0.02),
//                                                       decoration: BoxDecoration(
//                                                           color: Colors.white
//                                                               .withOpacity(0.1),
//                                                           border: Border.all(
//                                                               color: Colors
//                                                                   .transparent),
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           5))),
//                                                       child: Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: <Widget>[
//                                                           Padding(
//                                                             padding: EdgeInsets
//                                                                 .symmetric(
//                                                                     horizontal:
//                                                                         width *
//                                                                             0.02,
//                                                                     vertical:
//                                                                         height *
//                                                                             0.005),
//                                                             child: Stack(
//                                                               children: [
//                                                                 TextField(
//                                                                   textCapitalization:
//                                                                       TextCapitalization
//                                                                           .sentences,
//                                                                   controller: widget
//                                                                       .viewModel
//                                                                       .peopleAndRelationshipsControllers[
//                                                                           index]
//                                                                       .person_controller,
//                                                                   maxLines:
//                                                                       null,
//                                                                   focusNode:
//                                                                       focusNodes[
//                                                                           index],
//                                                                   onChanged:
//                                                                       (value) {
//                                                                     log.i(value
//                                                                         .toString());
//                                                                     buildSuggestions(
//                                                                         value,
//                                                                         widget
//                                                                             .viewModel
//                                                                             .names);
//                                                                   },
//                                                                   keyboardType:
//                                                                       TextInputType
//                                                                           .text,
//                                                                   cursorColor:
//                                                                       Colors
//                                                                           .white,
//                                                                   style: TextStyle(
//                                                                       fontFamily:
//                                                                           'Roboto',
//                                                                       fontSize:
//                                                                           height *
//                                                                               0.015,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w600,
//                                                                       color: Colors
//                                                                           .white),
//                                                                   decoration:
//                                                                       InputDecoration(
//                                                                     hintText:
//                                                                         'Add name of the person',
//                                                                     isDense:
//                                                                         true,
//                                                                     contentPadding: EdgeInsets.only(
//                                                                         top: height *
//                                                                             0.008,
//                                                                         bottom: height *
//                                                                             0.005),
//                                                                     hintStyle: TextStyle(
//                                                                         fontFamily:
//                                                                             'Roboto',
//                                                                         fontSize:
//                                                                             height *
//                                                                                 0.014,
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w600,
//                                                                         color: Colors
//                                                                             .white
//                                                                             .withOpacity(0.6)),
//                                                                     focusedBorder: UnderlineInputBorder(
//                                                                         borderSide: BorderSide(
//                                                                             width: height *
//                                                                                 0.001,
//                                                                             color:
//                                                                                 Colors.white)),
//                                                                     enabledBorder:
//                                                                         UnderlineInputBorder(
//                                                                             borderSide:
//                                                                                 BorderSide.none),
//                                                                   ),
//                                                                 ),
//                                                                 focusNodes[index]
//                                                                         .hasFocus
//                                                                     ? Container(
//                                                                         color: Colors
//                                                                             .white,
//                                                                         margin: EdgeInsets.only(
//                                                                             top: height *
//                                                                                 0.035),
//                                                                         child: createSuggestions(
//                                                                             widget.viewModel.peopleAndRelationshipsControllers[index].person_controller,
//                                                                             focusNodes[index]))
//                                                                     : Container()
//                                                               ],
//                                                             ),
//                                                           ),
//                                                           Container(
//                                                             margin: EdgeInsets
//                                                                 .symmetric(
//                                                                     vertical:
//                                                                         height *
//                                                                             0.01),
//                                                             child: Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .spaceEvenly,
//                                                               children: [
//                                                                 GestureDetector(
//                                                                   child:
//                                                                       CircleAvatar(
//                                                                     backgroundColor: widget.viewModel.peopleAndRelationshipsControllers[index].relationship ==
//                                                                             0
//                                                                         ? Colors
//                                                                             .white
//                                                                         : Colors
//                                                                             .transparent,
//                                                                     radius: 26,
//                                                                     child: SvgPicture
//                                                                         .asset(
//                                                                       'assets/icons/Icon awesome-tired.svg',
//                                                                       height:
//                                                                           36.0,
//                                                                       width:
//                                                                           36.0,
//                                                                       color: widget.viewModel.peopleAndRelationshipsControllers[index].relationship == 0
//                                                                           ? Themes
//                                                                               .color
//                                                                           : Colors
//                                                                               .white
//                                                                               .withOpacity(0.3),
//                                                                     ),
//                                                                   ),
//                                                                   onTap: () {
//                                                                     changeMood(
//                                                                         index,
//                                                                         0);
//                                                                   },
//                                                                 ),
//                                                                 GestureDetector(
//                                                                     child:
//                                                                         CircleAvatar(
//                                                                       backgroundColor: widget.viewModel.peopleAndRelationshipsControllers[index].relationship == 1
//                                                                           ? Colors
//                                                                               .white
//                                                                           : Colors
//                                                                               .transparent,
//                                                                       radius:
//                                                                           26,
//                                                                       child: SvgPicture
//                                                                           .asset(
//                                                                         'assets/icons/Icon awesome-angry.svg',
//                                                                         color: widget.viewModel.peopleAndRelationshipsControllers[index].relationship ==
//                                                                                 1
//                                                                             ? Themes.color
//                                                                             : Colors.white.withOpacity(0.3),
//                                                                         height:
//                                                                             36.0,
//                                                                         width:
//                                                                             36.0,
//                                                                       ),
//                                                                     ),
//                                                                     onTap: () {
//                                                                       changeMood(
//                                                                           index,
//                                                                           1);
//                                                                     }),
//                                                                 GestureDetector(
//                                                                     child:
//                                                                         CircleAvatar(
//                                                                       backgroundColor: widget.viewModel.peopleAndRelationshipsControllers[index].relationship == 2
//                                                                           ? Colors
//                                                                               .white
//                                                                           : Colors
//                                                                               .transparent,
//                                                                       radius:
//                                                                           26,
//                                                                       child: SvgPicture
//                                                                           .asset(
//                                                                         'assets/icons/Icon awesome-sad-tear.svg',
//                                                                         color: widget.viewModel.peopleAndRelationshipsControllers[index].relationship ==
//                                                                                 2
//                                                                             ? Themes.color
//                                                                             : Colors.white.withOpacity(0.3),
//                                                                         height:
//                                                                             36.0,
//                                                                         width:
//                                                                             36.0,
//                                                                       ),
//                                                                     ),
//                                                                     onTap: () {
//                                                                       changeMood(
//                                                                           index,
//                                                                           2);
//                                                                     }),
//                                                                 GestureDetector(
//                                                                     child:
//                                                                         CircleAvatar(
//                                                                       backgroundColor: widget.viewModel.peopleAndRelationshipsControllers[index].relationship == 3
//                                                                           ? Colors
//                                                                               .white
//                                                                           : Colors
//                                                                               .transparent,
//                                                                       radius:
//                                                                           26,
//                                                                       child: SvgPicture
//                                                                           .asset(
//                                                                         'assets/icons/Icon awesome-smile-1.svg',
//                                                                         color: widget.viewModel.peopleAndRelationshipsControllers[index].relationship ==
//                                                                                 3
//                                                                             ? Themes.color
//                                                                             : Colors.white.withOpacity(0.3),
//                                                                         height:
//                                                                             36.0,
//                                                                         width:
//                                                                             36.0,
//                                                                       ),
//                                                                     ),
//                                                                     onTap: () {
//                                                                       changeMood(
//                                                                           index,
//                                                                           3);
//                                                                     }),
//                                                                 GestureDetector(
//                                                                     child:
//                                                                         CircleAvatar(
//                                                                       backgroundColor: widget.viewModel.peopleAndRelationshipsControllers[index].relationship == 4
//                                                                           ? Colors
//                                                                               .white
//                                                                           : Colors
//                                                                               .transparent,
//                                                                       radius:
//                                                                           26,
//                                                                       child: SvgPicture
//                                                                           .asset(
//                                                                         'assets/icons/Icon awesome-smile.svg',
//                                                                         color: widget.viewModel.peopleAndRelationshipsControllers[index].relationship ==
//                                                                                 4
//                                                                             ? Themes.color
//                                                                             : Colors.white.withOpacity(0.3),
//                                                                         height:
//                                                                             36.0,
//                                                                         width:
//                                                                             36.0,
//                                                                       ),
//                                                                     ),
//                                                                     onTap: () {
//                                                                       changeMood(
//                                                                           index,
//                                                                           4);
//                                                                     }),
//                                                                 GestureDetector(
//                                                                     child:
//                                                                         CircleAvatar(
//                                                                       backgroundColor: widget.viewModel.peopleAndRelationshipsControllers[index].relationship == 5
//                                                                           ? Colors
//                                                                               .white
//                                                                           : Colors
//                                                                               .transparent,
//                                                                       radius:
//                                                                           26,
//                                                                       child: SvgPicture
//                                                                           .asset(
//                                                                         'assets/icons/Icon awesome-laugh.svg',
//                                                                         color: widget.viewModel.peopleAndRelationshipsControllers[index].relationship ==
//                                                                                 5
//                                                                             ? Themes.color
//                                                                             : Colors.white.withOpacity(0.3),
//                                                                         height:
//                                                                             36.0,
//                                                                         width:
//                                                                             36.0,
//                                                                       ),
//                                                                     ),
//                                                                     onTap: () {
//                                                                       changeMood(
//                                                                           index,
//                                                                           5);
//                                                                     }),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                                 EdgeInsets.only(
//                                                                     left: width *
//                                                                         0.02,
//                                                                     right:
//                                                                         width *
//                                                                             0.02,
//                                                                     bottom:
//                                                                         height *
//                                                                             0.02,
//                                                                     top: height *
//                                                                         0.01),
//                                                             child: TextField(
//                                                               textCapitalization:
//                                                                   TextCapitalization
//                                                                       .sentences,
//                                                               controller: widget
//                                                                   .viewModel
//                                                                   .peopleAndRelationshipsControllers[
//                                                                       index]
//                                                                   .notes_controller,
//                                                               maxLines: null,
//                                                               keyboardType:
//                                                                   TextInputType
//                                                                       .text,
//                                                               cursorColor:
//                                                                   Colors.white,
//                                                               style: TextStyle(
//                                                                   fontFamily:
//                                                                       'Roboto',
//                                                                   fontSize: 13,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w600,
//                                                                   color: Colors
//                                                                       .white),
//                                                               decoration:
//                                                                   InputDecoration(
//                                                                 hintText:
//                                                                     'Enter notes',
//                                                                 isDense: true,
//                                                                 hintStyle: TextStyle(
//                                                                     fontFamily:
//                                                                         'Roboto',
//                                                                     fontSize:
//                                                                         12,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w600,
//                                                                     color: Colors
//                                                                         .white
//                                                                         .withOpacity(
//                                                                             0.6)),
//                                                                 focusedBorder: UnderlineInputBorder(
//                                                                     borderSide:
//                                                                         BorderSide(
//                                                                             color:
//                                                                                 Colors.white)),
//                                                                 enabledBorder: UnderlineInputBorder(
//                                                                     borderSide: BorderSide(
//                                                                         color: Colors
//                                                                             .white
//                                                                             .withOpacity(0.6))),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   );
//                                                 },
//                                               ),
//                                             )
//                                     ]),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ))),
//     );
//   }

//   Widget createSuggestions(
//       TextEditingController controller, FocusNode focusNode) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Card(
//       margin: EdgeInsets.all(0),
//       child: Container(
//         color: Colors.transparent,
//         width: width * 0.9,
//         child: ListView.builder(
//             padding: EdgeInsets.all(0),
//             shrinkWrap: true,
//             itemCount: suggestions.length,
//             itemBuilder: (BuildContext context, int index) {
//               return GestureDetector(
//                 onTap: () {
//                   controller.text = suggestions[index];
//                   focusNode.unfocus();
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                       vertical: height * 0.005, horizontal: width * 0.01),
//                   child: SubstringHighlight(
//                     text: suggestions[index],
//                     term: term,
//                     textStyle: TextStyle(
//                         fontFamily: 'Roboto',
//                         fontSize: height * 0.015,
//                         fontWeight: FontWeight.w600,
//                         color: Color.fromRGBO(123, 138, 160, 1)),
//                     textStyleHighlight: TextStyle(
//                         fontFamily: 'Roboto',
//                         fontSize: height * 0.015,
//                         fontWeight: FontWeight.w600,
//                         color: Color.fromRGBO(39, 51, 72, 1)),
//                   ),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
