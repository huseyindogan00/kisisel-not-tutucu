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
  //checkbox kutusunu kontrol eden değer
  bool isChecked = false;
  bool isHiddenPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeData.dark().backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeData.dark().backgroundColor,
          title: titleAppBar(context),
        ),
        body: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userNameTextFormField(),
                  SizedBox(height: 25),
                  passwordTextFormField(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      btnRegister(),
                      btnLogin(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  //**************************************************************************************//
  // Giriş bilgilerinin kaydedilip kaydedilmeyeceğini bildiren CHECKBOX (DÜZENLENECEK)
  /* Row checkBoxControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Giriş bilgilerimi kaydet',
          style: TextStyle(color: Colors.grey.shade300),
        ),
        Checkbox(
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            }),
      ],
    );
  } */
  //**************************************************************************************//

  // MaterialState sınıfını kullanarak etkileşime göre renk döndüren bir fonksiyon
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveState = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected,
    };

    if (states.any(interactiveState.contains)) {
      return Colors.green;
    } else {
      return Colors.grey.shade400;
    }
  }

  // AppBar da bulunan TİTLE
  Center titleAppBar(BuildContext context) {
    return Center(
        child: Text(
      'Kişisel Not Defteri',
      style: TextStyle(
        color: Colors.orange,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ));
  }

// USER NAME BİLGİSİNİN ALINDIĞI TEXTFİELD
  Widget userNameTextFormField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TextFormField(
        controller: _controllerUserName,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.supervised_user_circle),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          labelText: 'Kullanıcı Adı',
          labelStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty || value.trim() == '') {
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
      width: MediaQuery.of(context).size.width,
      height: 65,
      child: TextFormField(
        maxLength: 20,
        obscureText: isHiddenPassword,
        controller: _controllerPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          labelText: 'Şifre',
          suffixIcon: IconButton(
            icon: isHiddenPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: () {
              setState(() {
                isHiddenPassword = !isHiddenPassword;
              });
            },
            //color: passwordDisableIconColor,
          ),
          labelStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty || value.trim() == '') {
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
        child: Text(
          'Kayıt Ol',
          style: TextStyle(color: Colors.white),
        ),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green.shade800)),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            bool result = await userCheck();
            print('validate sonucu : ${formKey.currentState!.validate()}');
            if (!result) {
              var sonuc = await entryViewModel
                  .addUser(User(userName: _controllerUserName.text, password: _controllerPassword.text));

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

  // GİRİŞ yap butonu
  btnLogin() {
    return SizedBox(
      width: 90,
      height: 40,
      child: ElevatedButton(
        child: Text(
          'Giriş',
          style: TextStyle(color: Colors.white),
        ),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue.shade800)),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            print('validate sonucu : ${formKey.currentState!.validate()}');
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
