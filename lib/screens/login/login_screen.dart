import 'dart:convert';
import 'dart:io';

import 'package:fakebook_frontend/blocs/auth/auth_bloc.dart';
import 'package:fakebook_frontend/blocs/auth/auth_event.dart';
import 'package:fakebook_frontend/screens/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  var deviceInfo = {
    'devtype': 1,
    'devtoken': '',
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      setState(() {
        deviceInfo = {'devtype': 1, 'devtoken': androidInfo.id};
      });
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      setState(() {
        deviceInfo = {
          'devtype': 1,
          'devtoken': iosInfo.identifierForVendor ?? ''
        };
      });
    }
  }

  String? phone;
  String? password;
  String? phoneValidator (String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Số điện thoại không được để trống';
    }
    RegExp regPhone = RegExp(r'^0\d{9}$');
    if(!regPhone.hasMatch(phone)) {
      return 'Sai định dạng số điện thoại';
    }
    return null;
  }

  String? passwordValidator (String? password) {
    if (password == null || password.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    RegExp regChar = RegExp(r'^[\w_]{6,30}$');
    RegExp regPhone = RegExp(r'^0\d{9}$');
    if(regPhone.hasMatch(password)) {
      return 'Định dạng mật khẩu giống với định dạng điện thoại';
    }
    if(!regChar.hasMatch(password)) {
      return 'Mật khẩu phải từ 6-30 kí tự';
    }
    return null;
  }

  void savePhone (String? phoneValue) {
    setState(() {
      phone = phoneValue;
    });
  }

  void savePassword (String? passwordValue) {
    setState(() {
      password = passwordValue;
    });
  }

  final formStateKey = GlobalKey<FormState>();
  void submitForm(BuildContext context) {
    if (formStateKey.currentState?.validate() ?? true) { // Khi form gọi hàm validate thì tất cả các TextFormField sẽ gọi hàm validate. Hàm validate trả về true là thành công, false là thất bại
      // print('#Validate: Trước khi save: Phone: ${phone} và Password: ${password}');
      formStateKey.currentState?.save(); // khi form gọi hàm save thì tất cả các TextFormField sẽ gọi hàm save
      // print('#Validate: Sau khi save: Phone: ${phone} và Password: ${password}');
      BlocProvider.of<AuthBloc>(context).add(Login(phone: phone!, password: password!));
      // lấy thông tin người dùng
      final userInfo = BlocProvider.of<AuthBloc>(context).state.authUser;
      final _id = userInfo.id;
      final _name = userInfo.name;
      final _token = userInfo.token;
      // lưu vào cache
      // final prefs = await SharedPreferences.getInstance();
      // Map<String, dynamic> user = {'id': _id, 'name': _name, 'token': _token};
      // await prefs.setString('user', jsonEncode(user));

      // Bởi vì cập nhật state bằng Bloc nên không cần push từ Login
      // Navigator.push(context, MaterialPageRoute(builder: (context) => NavScreen()));
    } else {
      // print('#Validate: Validate thất bại. Vui lòng thử lại');
    }
  }
  @override
  Widget build(BuildContext context) {
    bool isHiddenKeyboard = MediaQuery.of(context).viewInsets.bottom == 0;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, isHiddenKeyboard ? 142 : 50, 0, 0),
                child: Form(
                  key: formStateKey,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 41,
                                color: Palette.facebookBlue),
                            'FakeBook',
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(40, isHiddenKeyboard ? 104 : 40, 40, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 11),
                                      //Change this value to custom as you like
                                      isDense: true,
                                      // and add this line
                                      hintText: 'Phone or Email'
                                    ),
                                    validator: phoneValidator,
                                    onSaved: savePhone,
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 11),
                                        //Change this value to custom as you like
                                        isDense: true,
                                        // and add this line
                                        hintText: 'Password',
                                      ),
                                      validator: passwordValidator,
                                      onSaved: savePassword
                                    ),
                                  Container(
                                    margin: EdgeInsets.only(top: 50),
                                    height: 40, //height of button
                                    width: double.infinity, //width of button
                                    child: ElevatedButton(
                                      onPressed: () {
                                        submitForm(context);
                                      },
                                      child: Text('Login'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Palette.facebookBlue,
                                        textStyle:
                                            TextStyle(fontWeight: FontWeight.bold),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Palette.facebookBlue,
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          print(deviceInfo);
                                        },
                                        child: Text('Forgot password?')),
                                  )
                                ],
                              ))
                        ]),
                  ),
                ))));
  }
}
