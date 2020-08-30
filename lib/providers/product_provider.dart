import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  String token;
  Map _detailsData; 

  ProductProvider(this.token,this._detailsData);

 

   Map get detailsData {
    return _detailsData;
  }

  
  Future<void> productDetails(int id) async {
    final url = 'https://ecommerce.service.ahmed-ajory.com/api/v1/product/$id';
    try {
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'lang': 'ar',
        'Authorization': 'Bearer $token',
      });
      final extractedData = jsonDecode(response.body);
       final loadedData = extractedData['data'];
      // final _dataList =[{
      //   'id' : loadedData['id'],
      //   'name' : loadedData['name'],
      //   'image' : loadedData['image'],
      //   'price' : loadedData['price'],
      //   'description' : loadedData['description'],
      //   'offer_id' : loadedData['offer_id'],
      //   'percent' : loadedData['percent'],
      //   'quantity' : loadedData['quantity'],
      //   'is_favourite' : loadedData['is_favourite'],
      // }];
      _detailsData = loadedData ; 
      // print(_detailsData);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;  
    }
  }
}
