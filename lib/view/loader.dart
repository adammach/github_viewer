
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';


class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      child: Center(
        child: ProgressWidget(),
      ),
    );
  }
}

class ProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SpinKitDoubleBounce(
      color: Colors.indigoAccent,
    );
  }
}