import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_login/flutter_login.dart';
import 'main.dart';

class Auth extends StatefulWidget {
  late MyBooks myBooks;
  Auth({Key? key, required this.myBooks}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
  _loginUser(LoginData data, response) {
    return Future.delayed(loginTime).then((_) {

      if(response.data['msg'].contains('User created')) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Auth(myBooks: widget.myBooks)));
      }

      if(response.data['msg'].contains('Api working')) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(myBooks: widget.myBooks)));
      }
      return null;
    });
  }

  _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: '',
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) async {
        var response = await Dio().post(
            'https://lib-mana-sys.herokuapp.com/api/v1/authenticate/signIn',
            data: {
              'email': loginData.name,
              'password': loginData.password,
            });
        return _loginUser(loginData, response);
      },
      onSignup: (loginData) async {
        var response = await Dio().post(
            'https://lib-mana-sys.herokuapp.com/api/v1/authenticate/signUp',
            data: {
              'email': loginData.name,
              'password': loginData.password,
            });
        return _loginUser(loginData, response);
      },
      onRecoverPassword: (email) {
        return _recoverPassword(email);
      },
    );
  }
}
