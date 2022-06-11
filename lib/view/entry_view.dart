// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:to_do_app/model/user.dart';
import 'package:to_do_app/service/utility.dart';
import 'package:to_do_app/view_model/entry_view_model.dart';
import '../model/easyloadin_show_state.dart';

TextEditingController _controllerUserName = TextEditingController();
TextEditingController _controllerPassword = TextEditingController();
bool _isCurrent = false;
EntryViewModel entryViewModel = EntryViewModel();

class EntryView extends StatefulWidget {
  const EntryView({Key? key}) : super(key: key);
  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: titleAppBar(context),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userNameTextField(),
              SizedBox(height: 25),
              passwordTextField(),
              Row(children: [
                btnRegister(),
                btnLogin(),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar da bulunan TİTLE
  Center titleAppBar(BuildContext context) {
    return Center(
        child: Text(
      'İş Takip Uygulaması',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ));
  }

// USER NAME BİLGİSİNİN ALINDIĞI TEXTFİELD
  Widget userNameTextField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: TextField(
        controller: _controllerUserName,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          labelText: 'Kullanıcı Adı',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

// PASSWORD BİLGİSİNİN ALINDIĞI TEXTFİELD
  Widget passwordTextField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: TextField(
        controller: _controllerPassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          labelText: 'Şifre',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  // KAYIT OL BUTONU
  btnRegister() {
    return ElevatedButton(
        onPressed: () async {
          bool result = await userCheck();
          if (!result) {
            Utility.getEasyLoading(
                showSate: EasyLoadingShowState.showInfo, miliSeconds: 1000, expression: 'Kullanıcı kaydı başarılı.');
            _controllerUserName.text = '';
            _controllerPassword.text = '';
          } else {
            Utility.getEasyLoading(
                showSate: EasyLoadingShowState.showInfo, miliSeconds: 1000, expression: 'Kullanıcı zaten kayıtlı!');
            _controllerUserName.text = '';
            _controllerPassword.text = '';
          }
        },
        child: Text('Kayıt Ol'));
  }

  btnLogin() {
    return ElevatedButton(
      child: Text('Giriş'),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey.shade800)),
      onPressed: () async {
        bool result = await userCheck();

        if (result) {
          Utility.getEasyLoading(miliSeconds: 1000, showSate: EasyLoadingShowState.showDefault, expression: '');
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Utility.getEasyLoading(
              showSate: EasyLoadingShowState.showInfo, miliSeconds: 1000, expression: 'Kullanıcı bulunamadı.');
        }
      },
    );
  }

  // KAYITLI BİR USER OLUP OLMADIĞINI DÖNER
  Future<bool> userCheck() async {
    bool result = await entryViewModel.login(_controllerUserName.text, _controllerPassword.text);
    return result;
  }
}
