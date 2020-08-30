import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/auth/login_screen.dart';
import './providers/auth_provider.dart';
import './screens/auth/signup_screen.dart';
import './providers/home_provider.dart';
import './screens/product_details_screen.dart';
import './providers/product_provider.dart';
import './screens/auth/email_confirmation_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<AuthProvider, HomeProvdier>(
          update: (_, auth, previousData) => HomeProvdier(
            auth.token,
            previousData == null ? [] : previousData.categories,
            previousData == null ? [] : previousData.mostRequested,
            previousData == null ? [] : previousData.offers,
          ),
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
          update: (_, auth, prevDetails) => ProductProvider(
            auth.token,
           prevDetails == null ? {} : prevDetails.detailsData
          ),
        ),
      ],
      child: Consumer<AuthProvider>(builder: (ctx, auth, _) {
        return MaterialApp(
          title: 'MyShop',
          // theme: ThemeData(
          //   // primaryColor: Colors.,
          //   // primarySwatch: Color.fromARGB(1,244, 244, 248),
          //   accentColor: Color.fromARGB(1,244, 244, 248),
          //   fontFamily: 'Roboto',
          // ),
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (ctx, authResultSnapshot) => LoginScreen()),
          // home: LoginScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            SignupScreen.routeName: (ctx) => SignupScreen(),
            ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
            EmailConfirmationScreen.routeName: (ctx) => EmailConfirmationScreen(),
          },
        );
      }),
    );
  }
}
