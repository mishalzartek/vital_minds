import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:vitalminds/main.dart';
import 'package:vitalminds/views/settings_page/settings_page_view_model.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import '../../widgets/dumb_widgets/Themes.dart';
import 'settings_page_view_model.dart';

class SettingsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var topPadding = MediaQuery.of(context).padding.top;
    return ViewModelBuilder<SettingsPageViewModel>.reactive(
      builder:
          (BuildContext context, SettingsPageViewModel viewModel, Widget _) {
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
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + height * 0.01),
                child: Column(
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
                      viewModel.navigateToHomePage();
                    }),
              ),
                        SizedBox(width: width * 0.02,),
                        Text("Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width / 27,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto',
                            )),
                      ],
                    ),
                    SizedBox(height: height * 0.02,),
                    Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width / 4,
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            child: Stack(children: [
                              ClipOval(
                                  child: viewModel.image == null
                                      ? Center(
                                          child: Text(
                                          "   No\nProfile\nPhoto",
                                          style: TextStyle(
                                              fontSize: height * 0.016,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontFamily: 'Roboto'),
                                        ))
                                      : PhotoHero(
                                          photo: viewModel.image,
                                          height: width * 5.5,
                                          width: width * 5.5,
                                          contain: false,
                                          onTap: () {
                                            Navigator.of(context).push(
                                                PageRouteBuilder(
                                                    opaque: false,
                                                    barrierDismissible: true,
                                                    pageBuilder:
                                                        (BuildContext context,
                                                            _, __) {
                                                      return BackdropFilter(
                                                        filter: new ImageFilter
                                                                .blur(
                                                            sigmaX: 4.0,
                                                            sigmaY: 4.0),
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      height *
                                                                          0.1,
                                                                  horizontal:
                                                                      width *
                                                                          0.1),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          child: PhotoHero(
                                                            photo:
                                                                viewModel.image,
                                                            height: width * 7,
                                                            width: width * 7,
                                                            contain: true,
                                                          ),
                                                        ),
                                                      );
                                                    }));
                                            // viewModel.showProfilePic(context, viewModel.image);
                                          },
                                        )),
                              Positioned(
                                bottom: 0,
                                right:
                                    0, //give the values according to your requirement
                                child: GestureDetector(
                                  onTap: () => viewModel.showPicker(context),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Colors.white,
                                    radius: width * 0.04,
                                    child: Center(
                                        child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: width * 0.05,
                                      color: Themes.color,
                                    )),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.03),
                            child: viewModel.name == null
                                ? SpinKitWanderingCubes(
                                    color: Colors.white,
                                    size: 40,
                                    duration: Duration(milliseconds: 1200),
                                  )
                                : Text(viewModel.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width / 15,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    Divider(
                      color: Colors.white.withOpacity(0.4),
                      thickness: height * 0.0006,
                      height: height * 0.04,
                    ),
                    Card(
                      margin: EdgeInsets.zero,
                        shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0)),
                        elevation: 0,
                        color: Colors.white.withOpacity(0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.03, top: height * 0.01),
                              child: Text("Theme",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width / 24,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(width * 0.1,
                                  height * 0.015, width * 0.1, height * 0.025),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  for (var colour in Themes.colors)
                                    GestureDetector(
                                      onTap: () async {
                                        await viewModel.themeChange(colour);
                                        int temp =
                                            Themes.colors.indexOf(colour);
                                        getThemeManager(context)
                                            .selectThemeAtIndex(temp);
                                        //log("$color");
                                      },
                                      child: Container(
                                          height: width / 18,
                                          width: width / 18,
                                          decoration: BoxDecoration(
                                              color: colour,
                                              border: Themes.colors[Themes.colors.indexOf(colour)] == Themes.color ? Border.all(color: Colors.white, width: 2) : Border.all(color: Colors.transparent),
                                              shape: BoxShape.circle, ),
                                        )
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: viewModel.titles.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Center(
                            child: GestureDetector(
                              onTap: () => viewModel.navigate(i),
                              child: Container(
                                padding: EdgeInsets.only(top: height / 200),
                                width: width * 0.90,
                                child: Card(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0)),
                                  margin: EdgeInsets.only(
                                      top: height * 0.0075),
                                  elevation: 0,
                                  color: Colors.white.withOpacity(0.1),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: height * 0.013,
                                        left: width * 0.05,
                                        bottom: height * 0.015),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: height * 0.1 * 0.05),
                                          child: Text(viewModel.titles[i],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width / 25,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Roboto',
                                              )),
                                        ),
                                        Text(viewModel.descriptions[i],
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.6),
                                                fontSize: width / 34,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: height * 0.015, bottom: height * 0.01),
                      width: width * 0.9,
                      padding: EdgeInsets.all(height / 200),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: TextButton(
                        onPressed: viewModel.signOut,
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.015),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('LOG OUT',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: width / 25,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => SettingsPageViewModel(),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero(
      {Key key, this.photo, this.onTap, this.width, this.height, this.contain})
      : super(key: key);

  final File photo;
  final VoidCallback onTap;
  final double width;
  final double height;
  final bool contain;
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: onTap,
              child: FadeInImage(
                fadeInDuration: Duration(milliseconds: 300),
                image: MemoryImage(photo.readAsBytesSync()),
                height: height,
                width: width,
                fit: !contain ? BoxFit.cover : BoxFit.contain,
                placeholder: MemoryImage(kTransparentImage),
              )),
        ),
      ),
    );
  }
}
