import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _id;
  String _firstName;
  String _lastName;
  String _email;
  String _image;
  String _role;
  String _status;
  String _token;
  String _companyName;
  String _name;
  String _message;
  String _city;
  String _address;
  String _gender;
  String _birthday;

  String get message {
    if (_message != null) {
      return _message;
    }
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<void> Login(String email, String password) async {
    const url = 'https://ecommerce.service.ahmed-ajory.com/api/v1/login';
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(
            {
              'email': email,
              'password': password,
              'device_token': 'test',
              'device_type': 'android',
            },
          ));

      var responseData = (json.decode(response.body));
      // print(responseData);
      if (responseData['data'] != null) {
        //  print(responseData['data']);
        _id = responseData['data']['id'].toString();
        // print(responseData['data']['id']);
        _firstName = responseData['data']['first_name'];
        _lastName = responseData['data']['last_name'];
        _email = responseData['data']['email'];
        _image = responseData['data']['image'];
        _role = responseData['data']['role'];
        _status = responseData['data']['status'];
        _token = responseData['data']['token'];
        // print(_token);
        if (responseData['data']['company_name'] != null) {
          // print('print that');
          _companyName = responseData['data']['company_name'];
        }
        _name = responseData['data']['name'];
        _message = null;
      } else {
        _message = responseData['message'];
      }
      // print(responseData['message']);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'id': _id,
        'firstName': _firstName,
        'lastName': _lastName,
        'email': _email,
        'image': _image,
        'role': _role,
        'status': _status,
        'token': _token,
        'companyName': _companyName,
        'name': _name,
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    _token = extractedUserData['token'];
    notifyListeners();
    return true;
  }

  Future<void> signUp(data) async {
    const url = 'https://ecommerce.service.ahmed-ajory.com/api/v1/signup';
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(
            {
              'first_name': data['firstName'],
              'last_name': data['lastName'],
              'phone': data['phone'],
              'email': data['email'],
              'password': data['password'],
              'city': data['city'],
              'address': data['address'],
              'gender': data['gender'],
              'birthDay': data['birthDay'],
              'device_token': 'test',
              'device_type': 'android',
            },
          ));

      var responseData = (json.decode(response.body));
      // print(responseData);
      if (responseData['data'] != null) {
        //  print(responseData['data']);
        _id = responseData['data']['id'].toString();
        // print(responseData['data']['id']);
        _firstName = responseData['data']['first_name'];
        _lastName = responseData['data']['last_name'];
        _email = responseData['data']['email'];
        _image = responseData['data']['image'];
        _role = responseData['data']['role'];
        _status = responseData['data']['status'];
        _token = responseData['data']['token'];
        // print(_token);
        if (responseData['data']['company_name'] != null) {
          // print('print that');
          _companyName = responseData['data']['company_name'];
        }
        _name = responseData['data']['name'];
        _message = null;
      } else {
        _message = responseData['message'];
      }
      // print(responseData['message']);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'id': _id,
        'firstName': _firstName,
        'lastName': _lastName,
        'email': _email,
        'image': _image,
        'role': _role,
        'status': _status,
        'token': _token,
        'companyName': _companyName,
        'name': _name,
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> checkVerificationCode(
      String email, String code, bool verify) async {
    final url = 'https://ecommerce.service.ahmed-ajory.com/api/v1/verify/check';

    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'lang': 'ar'
          },
          body: jsonEncode({
            'email': email,
            'code': code,
            'verify': verify,
          }));
      var responseData = (json.decode(response.body));

       if (responseData['data'] != null) {
        _id = responseData['data']['id'].toString();
        _firstName = responseData['data']['first_name'];
        _lastName = responseData['data']['last_name'];
        _email = responseData['data']['email'];
        _image = responseData['data']['image'];
        _role = responseData['data']['role'];
        _status = responseData['data']['status'];
        _token = responseData['data']['token'];
        if (responseData['data']['company_name'] != null) {
          _companyName = responseData['data']['company_name'];
        }
        _name = responseData['data']['name'];
        _message = null;
       
      } else {
        _message = responseData['message'];
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  

   Future<void> resendVerificationCode(
      String email, bool verify) async {
    final url = 'https://ecommerce.service.ahmed-ajory.com/api/v1/verify/resend';
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'lang': 'ar'
          },
          body: jsonEncode({
            'email': email,
            'verify': verify,
          }));
      var responseData = (json.decode(response.body));

       if (responseData['message'] != null) {
        
          _message = responseData['message'];
       
      } 
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  

  Future<void> logOut() async {
    _token = null;
    _id = null;
    _firstName = null;
    _lastName = null;
    _email = null;
    _image = null;
    _role = null;
    _status = null;
    _token = null;
    _companyName = null;
    _name = null;
    _message = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }
}
