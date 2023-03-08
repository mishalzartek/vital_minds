import 'package:flutter/material.dart';
import 'package:vitalminds/widgets/dumb_widgets/info_dialog.dart';
import 'package:vitalminds/widgets/dumb_widgets/moods/moods_widget.dart';
import 'package:vitalminds/widgets/smart_widgets/journal/journal_view_model.dart';


class MoodToday extends StatelessWidget {
  final JournalViewModel viewModel;
  const MoodToday({
    Key key,
    this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.1),
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03, vertical: MediaQuery.of(context).size.height * 0.01),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    Text("Mood today",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.left),
                    SizedBox(
                      width: 7.0,
                    ),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                InfoDialog(type: 2),
              ],
            ),
          ),
          Divider(color: Colors.white.withOpacity(0.4),
            indent: MediaQuery.of(context).size.width * 0.03,
            endIndent: MediaQuery.of(context).size.width * 0.03,),
          MoodsWidget(
              viewModel: viewModel,
              moodToday: viewModel.moodMorning,
              type: "Morning",
              controller: viewModel.notesMorning),
          MoodsWidget(
              viewModel: viewModel,
              moodToday: viewModel.moodAfternoon,
              type: "Afternoon",
              controller: viewModel.notesAfternoon),
          MoodsWidget(
              viewModel: viewModel,
              moodToday: viewModel.moodEvening,
              type: "Evening",
              controller: viewModel.notesEvening),
        ],
      ),
    );
  }
}
