import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/widgets/smart_widgets/worksheets/worksheets_widget.dart';
import 'worksheets_view_model.dart';

class WorksheetsView extends StatelessWidget {
  final DateTime selectedDay;
  WorksheetsView({Key key, @required this.selectedDay}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorksheetsViewModel>.reactive(
      builder: (BuildContext context, WorksheetsViewModel viewModel, Widget _) {
        return WorksheetsWidget(selectedDay: selectedDay);
      },
      viewModelBuilder: () => WorksheetsViewModel(),
    );
  }
}
