import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'splash_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (BuildContext context, SplashViewModel viewModel, Widget _) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'My Vital Mind\n\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SpinKitFoldingCube(
                  color: Color.fromRGBO(90, 94, 208, 1),
                  size: 100,
                  duration: Duration(milliseconds: 1200),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
