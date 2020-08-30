import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

import '../screens/auth/login_screen.dart';
import '../providers/home_provider.dart';
import '../screens/product_details_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('homeScreenKey'),
      backgroundColor: Colors.grey[200],
      // body: Center(
      //   child: RaisedButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //       Navigator.of(context).pushNamed(LoginScreen.routeName);
      //       Provider.of<AuthProvider>(context, listen: false).Logout();
      //     },
      //     color: Colors.blue,
      //     child: Text('Logout'),
      //   ),
      // ),
      body: FutureBuilder(
          future:
              Provider.of<HomeProvdier>(context, listen: false).FetchHomeData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.error != null) {
                return Center(child: Text('Some thing wrong !'));
              } else {
                return SingleChildScrollView(
                  child: Consumer<HomeProvdier>(builder: (ctx, homeProvier, _) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 49),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    key: Key('logoutbtn'),
                                    onTap: (){
                                      Provider.of<AuthProvider>(context,listen: false).logOut();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 18.5,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.notifications),
                                    onPressed: () {},
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 28,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Form(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.search),
                                            alignment: Alignment.centerLeft,
                                            onPressed: () {},
                                          ),
                                          hintText: 'Search ....',
                                          // hintStyle: TextStyle(color: Colors.grey),
                                          filled: true,
                                          fillColor: Colors.white70,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(26.0)),
                                            borderSide: BorderSide(
                                                color: Colors.grey[200],
                                                width: 2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(26.0)),
                                            borderSide: BorderSide(
                                                color: Colors.grey[200],
                                                width: 2),
                                          ),
                                        ),
                                        onSaved: (value) {},
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  ButtonTheme(
                                    child: IconButton(
                                        icon: Icon(Icons.filter),
                                        color: Colors.blue,
                                        onPressed: () {}),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Category',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.5,
                              ),
                              Container(
                                height: 60,
                                padding: EdgeInsets.only(left: 15),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: homeProvier.categories.length,
                                  itemBuilder: (ctx, item) {
                                    return InkWell(
                                      onTap: () {},
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 25),
                                        child: Column(
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 15,
                                              backgroundImage: NetworkImage(
                                                  homeProvier.categories[item]
                                                      ['image']),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.cover,
                                              child: Text(
                                                homeProvier.categories[item]
                                                    ['name'],
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Most Requested',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                height: 178,
                                padding: EdgeInsets.only(left: 15),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: homeProvier.mostRequested.length,
                                  itemBuilder: (ctx, item) {
                                    return InkWell(
                                      // key: Key('most_requested_list_item'),
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            ProductDetailsScreen.routeName,
                                            arguments: homeProvier
                                                .mostRequested[item]['id']);
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Stack(children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            child: Image.network(
                                              homeProvier.mostRequested[item]
                                                  ['image'],
                                              height: 178,
                                              width: 156,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 15,
                                            left: 15,
                                            height: 32,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  homeProvier
                                                          .mostRequested[item]
                                                      ['name'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  '\$ ${homeProvier.mostRequested[item]['price']}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          )
                                        ]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Offers',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                height: 178,
                                padding: EdgeInsets.only(left: 15),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: homeProvier.offers.length,
                                  itemBuilder: (ctx, item) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Stack(children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Image.network(
                                            homeProvier.offers[item]['image'],
                                            height: 178,
                                            width: 156,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 15,
                                          left: 15,
                                          height: 32,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                homeProvier.offers[item]
                                                    ['name'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                '\$ ${homeProvier.offers[item]['price']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            width: 35,
                                            height: 35,
                                            top: 15,
                                            left: 106,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.blue[300],
                                              child: Text(
                                                '55',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ))
                                      ]),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 56,
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }),
                );
              }
            }
          }),
    );
  }
}
