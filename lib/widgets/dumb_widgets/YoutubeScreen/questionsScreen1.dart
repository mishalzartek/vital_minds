import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vitalminds/main.dart';
import 'package:vitalminds/widgets/smart_widgets/videos_home_page/videos_home_page_view_model.dart';
import '../Themes.dart';

// ignore: must_be_immutable
class UniqueQuestion extends StatelessWidget {
  UniqueQuestion(this.viewModel, this.title, this.videoData, this.videos,
      this.resumeAt, this.question);
  final String title;
  final String question;
  final Map videoData;
  final int resumeAt;
  final List videos;
  final VideosHomePageViewModel viewModel;
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).viewInsets.bottom == 0) focusNode.unfocus();
    return WillPopScope(
      onWillPop: () async {
        viewModel.goToYTScreen(viewModel, videoData, title, videos, resumeAt,
            viewModel.question1.text);
        return true;
      },
      child: Scaffold(
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
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.05),
                        child: Text(question,
                            maxLines: null,
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width / 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            )),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: width * 0.9,
                          height: MediaQuery.of(context).viewInsets.bottom == 0 ? height * 0.65 : height * 0.3,
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: TextFormField(
                              focusNode: focusNode,
                              keyboardType: TextInputType.multiline,
                              textCapitalization: TextCapitalization.sentences,
                              controller: viewModel.question1,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.transparent)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.transparent)),
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
                        Container(
                          margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.02),
                          width: width * 0.9,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: TextButton(
                            onPressed: () async {
                              await viewModel.updateCBT(
                                  viewModel.question1.text,
                                  title,
                                  viewModel.controller.metadata.title,
                                  question);
                              viewModel.question1.clear();
                              viewModel.goToYTScreen(viewModel, videoData, title,
                                  videos, resumeAt, viewModel.question1.text);
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
