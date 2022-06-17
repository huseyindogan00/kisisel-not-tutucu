import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:to_do_app/view/route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.blue.shade900),
          backgroundColor: Colors.orangeAccent.shade200,
          appBarTheme: AppBarTheme(backgroundColor: Colors.blue.shade900),
          primaryColor: const Color.fromARGB(255, 46, 68, 44)),
      darkTheme: ThemeData.dark(),
      builder: EasyLoading.init(),
      color: Colors.deepOrangeAccent.shade400,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.routeGenerator,
    );
  }
}
