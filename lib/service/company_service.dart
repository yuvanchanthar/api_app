import 'dart:convert';
import 'package:api_integration_application/model/company.dart';
import 'package:http/http.dart' as http;


class CompanyService {

  final String baseUrl = "https://retoolapi.dev/7VhPDU/data";

  Future<List<Company>> getAllCompany() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((data) => Company.fromJson(data)).toList();
    } else {
      throw Exception("Failed to load companies");
    }
  }

 
  Future<Company> createCompany(Company company) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(company.toJson())

     
    );
    if(response.statusCode==201){
      final data=jsonDecode(response.body);
      return company.copyWith(id: data['id']);
    }
    else{
      throw Exception("Failed to create company");
    }

   
  }

  Future<Company> updateCompanys(int id,Company company) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(company.toJson()),
    );
    if(response.statusCode==200){
      return Company.fromJson(jsonDecode(response.body));

    }
    else{
      throw Exception("Failed to update");
    }

    
  }

 
  Future<void> deleteCompany(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
  
    if(response.statusCode != 200){
      throw Exception("Failed to delete");

    }

    
  }
}
