import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/widgets/dumb_widgets/grateful_for/grateful_for_widget.dart';
import 'package:vitalminds/widgets/dumb_widgets/mood_today/mood_today_widget.dart';
import 'package:vitalminds/widgets/dumb_widgets/people_and_relationship/people_and_relationship_widget.dart';
import 'package:vitalminds/widgets/dumb_widgets/thought_of_the_day/thought_of_the_day_widget.dart';

import 'journal_view_model.dart';

class JournalWidget extends StatelessWidget {
  final DateTime selectedDate;
  final JournalViewModel viewModel;

  const JournalWidget({Key key, @required this.selectedDate, this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JournalViewModel>.reactive(
      builder: (BuildContext context, JournalViewModel viewModel, Widget _) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            viewModel.deleteAllEmptyJournalEntries();
          },
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                MoodToday(viewModel: viewModel),
                Container(
                  height: height * 0.02,
                ),
                GratefulFor(viewModel: viewModel),
                Container(
                  height: height * 0.02,
                ),
                PeopleAndRelationship(viewModel: viewModel),
                Container(
                  height: height * 0.02,
                ),
                ThoughtOfTheDay(viewModel: viewModel),
                Container(
                  height: height * 0.02,
                ),
                // MoneyMatters(viewModel: viewModel),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => JournalViewModel(selectedDate),
    );
  }
}
