import 'package:flutter/cupertino.dart';

abstract class DialogContentWidget extends StatefulWidget {
  const DialogContentWidget({super.key});

  String get title;

  double get width => 500;
}