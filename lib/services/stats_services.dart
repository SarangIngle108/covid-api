import 'dart:convert';

import 'package:covid_tracker/utilities/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:covid_tracker/model/WorlsStatsModel.dart';
class StatsServices {

  Future<WorlsStatsModel> fetchWorldStatsRecords() async {
    final response = await http.get(Uri.parse(APIUrl.worldStatesApi));


    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorlsStatsModel.fromJson(data);
    } else {
      throw Exception('Error')
      ;
    }
  }


  Future<List<dynamic>> fetchCountryStatsRecords() async {
    var data;
    final response = await http.get(Uri.parse(APIUrl.countriesList));


    if (response.statusCode == 200) {
       data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
