import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vitalminds/main.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'package:vitalminds/widgets/smart_widgets/videos_home_page/videos_home_page_view_model.dart';

class VideoDetailsPageWidget extends StatelessWidget {
  VideoDetailsPageWidget(this.viewModel, this.title, this.videosList);

  final VideosHomePageViewModel viewModel;
  final String title;
  final List videosList;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(Themes.color, BlendMode.modulate),
              image: myImage,
              fit: BoxFit.cover),
        ),
        child: new BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
          child: Container(
            margin: EdgeInsets.only(
                left: 0.05 * width,
                right: 0.05 * width,
                top: 1.5 * topPadding,
                bottom: 0.02 * height),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.goBackToPreviousPage();
                      },
                      child: GestureDetector(
                        onTap: () => viewModel.goBackToPreviousPage(),
                        child: Container(
                          margin: EdgeInsets.only(right: 0.05 * width),
                          width: width * 0.08,
                          height: width * 0.08,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.1))
                              ],
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.2)),
                          child: Icon(Icons.chevron_left, color: Colors.white,),
                        ),
                      ),
                    ),
                    Container(
                        width: 0.7 * width,
                        child: Text(
                          title,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ))
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                      padding: EdgeInsets.only(top: height * 0.05),
                      itemCount: videosList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => videosList[index]["status"] == "free"
                              ? viewModel.goToYTScreen(viewModel,
                                  videosList[index], title, videosList)
                              : null,
                          child: Container(
                              padding: EdgeInsets.only(
                                  bottom: height * 0.015, left: width * 0.03),
                              decoration: videosList[index]["status"] == "free"
                                  ? BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(7),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Themes.color.withOpacity(0.1),
                                            blurRadius: 12,
                                            offset: Offset(8, 8))
                                      ],
                                    )
                                  : BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(7),
                                      //boxShadow: [BoxShadow(color: Color.fromRGBO(73, 173, 173, 0.15), blurRadius: 12)],
                                    ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Visibility(
                                    visible:
                                        videosList[index]["status"] != "free",
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: height * 0.045,
                                          left: width * 0.3),
                                      child: Icon(
                                        Icons.lock_outline,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    videosList[index]["videoName"],
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: height * 0.019,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    videosList[index]["videoLength"],
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: height * 0.014,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Colors.white),
                                  ),
                                ],
                              )),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: width * 0.05,
                          childAspectRatio: 1.4,
                          mainAxisSpacing: width * 0.05,
                          crossAxisCount: 2)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
