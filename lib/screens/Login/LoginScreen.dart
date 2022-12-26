import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:fakebook_frontend/constants/Palette.dart';
import 'package:fakebook_frontend/constants/localdata/LocalData.dart';
import 'package:fakebook_frontend/models/Models.dart';
import 'package:fakebook_frontend/screens/home/widgets/HomeWidgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userLogin = {
      'phonenumber': '',
      'password': '',
    };
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 142, 0, 0),
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
                          padding: const EdgeInsets.fromLTRB(40, 104, 40, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          11), //Change this value to custom as you like
                                  isDense: true, // and add this line
                                  hintText: 'Phone or Email',
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                            11), //Change this value to custom as you like
                                    isDense: true, // and add this line
                                    hintText: 'Password',
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 50),
                                height: 40, //height of button
                                width: double.infinity, //width of button
                                child: ElevatedButton(
                                  onPressed: () {},
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
                                    onPressed: () {},
                                    child: Text('Forgot password?')),
                              )
                            ],
                          ))
                    ]))));
  }
}
