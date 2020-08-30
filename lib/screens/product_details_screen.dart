import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import '../providers/product_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/product';

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // var _details ;
  var _isLoading = true;
  int _number = 0; 

  void add() {
  setState(() {
    _number++;
  });
}
void minus() {
  setState(() {
    if (_number != 0) 
      _number--;
  });
}

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      final productId = ModalRoute.of(context).settings.arguments as int;
      // setState(() {
      //   _isLoading = true;
      // });
      await Provider.of<ProductProvider>(context, listen: false)
          .productDetails(productId);
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
        title: Text(
          'product details',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Consumer<ProductProvider>(builder: (ctx, details, _) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Image.network(
                          details.detailsData['image'],
                          height: 371,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          details.detailsData['name'],
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          details.detailsData['description'],
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          alignment: Alignment.center,
                          width: 120,
                          height: 35,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                padding: EdgeInsets.only(right: 10),
                                // padding: EdgeInsets.all(12),
                                icon: Icon(Icons.remove),
                                onPressed: minus,
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Text('$_number'),
                              Divider(),
                              IconButton(
                                padding: EdgeInsets.only(left: 10),
                                icon: Icon(Icons.add),
                                onPressed: add,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 96,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                '\$ ${details.detailsData['price']}',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'for 1 piece',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          ButtonTheme(
                            minWidth: 163,
                            height: 51,
                            child: RaisedButton.icon(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26.0),
                              ),
                              icon: Icon(
                                Icons.shopping_basket,
                                color: Colors.white,
                              ),
                              color: Colors.blue,
                              label: Text(
                                'Add to cart',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 55,
                      )
                    ],
                  ),
                ),
              );
            }),
    );
  }
}
