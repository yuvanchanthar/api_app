import 'package:api_integration_application/model/company.dart';
import 'package:api_integration_application/service/company_service.dart';
import 'package:flutter/material.dart';

class CreateCompany extends StatefulWidget {
  final Company? company;
  const CreateCompany({super.key, this.company});

  @override
  State<CreateCompany> createState() => _CreateCompanyState();
}

class _CreateCompanyState extends State<CreateCompany> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.company != null) {
      nameCtrl.text = widget.company!.name ?? "";
      phoneCtrl.text = widget.company!.phone ?? "";
      addressCtrl.text = widget.company!.address ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.company != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text(isEditing ? "Update Company" : "Add Company"),
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _buildField("Company Name", nameCtrl),
              _buildField("Phone Number", phoneCtrl),
              _buildField("Address", addressCtrl),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveCompany,
                child: Text(isEditing ? "Update" : "Create"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        
        controller: controller,
        validator: (v) => v!.isEmpty ? "Please enter $label" : null,
        decoration: InputDecoration(
          
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          ),
        ),
      ),
    );
  }

  
  void _saveCompany() async {
    if (_formKey.currentState!.validate()) {
      final company = Company(
        name: nameCtrl.text,
        phone: phoneCtrl.text,
        address: addressCtrl.text,
        logo: "https://logo.clearbit.com/apple.com",
      );

      if (widget.company == null) {
        await CompanyService().createCompany(company);
      } else {
        await CompanyService().updateCompany(company, widget.company!.id!);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Saved successfully!")),
      );

      Navigator.pop(context);
    }
  }
}
