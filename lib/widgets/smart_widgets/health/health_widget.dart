import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/widgets/dumb_widgets/exercise/exercise_widget.dart';
import 'package:vitalminds/widgets/dumb_widgets/habits/habits_widget.dart';
import 'package:vitalminds/widgets/dumb_widgets/nutrition/nutrition_widget.dart';
import 'health_view_model.dart';

class HealthWidget extends StatelessWidget {
  final DateTime selectedDate;

  const HealthWidget({Key key, this.selectedDate}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HealthViewModel>.reactive(
      fireOnModelReadyOnce: true,
      builder: (BuildContext context, HealthViewModel viewModel, Widget _) {
        return Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width * 0.04),
          child: ListView(
            padding: EdgeInsets.all(0),
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              HabitsWidget(viewModel: viewModel),
              Container(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              NutritionWidget(viewModel: viewModel),
              Container(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ExerciseWidget(viewModel: viewModel),
            ],
          ),
        );
      },
      viewModelBuilder: () => HealthViewModel(selectedDate),
    );
  }
}
