import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _visiblePassword = true;

  void _togglePassword() {
    setState(() {
      _visiblePassword = !_visiblePassword;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {'email': '', 'password': ''};

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .Login(_authData['email'], _authData['password']);
      final errorMessage =
          Provider.of<AuthProvider>(context, listen: false).message;
      if (errorMessage != null) {
        _showErrorDialog(errorMessage);
      }
    } catch (error) {
      _showErrorDialog(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // height: constraints.maxHeight * ,
                width: double.infinity,
                padding: EdgeInsets.only(top: 109),
                child: Text(
                  'Welcome Back',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    // color: Color.fromARGB(1, 42, 44, 65),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Login to continue',
                  style: TextStyle(
                    fontSize: 12,
                  )),
              SizedBox(
                height: 82,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 13.5),
                      child: Text(
                        'E-mail',
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      key:Key('emailTextField'),
                      decoration: InputDecoration(
                          // hintText: 'Email',
                          // hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(26.0)),
                            borderSide:
                                BorderSide(color: Colors.grey[200], width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(26.0)),
                            borderSide:
                                BorderSide(color: Colors.grey[200], width: 2),
                          )),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }
                      },
                      onSaved: (value) {
                        _authData['email'] = value;
                      },
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 13.5),
                      child: Text(
                        'Password',
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      key:Key('passwordTextField'),
                      decoration: InputDecoration(
                        // hintText: 'Email',
                        // hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(26.0)),
                          borderSide:
                              BorderSide(color: Colors.grey[200], width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(26.0)),
                          borderSide:
                              BorderSide(color: Colors.grey[200], width: 2),
                        ),
                        suffixIcon: IconButton(
                          icon: _visiblePassword
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: _togglePassword,
                        ),
                      ),
                      obscureText: _visiblePassword,
                      // keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.isEmpty || value.length < 5) {
                          return 'Password is too short!';
                        }
                      },
                      onSaved: (value) {
                        _authData['password'] = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'forget password',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 51,
                      child: RaisedButton(
                        key:Key('buttonKey'),
                        onPressed: _submit,
                        child: Text('LOGIN'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26)),
                        color: Color.fromARGB(255, 88, 147, 255),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 190,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 75),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignupScreen.routeName);
                  },
                  child: Text('New User ? Signup now !'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
