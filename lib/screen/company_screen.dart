import 'package:api_integration_application/company_provider.dart';
import 'package:api_integration_application/model/company.dart';
import 'package:api_integration_application/service/company_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'create_company.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override void initState() {
    
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      
    },);
    Provider.of<CompanyProvider>(context, listen: false).getAllCompany();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("Companies"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateCompany(),
            ),
          ).then((_) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),

      body: Consumer<CompanyProvider>(builder: (context, value, child) {
        return 
      
        FutureBuilder(
          future: CompanyService().getAllCompany(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Error loading data"));
            }
        
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
        
            final List<Company> companies = snapshot.data!;
        
            return ListView.builder(
              itemCount: companies.length,
              itemBuilder: (context, index) {
                final company = companies[index];
        
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        company.logo ??
                            "https://logo.clearbit.com/google.com",
                      ),
                    ),
                    title: Text(company.name ?? "No name"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(company.phone ?? "No phone"),
                        Text(company.address ?? "No address"),
                      ],
                    ),
        
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CreateCompany(company: company),
                              ),
                            ).then((_) => setState(() {}));
                          },
                        ),
        
                        
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _confirmDelete(company.id!);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
  }),
    );
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Company"),
        content: const Text("Are you sure you want to delete this company?"),
        actions: [
          TextButton(
            child: const Text("No"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Yes"),
            onPressed: () async {
              await CompanyService().deleteCompany(id);
              Navigator.pop(context);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

