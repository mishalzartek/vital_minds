import 'dart:io';
import 'dart:ui';
import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:vitalminds/views/analytics_page/analytics_page_view.dart';
import 'package:vitalminds/views/calendar_page/calendar_page_view.dart';
import 'package:vitalminds/views/therapy_screen/therapy_screen_view.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import '../../main.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  HomeView([this.index, this.secondIndex]);
  final int index;
  final int secondIndex;
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (BuildContext context) {
              return BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: AlertDialog(
                  backgroundColor: Color.fromRGBO(236, 236, 236, 0.95),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  title: Center(
                    child: Text('Are you sure?',
                        style: TextStyle(
                            color: const Color(0xff273348),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.0)),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                        "Do you want to exit the app? All your changes will be saved.",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 13.5)),
                  ),
                  titlePadding: const EdgeInsets.all(20.0),
                  contentPadding: const EdgeInsets.all(15.0),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Exit',
                          style: TextStyle(
                              color: Themes.color,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0)),
                      onPressed: () {
                        exit(0);
                      },
                    ),
                    TextButton(
                      child: const Text('Cancel',
                          style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            })) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var topPadding = MediaQuery.of(context).padding.top;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: ViewModelBuilder<HomeViewModel>.reactive(
        builder: (BuildContext context, HomeViewModel viewModel, Widget _) {
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            return DefaultTabController(
              length: 3,
              initialIndex: widget.index ?? 1,
              child: Scaffold(
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: width,
                  decoration: BoxDecoration(
              image:
              DecorationImage(
                          colorFilter: ColorFilter.mode(Themes.color, BlendMode.modulate),
                        image: myImage,
                        fit: BoxFit.cover),
                  ),
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 1.2 * topPadding,
                              left: width * 0.05,
                              right: width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Hi There,",
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          // color: Colors.black54,
                                          color: Colors.white,
                                          fontSize: width / 25,
                                          fontWeight: FontWeight.w400)),
                                  viewModel.name == null || viewModel.name == ''
                                      ? SpinKitWanderingCubes(
                                          color: Themes.color,
                                          size: 40,
                                          duration:
                                              Duration(milliseconds: 1200),
                                        )
                                      : Text(viewModel.name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Roboto',
                                              fontSize: width / 16,
                                              fontWeight: FontWeight.w800))
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        viewModel.navigateToSettingsPage(),
                                    child: Container(
                                      margin: EdgeInsets.all(height * 0.01),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: width * 0.1,
                                            width: width * 0.1,
                                            child: viewModel.image != null
                                                ? ClipOval(
                                                    child: FadeInImage
                                                        .memoryNetwork(
                                                      fadeInDuration: Duration(
                                                          milliseconds: 300),
                                                      image: viewModel.image,
                                                      fit: BoxFit.cover,
                                                      placeholder:
                                                          kTransparentImage,
                                                    ),
                                                  )
                                                : viewModel.name == null ||
                                                        viewModel.name == ''
                                                    ? ClipOval(
                                                        child: CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor:
                                                              Colors.white
                                                                  .withOpacity(
                                                                      0.1),
                                                          child: Icon(
                                                            Icons
                                                                .person_outline,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    : ClipOval(
                                                        child: Container(
                                                          child: Avatar(
                                                            placeholderColors: [
                                                              Colors.grey
                                                            ],
                                                            shape: AvatarShape
                                                                .circle(20),
                                                            name:
                                                                viewModel.name,
                                                          ),
                                                        ),
                                                      ),
                                          ),
                                          SizedBox(height: 10,),
                                          Text("Profile",
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: width * 0.05,
                              right: width * 0.05,
                              top: height * 0.01,
                              bottom: height * 0.03),
                          height: MediaQuery.of(context).size.height * 0.065,
                          width: width,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.1),
                              border: Border.all(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: TabBar(
                            labelColor: Colors.white,
                            labelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            unselectedLabelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                            unselectedLabelColor:
                            Colors.white.withOpacity(0.4),
                            indicator: UnderlineTabIndicator(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.white),
                            ),
                            indicatorPadding:
                                EdgeInsets.symmetric(horizontal: width * 0.09),
                            indicatorWeight: 5.0,
                            tabs: [
                              Tab(text: "Therapy"),
                              Tab(text: "Calendar"),
                              Tab(text: "Analytics"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              TherapyScreenView(widget.secondIndex),
                              CalendarPageView(),
                              AnalyticsPageView(
                                selectedDate: DateTime.now(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "We do not support landscape orientation yet.\nPlease switch back to portrait mode to resume.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            );
          }
        },
        viewModelBuilder: () => HomeViewModel(),
      ),
    );
  }
}
