import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synoptic_restaurant_app/constants/strings.dart';
import 'package:synoptic_restaurant_app/main_classes/account/account.dart';
import 'package:synoptic_restaurant_app/main_classes/menu/menu.dart';
import 'package:synoptic_restaurant_app/providers/menu_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
    @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _returnText = "";
  final _formkey = GlobalKey<FormState>();
  var _username;
  var _password;



  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
      return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(appTitle),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _returnText,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        _username = value;
                      },
                      textAlign: TextAlign.center,
                    ),
                    TextFormField(decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        _password = value;
                      },
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(onPressed: () async =>
                    {
                      if(_formkey.currentState!.validate()) {
                        if (await Account.register(context, _username, _password)) {
                          menuProvider.setMenu(await Menu.populateMenu()),
                          Navigator.pushNamed(context, '/home'),
                        } else {
                          setState(() {
                            _returnText = "Username already exists!";
                          })
                        }
                      },
                    },
                      child: const Text('Register'),
                    ),
                    ElevatedButton(onPressed: () async =>
                    {
                      if(_formkey.currentState!.validate()) {
                        if (await Account.login(context, _username, _password)) {
                          menuProvider.setMenu(await Menu.populateMenu()),
                          Navigator.pushNamed(context, '/home'),
                        } else {
                          setState(() {
                            _returnText = "Username or password do not match!";
                          })
                        }
                      },
                    },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      );
  }
}