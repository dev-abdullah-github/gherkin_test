import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:provider/provider.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import '../../providers/auth_provider.dart';
import '../../screens/home_screen.dart';

class EmailConfirmationScreen extends StatefulWidget {
  static const routeName = '/email-confirmation';

  @override
  _EmailConfirmationScreenState createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  // bool _onEditing = true;

  String _code;
  bool _waiting = false;
  var _progress = false ; 

  void toast(String message) {
    showToast(message,
        context: context,
        animation: StyledToastAnimation.fade,
        reverseAnimation: StyledToastAnimation.sizeFade,
        axis: Axis.horizontal,
        position: StyledToastPosition.center,
        animDuration: Duration(milliseconds: 400),
        duration: Duration(seconds: 2),
        curve: Curves.linear,
        reverseCurve: Curves.linear);
  }

  Future<void> _submit() async {
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .checkVerificationCode('ma@mail.com', _code, true);
      final errorMessage =
          Provider.of<AuthProvider>(context, listen: false).message;
      if (errorMessage != null) {
        toast(errorMessage);
      } else {
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      }
    } catch (error) {
      toast(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 109,
              ),
              Text(
                'E-Email',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(42, 44, 65, 1),
                ),
              ),
              Text(
                'Confirmation',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(42, 44, 65, 1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter the verification code that was sent to your email',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 107,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text('Verification code'),
              ),
              SizedBox(
                height: 8,
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      child: VerificationCode(
                        textStyle: TextStyle(fontSize: 13),
                        keyboardType: TextInputType.number,
                        length: 4,
                        onCompleted: (String value) {
                          setState(() {
                            _code = value;
                          });
                        },
                        onEditing: (bool value) {
                          // setState(() {
                          //   _onEditing = value;
                          // });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              _waiting
                  ? CircularCountDownTimer(
                      // Countdown duration in Seconds
                      duration: 60,

                      // Width of the Countdown Widget
                      width: MediaQuery.of(context).size.width / 10,

                      // Height of the Countdown Widget
                      height: MediaQuery.of(context).size.height / 10,

                      // Default Color for Countdown Timer
                      color: Colors.white,

                      // Filling Color for Countdown Timer
                      fillColor: Colors.blue,

                      // Border Thickness of the Countdown Circle
                      strokeWidth: 3,

                      // Text Style for Countdown Text
                      textStyle: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),

                      // true for reverse countdown (max to 0), false for forward countdown (0 to max)
                      isReverse: true,

                      // Function which will execute when the Countdown Ends
                      onComplete: () {
                        // Here, do whatever you want
                        setState(() {
                          _waiting = false;
                        });
                      },
                    )
                  : FlatButton(
                      child: _progress ? Center(child:CircularProgressIndicator()) :Text(
                        'Resend Code',
                        style: TextStyle(fontSize: 12),
                      ),
                      onPressed: () async {
                        setState(() {
                          _progress = true; 
                        });
                        await Provider.of<AuthProvider>(context, listen: false)
                            .resendVerificationCode('ma@mail.com', true);
                             setState(() {
                          _progress = false; 
                        });
                        final errorMessage =
                            Provider.of<AuthProvider>(context, listen: false)
                                .message;
                        if (errorMessage != null) {
                          toast(errorMessage);
                        }
                        setState(() {
                          _waiting = true ; 
                        });
                      }),
              SizedBox(
                height: 20,
              ),
              // Padding(
              //     padding: EdgeInsets.all(8.0),
              //     child: Center(
              //       child: _onEditing
              //           ? Text('Please enter full code')
              //           : Text('Your code: $_code'),
              //     )),
              ButtonTheme(
                minWidth: double.infinity,
                height: 51,
                child: RaisedButton(
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                  color: Colors.blue,
                  onPressed: _submit,
                ),
              ),
              SizedBox(height: 327),
            ],
          ),
        ),
      ),
    );
  }
}
