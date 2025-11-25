import 'package:api_integration_application/model/company.dart';
import 'package:api_integration_application/service/company_service.dart';
import 'package:flutter/material.dart';

class CompanyProvider extends ChangeNotifier{

  final CompanyService _service=CompanyService();
  List<Company> _companys=[];
  bool _isLoading=false;
  String? _error;

  List<Company> get companys=>_companys;
  bool get isLoading=> _isLoading;
  String? get error=>_error;

  Future<void> fetchCompany()async{
    _isLoading=true;
    _error=null;
    notifyListeners();

    try{
      _companys=await _service.getAllCompany();
    }catch(e){
      _error=e.toString();
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }
  Future<bool> addCompany(Company company)async{
    _error=null;
    try{
      final createdCompany= await _service.createCompany(company);
      _companys.insert(0, createdCompany);
      notifyListeners();
      return true;
    }catch(e){
      _error=e.toString();
      
      notifyListeners();
      return false;
    }

  }
  Future<bool> updateCompany(Company company)async{
   
    _error=null;
   
    try{
      final updatedCompany= await _service.updateCompanys(company.id!, company);
      final index=_companys.indexWhere((c)=>c.id ==company.id);
      if(index != -1){
        _companys[index]=updatedCompany;
        notifyListeners();
      }
      return true;
    }
    catch(e){
      _error=e.toString();
      notifyListeners();
      return false;
    }

  }
  

  Future<bool> deletedCompany(int id)async{
  
    _error=null;
    
    try{
      await _service.deleteCompany(id);
      _companys.removeWhere((company)=> company.id==id);
      notifyListeners();
      return true;
      
    }catch(e){
      _error=e.toString();
      notifyListeners();
      return false;
    }

  }


}