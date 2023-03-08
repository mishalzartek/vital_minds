import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vitalminds/widgets/smart_widgets/journal/journal_view_model.dart';

class MoneyMatters extends StatelessWidget {
  final JournalViewModel viewModel;
  const MoneyMatters({
    Key key,
    this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03, vertical: MediaQuery.of(context).size.height * 0.02),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.1),
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: [
                      Text("Money Matters",
                          style: const TextStyle(
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
                ),
                GestureDetector(
                      onTap: () {
                        viewModel.enterMoneyMatterAlert(context);
                      },
                      child: Icon(
                        viewModel.income == null &&
                                viewModel.expenditure == null
                            ? Icons.add
                            : Icons.edit,
                        size: 18,
                        color: Colors.white,
                      )),
              ]
          ),
          Divider(
            color: Colors.white.withOpacity(0.4),
          ),
          viewModel.isBusy ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SpinKitWanderingCubes(
                        color: Colors.white,
                        size: 40,
                        duration: Duration(milliseconds: 1200),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02, vertical: MediaQuery.of(context).size.height * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("Income",
                                  style: TextStyle(
                                      color:
                                      Colors.white.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.0),
                                  textAlign: TextAlign.left),
                              Text(
                                  "${viewModel.income == null ? '--' : '\u{20B9}' + viewModel.income.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0),
                                  textAlign: TextAlign.left)
                            ],
                          ),
                          Column(
                            children: [
                              Text("Expenditure",
                                  style:  TextStyle(
                                      color:
                                          Colors.white.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.0),
                                  textAlign: TextAlign.left),
                              Text(
                                  "${viewModel.expenditure == null ? '--' : '\u{20B9}' + viewModel.expenditure.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0),
                                  textAlign: TextAlign.left)
                            ],
                          ),
                          Column(
                            children: [
                              Text("+/-",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.0),
                                  textAlign: TextAlign.left),
                              Text(
                                  "${viewModel.netpl == null ? '--' : '\u{20B9}' + viewModel.netpl.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0),
                                  textAlign: TextAlign.left)
                            ],
                          ),
                        ],
                      ))
        ],
      ),
    );
  }
}
