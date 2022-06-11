import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hata !'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: Text(
            'Üzgünüm\nSayfa bulanamadı...',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
