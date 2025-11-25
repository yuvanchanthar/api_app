//import 'package:api_integration_application/company_provider.dart';
import 'package:api_integration_application/provider/company_provider.dart';
import 'package:api_integration_application/screen/company_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_)=> CompanyProvider(),
    child: const MainApp()) );
   
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> CompanyProvider(),
     child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CompanyScreen()
    ));
  }
}
