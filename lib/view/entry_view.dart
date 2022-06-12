// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:to_do_app/model/user.dart';
import 'package:to_do_app/service/utility.dart';
import 'package:to_do_app/view_model/entry_view_model.dart';
import '../model/easyloadin_show_state.dart';

TextEditingController _controllerUserName = TextEditingController();
TextEditingController _controllerPassword = TextEditingController();
//bool _isCurrent = false;
EntryViewModel entryViewModel = EntryViewModel();
var formKey = GlobalKey<FormState>();

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
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userNameTextFormField(),
                SizedBox(height: 25),
                passwordTextFormField(),
                SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  btnRegister(),
                  btnLogin(),
                ]),
              ],
            ),
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
  Widget userNameTextFormField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: TextFormField(
        controller: _controllerUserName,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          labelText: 'Kullanıcı Adı',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Lütfen kullanıcı adı giriniz';
          }
          return null;
        },
      ),
    );
  }

// PASSWORD BİLGİSİNİN ALINDIĞI TEXTFİELD
  Widget passwordTextFormField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: TextFormField(
        controller: _controllerPassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          labelText: 'Şifre',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Lütfen şifre giriniz';
          }
          return null;
        },
      ),
    );
  }

  // KAYIT OL BUTONU
  btnRegister() {
    return SizedBox(
      width: 90,
      height: 40,
      child: ElevatedButton(
        child: Text('Kayıt Ol'),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey.shade800)),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            bool result = await userCheck();
            print('registerdan gelen result: $result');
            if (!result) {
              var sonuc = await entryViewModel
                  .addUser(User(userName: _controllerUserName.text, password: _controllerPassword.text));
              print('kayıt işleminden gelen sonuc : $sonuc');

              String value = sonuc > 0 ? 'Kullanıcı kaydı başarılı.' : 'Kullanıcı kaydı başarısız.';
              Utility.getEasyLoading(showSate: EasyLoadingShowState.showInfo, miliSeconds: 2000, expression: value);
              _controllerUserName.text = '';
              _controllerPassword.text = '';
            } else {
              Utility.getEasyLoading(
                  showSate: EasyLoadingShowState.showInfo, miliSeconds: 1000, expression: 'Kullanıcı zaten kayıtlı!');
              _controllerUserName.text = '';
              _controllerPassword.text = '';
            }
          }
        },
      ),
    );
  }

  btnLogin() {
    return SizedBox(
      width: 90,
      height: 40,
      child: ElevatedButton(
        child: Text('Giriş'),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey.shade800)),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            bool result = await userCheck();
            if (result) {
              clearTextField();
              Utility.getEasyLoading(miliSeconds: 750, showSate: EasyLoadingShowState.showDefault, expression: '');
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              Utility.getEasyLoading(
                  showSate: EasyLoadingShowState.showInfo,
                  miliSeconds: 1000,
                  expression: 'Kullanıcı adı veya şifre yanlış!');
            }
          }
        },
      ),
    );
  }

  // KAYITLI BİR USER OLUP OLMADIĞINI DÖNER
  Future<bool> userCheck() async {
    bool result = await entryViewModel.login(_controllerUserName.text, _controllerPassword.text);
    return result;
  }

  clearTextField() {
    _controllerPassword.text = '';
    _controllerUserName.text = '';
  }
}
