import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/main.dart';

import 'introduction_view_model.dart';

class IntroductionPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<IntroductionPageViewModel>.reactive(
      builder: (BuildContext context, IntroductionPageViewModel viewModel,
          Widget _) {
        return Scaffold(
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(Color(0xff5a5ed0), BlendMode.modulate),
                      image: myImage,
                      fit: BoxFit.cover),
                ),
                width: width,
                height: height,
                child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(top: height * 0.08),
                          child: Column(
                            children: [
                              Container(
                                height: height / 1.5,
                                width: width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.07),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome to My Vital Mind\n",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width / 19,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold),
                                      softWrap: true,
                                    ),
                                    Text(
                                      "Hi and welcome to My Vital Mind: A self-care app based on the principles of CBT.",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          // color: Color.fromRGBO(34, 51, 72, 1),
                                          color: Colors.white,
                                          fontSize: width / 25,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400),
                                      softWrap: true,
                                    ),
                                    Text(
                                      "CBT or Cognitive Behavioral Therapy is based on the principle that our thoughts, emotions and behaviors are all interconnected and influence one another.",
                                      maxLines: 3,
                                      style: TextStyle(
                                          // color: Color.fromRGBO(34, 51, 72, 1),
                                          color: Colors.white,
                                          fontSize: width / 25,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                    Text(
                                      "This form of psychotherapy focuses on noticing and challenging our automatic negative thoughts that worsen our emotional difficulties. It encompasses a range of techniques that help us question and replace our negative thoughts and adopt healthy strategies to deal with challenges and life’s uncertainties. ",
                                      maxLines: 7,
                                      style: TextStyle(
                                          // color: Color.fromRGBO(34, 51, 72, 1),
                                          color: Colors.white,
                                          fontSize: width / 25,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                    Text(
                                      "While many of us struggle with mental health issues, not all of us are able to get the required help. Our goal is to make therapy accessible and remove some of the hurdles that prevents us from making mental health a priority.\n",
                                      maxLines: 5,
                                      style: TextStyle(
                                          // color: Color.fromRGBO(34, 51, 72, 1),
                                          color: Colors.white,
                                          fontSize: width / 25,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                    Text(
                                      "The ease and effectiveness of CBT makes it a powerful tool in self-regulating our overall wellbeing.\n",
                                      maxLines: 2,
                                      style: TextStyle(
                                          // color: Color.fromRGBO(34, 51, 72, 1),
                                          color: Colors.white,
                                          fontSize: width / 25,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                    Text(
                                      "We hope the Videos, tools and features on this app guide you on your journey towards a healthy mind and a healthy life.\n",
                                      maxLines: 3,
                                      style: TextStyle(
                                          // color: Color.fromRGBO(34, 51, 72, 1),
                                          color: Colors.white,
                                          fontSize: width / 25,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: height * 0.15),
                                child: ElevatedButton(
                                    onPressed: () =>
                                        viewModel.navigateToHomePage(),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xff5a5ed0)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))),
                                    ),
                                    child: Container(
                                      width: width * 0.83,
                                      height: height * 0.07,
                                      child: Center(
                                        child: Text(
                                          "PROCEED",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width / 25,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                              )
                            ],
                          )),
                    ))));
      },
      viewModelBuilder: () => IntroductionPageViewModel(),
    );
  }
}
