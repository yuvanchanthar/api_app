//import 'package:api_integration_application/company_provider.dart';
import 'package:api_integration_application/model/company.dart';
import 'package:api_integration_application/provider/company_provider.dart';
import 'package:api_integration_application/screen/edit_company.dart';
//import 'package:api_integration_application/service/company_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'create_company.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override 
  void initState() {
    
    super.initState();
    Future.microtask(()=> context.read<CompanyProvider>().fetchCompany());
  }
  void _navigateToAddScreen()async{
    final result= await Navigator.push(context, MaterialPageRoute(builder: (_)=>AddCompany()),);
    if(result==true){
      _showSnackBar('Company added successfully');

    }
  }
  void _navigateToEditScreen(Company company)async{
    final result= await Navigator.push(context, MaterialPageRoute(builder: (_)=>EditCompany(company: company)));
    if(result==true){
      _showSnackBar('Company updated successfully');
    }
  }
  void _deleteCompany(Company company)async{
    showDialog(context: context, builder: (_)=>AlertDialog(
      title: Text("Delete Company"),
      content: Text("Are you sure want to delete ${company.name}?"),
      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context), child: Text("cancel")),
        ElevatedButton(style: 
          ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: ()async{
          Navigator.pop(context);
          final success= await context.read<CompanyProvider>().deletedCompany(company.id!);
          if(success){
        _showSnackBar("Company delete successfully");

          }
        }, child: Text("Delete",style: TextStyle(color: Colors.white),))
      ],
    ));
  }
  void _showSnackBar(String message)async{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.blue[100],
      centerTitle: true,
      title: Text("Companies"),
      actions: [
        IconButton(onPressed: ()=> context.read<CompanyProvider>().fetchCompany(), icon: Icon(Icons.refresh)),
      ],
    ),
    body: Consumer<CompanyProvider>(builder: (context, provider, child){
      if(provider.isLoading && provider.companys.isEmpty){
        return Center(child: CircularProgressIndicator(),);
      }
      if(provider.error != null && provider.companys.isEmpty){
        return Center(
          child: Column(children: [
            Icon(Icons.error_outline, size: 48,color: Colors.red,),
            SizedBox(height: 16,),
            ElevatedButton(onPressed: ()=>provider.fetchCompany(), child: Text("Retry"),)
          ],),
        );
      }
      if(provider.companys.isEmpty){
        return Center(child: Column(
          children: [
            Icon(Icons.business,size: 80,color: Colors.grey[600],),
            SizedBox(height: 20,),
            Text("Tap + button to add your first company"),
          ],
        ),);
      }
      return ListView.builder(
        itemCount: provider.companys.length,
        itemBuilder: (context, index){
        final company=provider.companys[index];
        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
          child: ListTile(
            leading: _buildCompanyLogo(company),
            title: Text(
              company.name,
              style: TextStyle(
                fontWeight: FontWeight.bold),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4,),
                Row(
                  children: [
                    Icon(Icons.phone,
                 size: 14,color: Colors.grey,),
                SizedBox(width: 4,),
                Text(company.phone),
                  ],
                ),
                SizedBox(height: 2,),
                Row(children: [
                  Icon(Icons.location_on,size: 14,color: Colors.grey,),
                  const SizedBox(width: 4),
                  Expanded(child: Text(company.address)),

                ],)
                
              ],),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: ()=>_navigateToEditScreen(company), icon: Icon(Icons.edit)),
                  IconButton(onPressed: ()=> _deleteCompany(company), icon: Icon(Icons.delete)
                  ),

                ],
              ),
              isThreeLine: true,
               
          ),

        );
      }
      );
    }
    
      
    
    ),
    floatingActionButton: FloatingActionButton.extended(onPressed: _navigateToAddScreen, label: Text("Add Company"),
    icon: Icon(Icons.add),),
    );
  }

  Widget _buildCompanyLogo(Company company){
    if(company.logo != null && company.logo!.isNotEmpty){
      return CircleAvatar(
        radius: 25,
        backgroundColor: Colors.grey[300],
        backgroundImage: NetworkImage(company.logo!),
        onBackgroundImageError: (exception, stackTrace) {
          debugPrint('Failed to load logo: $exception');
        },
        child: company.logo!.startsWith('http')? null
        : Text(company.name.isNotEmpty ? company.name[0].toUpperCase() :'?',
        style: TextStyle(fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white),
        ),

      );
    }
    
     
    
    else{
      return CircleAvatar(
        radius: 25,
        backgroundColor: _getColorFromName(company.name),
        child: Text(company.name.isNotEmpty? company.name[0].toUpperCase():'?',
        style: TextStyle(fontSize: 20,
        fontWeight: FontWeight.bold,color: Colors.white),),
      );
    }

  }
  Color _getColorFromName(String name){
    final colors=[
      Colors.indigo,
      Colors.blue,
      Colors.teal,
      Colors.green,
      Colors.red,
      Colors.purple,
      Colors.pink,
      Colors.cyan,
      Colors.amber,
    ];
    final index=name.hashCode.abs()% colors.length;
    return colors[index];

   }
    
  }



