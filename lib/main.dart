import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medicare_v1_3/Components/Spo2.dart';
import 'package:medicare_v1_3/MedicalHistory.dart';
import 'package:medicare_v1_3/UploadMedicalRecord.dart';
import 'RegisterPage.dart';
import 'Dashboard.dart';
import 'LoginPage.dart';
import 'MedicalHistory.dart';
import 'MedicalRecords.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Scaffold(
    //     body: SafeArea(child: Spo2()),
    //   ),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/LoginPage',
      routes: {
        '/LoginPage':(context) => LoginPage(),
        '/RegisterPage':(context) => RegisterPage(),
        '/Dashboard':(context) => Dashboard(),
        '/MedicalHistory':(context) => MedicalHistory(),
        '/MedicalRecords':(context) => MedicalRecords(),
        '/UploadMedicalRecord':(context) => UploadMedicalRecord(),
      },
    );
  }
}
