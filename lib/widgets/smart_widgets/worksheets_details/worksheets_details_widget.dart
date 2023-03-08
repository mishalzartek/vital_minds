import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/main.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'package:vitalminds/widgets/dumb_widgets/abcde_model_worksheet_template/abcde_model_worksheet_template_widget.dart';
import 'package:vitalminds/widgets/dumb_widgets/basic_worksheet_template/basic_worksheet_template_widget.dart';
import 'package:vitalminds/widgets/dumb_widgets/behavioral_activation_worksheet_template/behavioral_activation_worksheet_template_widget.dart';
import 'package:vitalminds/widgets/dumb_widgets/social_activation_worksheet_template/social_activation_worksheet_template_widget.dart';
import 'package:vitalminds/widgets/dumb_widgets/template_1/template_1.dart';
import 'package:vitalminds/widgets/dumb_widgets/template_2/template_2.dart';
import 'package:vitalminds/widgets/dumb_widgets/template_3/template_3.dart';
import 'package:vitalminds/widgets/dumb_widgets/template_4/template_4.dart';
import 'package:vitalminds/widgets/dumb_widgets/template_5/template_5.dart';
import 'worksheets_details_view_model.dart';

class WorksheetsDetailsWidget extends StatelessWidget {
  WorksheetsDetailsWidget(this.category, this.title, this.selectedDay, this.cameBackFromCBTPage);
  final String category;
  final String title;
  final DateTime selectedDay;
  final bool cameBackFromCBTPage;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var topPadding = MediaQuery.of(context).padding.top;
    return ViewModelBuilder<WorksheetsDetailsViewModel>.reactive(
      builder: (BuildContext context, WorksheetsDetailsViewModel viewModel,
          Widget _) {
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
                  margin: title == "Behavioral Activation"
                      ? EdgeInsets.only(
                          top: 0.07 * height, bottom: 0.02 * height)
                      : EdgeInsets.only(
                          left: 0.05 * width,
                          right: 0.05 * width,
                          top: 1.6 * topPadding,
                          bottom: 0.02 * height),
                  child: title == "ABCDE Model"
                      ? AbcdeModelWorksheetTemplateWidget(
                          selectedDay, viewModel, cameBackFromCBTPage)
                      : title == "Social Activation"
                          ? SocialActivationWorksheetTemplateWidget(
                              selectedDay, viewModel, cameBackFromCBTPage)
                          : title == "Behavioral Activation"
                              ? BehavioralActivationWorksheetTemplateWidget(
                                  selectedDay: selectedDay,
                                  viewModel: viewModel,
                                  cameBackFromCBTPage: cameBackFromCBTPage
                                  )
                              : title == "4 A's of stress" ||
                                      title ==
                                          "Eisenhower's Time Management Matrix"
                                  ? Template1Widget(
                                      selectedDay: selectedDay,
                                      viewModel: viewModel,
                                      subtitle: category,
                                      title: title,
                                      cameBackFromCBTPage: cameBackFromCBTPage
                                    )
                                  : title == "Turning Stress Into Action" ||
                                          title == "Rule of three" ||
                                          title ==
                                              "Stop worrying about the future"
                                      ? Template2Widget( 
                                          selectedDay: selectedDay,
                                          viewModel: viewModel,
                                          title: title,
                                          cameBackFromCBTPage: cameBackFromCBTPage
                                        )
                                      : title == "Reframing our SHOULD statements" ||
                                              title ==
                                                  "What's stopping you from taking a break" ||
                                              title == "Less is More" ||
                                              title ==
                                                  "Questioning Our Assumptions" ||
                                              title ==
                                                  "Tapping into our Resources" ||
                                              title == "Thought Record" ||
                                              title ==
                                                  "Tiny changes with big benefits" ||
                                              title == "Habits"
                                          ? Template3Widget(
                                              selectedDay: selectedDay,
                                              viewModel: viewModel,
                                              title: title,
                                              cameBackFromCBTPage: cameBackFromCBTPage
                                            )
                                          : title == "Living a life of meaning and purpose" ||
                                                  title == "Taking charge"
                                              ? Template4Widget(
                                                  selectedDay: selectedDay,
                                                  viewModel: viewModel,
                                                  title: title,
                                                  cameBackFromCBTPage: cameBackFromCBTPage
                                                )
                                              : title ==
                                                      "Developing tolerance towards anxiety"
                                                  ? Template5Widget(
                                                      selectedDay: selectedDay,
                                                      viewModel: viewModel,
                                                      cameBackFromCBTPage: cameBackFromCBTPage
                                                    )
                                                  : BasicWorksheetTemplateWidget(
                                                      selectedDay: selectedDay,
                                                      viewModel: viewModel,
                                                      category: category,
                                                      title: title,
                                                      cameBackFromCBTPage: cameBackFromCBTPage
                                                      )),
            ),
          ),
        );
      },
      viewModelBuilder: () => WorksheetsDetailsViewModel(
          selectedDay, title.replaceAll(new RegExp(r"\s+"), "")),
    );
  }
}
