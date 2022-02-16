import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:plant_app/app/core/constants/constants.dart';


getAllProductList() async {
    var apiEndpoint = baseIpUrl + "/products/list/";
    var response = await http.get(
      Uri.parse(apiEndpoint),
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

getRandomProductList() async {
  var apiEndpoint = baseIpUrl + "/products/random/";
  var response = await http.get(
      Uri.parse(apiEndpoint),
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

getLastProductsList() async {
  var apiEndpoint = baseIpUrl + "/products/last/";
  var response = await http.get(
      Uri.parse(apiEndpoint),
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