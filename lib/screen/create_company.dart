import 'package:api_integration_application/model/company.dart';
import 'package:api_integration_application/provider/company_provider.dart';
//import 'package:api_integration_application/service/company_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCompany extends StatefulWidget {
  final Company? company;
  const AddCompany({super.key, this.company});

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController logoCtrl=TextEditingController();
  bool _isLoading=false;

  
  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    logoCtrl.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
      
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [

              TextFormField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: "Company Name",
                  prefixIcon: Icon(Icons.business),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if(value== null || value.trim().isEmpty){
                    return "Please enter the company name";

                  }return null;
                },
                textInputAction: TextInputAction.next,
              ),

           

              const SizedBox(height: 20),
              TextFormField(
                controller: phoneCtrl,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: Icon(Icons.business),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if(value== null || value.trim().isEmpty){
                    return "Please enter the Phone Number";

                  }return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: addressCtrl,
                decoration: InputDecoration(
                  labelText: "Address",
                  prefixIcon: Icon(Icons.business),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if(value== null || value.trim().isEmpty){
                    return "Please enter the Address";

                  }return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: logoCtrl,
                decoration: InputDecoration(
                  labelText: "Logo URL ",
                  hintText: "https://example.com/logo.png",
                  prefixIcon: Icon(Icons.image),
                  border: OutlineInputBorder(),
                ),
               
              ),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: _isLoading ? null : _saveCompany, child: _isLoading ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2,),
              ): const Text('Add Company',style: TextStyle(fontSize: 16),),),



            ],
          ),
        ),
      ),
    );
  }

  
  

  
  Future<void> _saveCompany() async {
    if (_formKey.currentState!.validate()) {
      final company = Company(
        name: nameCtrl.text.trim(),
        phone: phoneCtrl.text.trim(),
        address: addressCtrl.text.trim(),
        logo:logoCtrl.text.trim().isEmpty ? null: logoCtrl.text.trim(),
        //logo: "https://logo.clearbit.com/apple.com",
      );

      final success=await context.read<CompanyProvider>().addCompany(company);
      setState(() =>
        _isLoading=false
        
      );
      if(success && mounted){
        Navigator.pop(context,true);
      }
      else if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add company")));
      }

     
    }}
}
