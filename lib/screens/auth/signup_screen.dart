import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../screens/auth/login_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'package:intl/intl.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _visiblePassword = true;
  DateTime _selectedDate;

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
  Map<String, String> _authData = {
    'firstName': '',
    'lastName': '',
    'phone': '',
    'email': '',
    'password': '',
    'city': '',
    'address': '',
    'gender':'',
    'birthDay':'',
  };

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print(_authData);
    // try {
      await Provider.of<AuthProvider>(context, listen: false)
          .signUp(_authData);
    //   final errorMessage =
    //       Provider.of<AuthProvider>(context, listen: false).message;
    //   if (errorMessage != null) {
    //     _showErrorDialog(errorMessage);
    //   }
    // } catch (error) {
    //   _showErrorDialog(error.toString());
    // }
  }

  Future<void> _presentDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) {
      return;
    }
    _authData['birthDay'] = pickedDate.toIso8601String() ; 
    setState(() {
      _selectedDate = pickedDate;
    });
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
                  'Sign Up',
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
              Text('Enter your information below !',
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
                    Row(
                      children: <Widget>[
                        ///////////////////////////////firstName
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 13.5),
                                child: Text(
                                  'First name',
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    // hintText: 'Email',
                                    // hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(26.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey[200], width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(26.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey[200], width: 2),
                                    )),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid name!';
                                  }
                                },
                                onSaved: (value) {
                                  _authData['firstName'] = value;
                                },
                              ),
                            ],
                          ),
                        ),
                        //////////////////////////////////////////////////LastName
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 13.5),
                                child: Text(
                                  'Last name',
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    // hintText: 'Email',
                                    // hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(26.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey[200], width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(26.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey[200], width: 2),
                                    )),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid name!';
                                  }
                                },
                                onSaved: (value) {
                                  _authData['lastName'] = value;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    /////////////////////////////////////////////////////////phone
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 13.5),
                      child: Text(
                        'Phone',
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
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
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Invalid number!';
                        }
                      },
                      onSaved: (value) {
                        _authData['phone'] = value;
                      },
                    ),
                    ////////////////////////////////////////////////////////////E-mail
                    SizedBox(
                      height: 19,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 13.5),
                      child: Text(
                        'E-mail',
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
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
                          return 'Invalid Email!';
                        }
                      },
                      onSaved: (value) {
                        _authData['email'] = value;
                      },
                    ),
                    ////////////////////////////////////// password
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
                    /////////////////////////////////////////////////////////////City
                    SizedBox(
                      height: 19,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 13.5),
                      child: Text(
                        'City',
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    DropdownButtonFormField(
                      isDense: true,
                      items: <DropdownMenuItem>[
                        DropdownMenuItem<String>(
                          value: 'cairo',
                          child: Text('Cairo'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Damietta',
                          child: Text('damietta'),
                        ),
                      ],
                      decoration: InputDecoration(
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
                      validator: (value) {
                        if (value==null) {
                          return 'Invalid city!';
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          _authData['city'] = value;
                        });
                      },
                      onSaved: (value) {
                        _authData['city'] = value;
                      },
                    ),
                    //////////////////////////////////////////////Adress
                    SizedBox(
                      height: 19,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 13.5),
                      child: Text(
                        'Adress',
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
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
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Invalid Adress!';
                        }
                      },
                      onSaved: (value) {
                        _authData['address'] = value;
                      },
                    ),
                    ////////////////////////////////////////////////////////////Gender
                    SizedBox(
                      height: 19,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 13.5),
                      child: Text(
                        'Gender',
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    DropdownButtonFormField(
                      isDense: true,
                      items: <DropdownMenuItem>[
                        DropdownMenuItem<String>(
                          value: 'male',
                          child: Text('Male'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'female',
                          child: Text('Female'),
                        ),
                      ],
                      decoration: InputDecoration(
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
                      validator: (value) {
                        if (value == null) {
                          return 'Invalid gender!';
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          _authData['gender'] = value;
                        });
                      },
                      onSaved: (value) {
                        _authData['gender'] = value;
                      },
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    ////////////////////////////////////////////////////////Date
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 13.5),
                                child: Text(
                                  'Birthday',
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              FlatButton.icon(
                                icon: Icon(Icons.date_range),
                                label: Text('Choose Date'),
                                onPressed: _presentDatePicker,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 20),
                            alignment: Alignment.bottomRight,
                            child: Text(
                              _selectedDate == null
                                  ? 'No Date Chosen!'
                                  : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 51,
                      child: RaisedButton(
                        onPressed: _submit,
                        child: Text('Sign Up'),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26)),
                        color: Color.fromARGB(255, 88, 147, 255),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 36,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 75),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  child: Text('Already have account ? Login now !'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
