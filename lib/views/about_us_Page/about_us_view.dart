import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vitalminds/main.dart';
import 'package:vitalminds/views/about_us_Page/about_us_view_model.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';

class AboutUsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var topPadding = MediaQuery.of(context).padding.top;
    return ViewModelBuilder<AboutUsPageViewModel>.reactive(
        builder:
            (BuildContext context, AboutUsPageViewModel viewModel, Widget _) {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter:
                          ColorFilter.mode(Themes.color, BlendMode.modulate),
                      image: myImage,
                      fit: BoxFit.cover)),
              width: width,
              height: height,
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: topPadding + height * 0.01),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      viewModel.navigateToProfilePage();
                                    }),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text("About",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width / 24,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Roboto',
                                  )),
                            ],
                          ),
                          Container(
                            width: width * 0.9,
                            margin: EdgeInsets.only(top: height * 0.02),
                            constraints: BoxConstraints(
                              maxHeight: double.infinity,
                            ),
                            padding: EdgeInsets.all(width * 0.05),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: Text(
                                "Hi and welcome to My Vital Mind: A self-care app  based on the principles of CBT.\n\nCBT or Cognitive Behavioral Therapy is based on the  principle that our thoughts, emotions and behaviors  are all interconnected and influence one another.\n\nThis form of psychotherapy focuses on noticing and  challenging our automatic negative thoughts that  worsen our emotional difficulties. It encompasses a  range of techniques that help us question and  replace our negative thoughts and adopt healthy  strategies to deal with challenges and life’s  uncertainties.\n\nWhile many of us struggle with mental health issues,  not all of us are able to get the required help. Our  goal is to make therapy accessible and remove  some of the hurdles that prevents us from making  mental health a priority.\n\nThe ease and effectiveness of CBT makes it a powerful tool in self-regulating our overall wellbeing.\n\nWe hope the Videos, tools and features on this app  guide you on your journey towards a healthy mind  and a healthy life.",
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: width / 28,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400)),
                          ),
                          Container(
                              constraints: BoxConstraints(
                                maxHeight: double.infinity,
                              ),
                              width: width * 0.9,
                              margin: EdgeInsets.only(top: height * 0.02),
                              padding: EdgeInsets.all(width * 0.03),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white.withOpacity(0.1),
                              ),
                              child: RichText(
                                softWrap: true,
                                text: new TextSpan(
                                    text: "Developer Information\n\n",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width / 28,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500),
                                    children: [
                                      TextSpan(
                                          text:
                                              "ArcTech × Pyramid Developers\n\n",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width / 26,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text:
                                              "We provide end to end software solutions by creating highly efficient and customised applications for your specific need at the lowest cost possible.\n",
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              fontSize: width / 28,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {
                                              launchUrlString(
                                                  "https://pyramiddeveloper.com/");
                                            },
                                          text: "\nLearn more    ",
                                          style: TextStyle(
                                              color: Themes.color,
                                              fontSize: width / 28,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {
                                              launchUrlString(
                                                  "mailto:build@pyramiddeveloper.com?subject=My Vital Mind Reference");
                                            },
                                          text: "Contact Us\n",
                                          style: TextStyle(
                                              color: Themes.color,
                                              fontSize: width / 28,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600))
                                    ]),
                              )),
                          Container(
                              constraints: BoxConstraints(
                                maxHeight: double.infinity,
                              ),
                              width: width * 0.9,
                              margin:
                                  EdgeInsets.symmetric(vertical: height * 0.02),
                              padding: EdgeInsets.all(width * 0.03),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white.withOpacity(0.1),
                              ),
                              child: RichText(
                                softWrap: true,
                                text: new TextSpan(
                                    text: "Privacy Policy\n",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width / 28,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500),
                                    children: [
                                      TextSpan(
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {
                                              launchUrlString(
                                                  "http://myvitalmind.com/privacy.html");
                                            },
                                          text: "\nLink : Privacy Policy ",
                                          style: TextStyle(
                                              color: Themes.color,
                                              fontSize: width / 28,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400))
                                    ]),
                              ))
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => AboutUsPageViewModel());
  }
}
