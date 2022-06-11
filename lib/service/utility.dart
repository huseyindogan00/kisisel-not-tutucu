import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../model/easyloadin_show_state.dart';

mixin Utility {
  String getDate(String? milliseconds) {
    int _milliseconds = int.parse(milliseconds!);
    String day = DateTime.fromMillisecondsSinceEpoch(_milliseconds).day.toString();
    String month = DateTime.fromMillisecondsSinceEpoch(_milliseconds).month.toString();
    String year = DateTime.fromMillisecondsSinceEpoch(_milliseconds).year.toString();

    return '$day.$month.$year';
  }

  static void getEasyLoading(
      {required EasyLoadingShowState showSate, required int miliSeconds, required String expression}) async {
    switch (showSate) {
      case EasyLoadingShowState.showDefault:
        EasyLoading.show(dismissOnTap: false);
        await Future.delayed(Duration(milliseconds: miliSeconds));
        EasyLoading.dismiss();
        break;
      case EasyLoadingShowState.showInfo:
        EasyLoading.showInfo(expression, duration: Duration(milliseconds: miliSeconds), dismissOnTap: false);
        break;
      default:
    }
  }
}
