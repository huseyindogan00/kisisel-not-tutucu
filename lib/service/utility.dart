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

//************************************************ */
/* import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
} 

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
 */