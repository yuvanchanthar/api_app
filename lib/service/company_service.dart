import 'dart:convert';
import 'package:api_integration_application/model/company.dart';
import 'package:http/http.dart' as http;


class CompanyService {

  final String baseUrl = "https://retoolapi.dev/V3Cg3f/company";

  Future<List<Company>> getAllCompany() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body);
      return jsonList.map((data) => Company.fromJson(data)).toList();
    } else {
      throw Exception("Failed to load companies");
    }
  }

 
  Future<bool> createCompany(Company company) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: company.toJson(),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<bool> updateCompany(Company company, int id) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      body: company.toJson(),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

 
  Future<bool> deleteCompany(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));

    return response.statusCode == 200 || response.statusCode == 204;
  }
}
