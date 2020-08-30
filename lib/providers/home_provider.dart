import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/category_model..dart';

class HomeProvdier with ChangeNotifier {
  List _categories;
  List _mostRequested;
  List _offers;
  String token;
  List _detailsData;

  HomeProvdier(this.token, this._categories, this._mostRequested, this._offers);

  List get categories {
    return [..._categories];
  }

  List get mostRequested {
    return [..._mostRequested];
  }

  List get offers {
    return [..._offers];
  }

  List get detailsData {
    return [..._detailsData];
  }

  Future<void> FetchHomeData() async {
    const url = 'https://ecommerce.service.ahmed-ajory.com/api/v1/home?';
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'lang': 'ar',
          'Authorization': 'Bearer $token',
        },
      );
      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return;
      }
      _categories = extractedData['data']['categories'];
      _mostRequested = extractedData['data']['most_requested'];
      _offers = extractedData['data']['offers'];
      notifyListeners();
    } catch (error) {
      throw error;
      // print(error);
    }
  }
}
