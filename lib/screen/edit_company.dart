import 'package:api_integration_application/model/company.dart';
import 'package:api_integration_application/provider/company_provider.dart';
//import 'package:api_integration_application/service/company_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCompany extends StatefulWidget {
  final Company company;
  const EditCompany({super.key, required this.company});

  @override
  State<EditCompany> createState() => _EditCompanyState();
}

class _EditCompanyState extends State<EditCompany> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final TextEditingController nameCtrl;
  late final TextEditingController phoneCtrl;
  late final TextEditingController addressCtrl;
  late final TextEditingController logoCtrl;

  //  TextEditingController nameCtrl = TextEditingController();
  //  TextEditingController phoneCtrl = TextEditingController();
  //  TextEditingController addressCtrl = TextEditingController();
  bool _isLoading=false;

  @override
  void initState() {
    super.initState();
    nameCtrl=TextEditingController(text: widget.company.name);
    phoneCtrl=TextEditingController(text: widget.company.phone);
    addressCtrl= TextEditingController(text: widget.company.address);
    logoCtrl=TextEditingController(text: widget.company.logo);
    
  }

  
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
   // final isEditing = widget.company != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Text('Edit Company'),
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
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: logoCtrl,
                decoration: InputDecoration(
                  labelText: "Logo URL",
                  prefixIcon: Icon(Icons.image),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if(value== null || value.trim().isEmpty){
                    return "Please enter the company name";

                  }return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: _isLoading ? null : _updateCompany,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric
                (vertical: 16)),
                 child: _isLoading ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2,),
              ): const Text('Update Company',style: TextStyle(fontSize: 16),),),



            ],
          ),
        ),
      ),
    );
  }

  
  

  
  Future<void> _updateCompany() async {
    if (_formKey.currentState!.validate()) {
    setState(()=> _isLoading=true
      
    );
      final updatedCompany = widget.company.copyWith(
        name: nameCtrl.text.trim(),
        phone: phoneCtrl.text.trim(),
        address: addressCtrl.text.trim(),
        logo: logoCtrl.text.trim().isEmpty ? null: logoCtrl.text.trim(),
        //logo: "https://logo.clearbit.com/apple.com",
      );

      final success=await context.read<CompanyProvider>().updateCompany(updatedCompany);
      setState(() =>
        _isLoading=false
        
      );
      if(success && mounted){
        Navigator.pop(context,true);
      }
      else if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update company")));
      }

     
    }}
}
