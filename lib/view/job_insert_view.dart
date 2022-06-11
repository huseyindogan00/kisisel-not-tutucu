// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_do_app/model/job.dart';
import 'package:to_do_app/view_model/job_insert_model.dart';

var formKey = GlobalKey<FormState>();
TextEditingController _captionController = TextEditingController();
TextEditingController _contentController = TextEditingController();

class JobInsertView extends StatelessWidget {
  const JobInsertView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _clearFields();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text(
          'İş Ekle',
          textAlign: TextAlign.center,
        ),
      ),
      body: Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _spaceHeight(10),
                  CaptionTextFormField(),
                  _spaceHeight(20),
                  ContentTextFormField(),
                  _spaceHeight(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      insertIconButton(context),
                      _spaceWidth(20),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  SizedBox _spaceHeight(double value) => SizedBox(height: value);
  SizedBox _spaceWidth(double value) => SizedBox(width: value);

  // GİRİLEN İŞİ KAYDETME BUTONU
  ElevatedButton insertIconButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey.shade800)),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          int result = await JobInsertModel.insertJob(Job(
              caption: _captionController.text,
              content: _contentController.text,
              creationDate: DateTime.now().millisecondsSinceEpoch.toString()));
          if (result > 0) {
            await _showMessage(context, 'İş ekleme başarılı');
            Navigator.pop(context, true);
          } else {
            _showMessage(context, 'İş ekleme başarısız');
          }
        }
      },
      child: Text('Kaydet'),
    );
  }

  Future<dynamic> _showMessage(BuildContext context, String result) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sonuç'),
            content: Text('$result'),
            actions: [
              TextButton(
                  onPressed: () {
                    _clearFields();
                    Navigator.pop(context);
                  },
                  child: Text('Tamam'))
            ],
          );
        });
  }

  void _clearFields() {
    _captionController.clear();
    _contentController.clear();
  }
}

// BAŞLIK TEXTFORM ALANI
class CaptionTextFormField extends StatelessWidget {
  const CaptionTextFormField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _captionController,
      decoration: InputDecoration(
        labelText: 'Başlık Giriniz',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Lütfen Başlık Giriniz';
        }
        return null;
      },
    );
  }
}

// İÇERİK TEXTFORM ALANI
class ContentTextFormField extends StatelessWidget {
  const ContentTextFormField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _contentController,
      maxLines: 10,
      decoration: InputDecoration(
        labelText: 'Açıklama Giriniz',
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Lütfen Açıklama Giriniz';
        }
        return null;
      },
    );
  }
}
