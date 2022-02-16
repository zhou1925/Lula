import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:plant_app/app/core/constants/constants.dart';


getProductDetail(String slug) async {
    var apiEndpoint = baseIpUrl + "/products/list/";
    var response = await http.get(
      Uri.parse(apiEndpoint + slug + '/'),
      headers: {
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  getRelatedProducts(String productId) async {
    var apiEndpoint = baseIpUrl + "/products/related/";
    var response = await http.get(
      Uri.parse(apiEndpoint + productId + '/'),
      headers: {
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }