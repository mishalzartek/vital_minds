import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vitalminds/main.dart';
import 'package:vitalminds/widgets/smart_widgets/videos_home_page/videos_home_page_view_model.dart';
import '../Themes.dart';

class MultiQuestion extends StatelessWidget {
  MultiQuestion(this.viewModel, this.title, this.videoData, this.videos,
      this.resumeAt);
  final String title;
  final Map videoData;
  final int resumeAt;
  final List videos;
  final VideosHomePageViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        viewModel.goToYTScreen(viewModel, videoData, title, videos, resumeAt,
            viewModel.questions[0].text);
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Themes.color, BlendMode.modulate),
                image: myImage,
                fit: BoxFit.cover),
          ),
          width: width,
          height: height,
          child: SingleChildScrollView(
            reverse: true,
            physics: NeverScrollableScrollPhysics(),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
              child: Container(
                height: height,
                width: width,
                padding: EdgeInsets.only(top: height * 0.06),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: videoData["questions"].length,
                          itemBuilder: (context,i){
                              return Container(
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(videoData["questions"][i],
                                          maxLines: null,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width / 22,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Roboto',
                                          )),
                                    ),
                                    Container(
                                      height: height /6,
                                      width: width * 0.9,
                                      margin: EdgeInsets.only(top: height * 0.01),
                                      padding: EdgeInsets.all(width * 0.05),
                                      child: TextFormField(
                                          textInputAction: i<videoData["questions"].length-1?TextInputAction.next:TextInputAction.done,
                                          controller: viewModel.questions[i],
                                          cursorColor: Colors.white,
                                          decoration: InputDecoration(
                                              enabledBorder: UnderlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: Colors.transparent)),
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: Colors.white)),
                                              hintText: "Enter your thoughts here ...",
                                              hintStyle: TextStyle(
                                                  color: Colors.white.withOpacity(0.6),
                                                  fontSize: width / 24,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.bold)),
                                          maxLines: null,
                                          //overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white.withOpacity(0.6),
                                              fontSize: width / 24,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              );
                          }),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(bottom: height * 0.01),
                      width: width * 0.9,
                      height: height * 0.07,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextButton(
                        onPressed: () async {
                          await viewModel.updateMultiCBT(
                              videoData["questions"],
                              title,
                              viewModel.controller.metadata.title,
                              viewModel.questions);
                          viewModel.goToYTScreen(viewModel, videoData, title,
                              videos, resumeAt, viewModel.questions[0].text);
                        },
                        child: Center(
                          child: Text('NEXT',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: width / 22,
                                fontFamily: 'Roboto',
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
