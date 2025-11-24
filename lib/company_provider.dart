import 'package:api_integration_application/model/company.dart';
import 'package:api_integration_application/service/company_service.dart';
import 'package:flutter/material.dart';

class CompanyProvider extends ChangeNotifier{
  CompanyService _service=CompanyService();
  bool isLoading=false;

  List<Company> _company=[];
  List<Company> get company => _company;

  Future<void> getAllCompany()async{
    isLoading=true;
    notifyListeners();
    final respose= await _service.getAllCompany();
    _company=respose;
    isLoading=false;
    notifyListeners();



  }
}