import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kira_dashboard/infra/entities/country_code_entity.dart';

class CountryCodesRepository {
  Future<List<CountryCodeEntity>> getCountryCodes() async {
    String response = await rootBundle.loadString('country_codes_lat_long.json');
    List<dynamic> jsonResponse = await json.decode(response) as List<dynamic>;
    List<Map<String, dynamic>> jsonMap = jsonResponse.map((dynamic e) => e as Map<String, dynamic>).toList();
    List<CountryCodeEntity> countryCodes = jsonMap.map((Map<String, dynamic> e) => CountryCodeEntity.fromJson(e)).toList();
    return countryCodes;
  }
}
