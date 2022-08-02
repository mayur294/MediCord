import 'package:flutter/material.dart';
import 'package:medicare_v1_3/Components/MyBottomNavigationBar.dart';

class MedicalHistory extends StatefulWidget {

  @override
  _MedicalHistoryState createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {

  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(_currentIndex, context),
      body: SafeArea(
        child: Container(
          child: Text('Welcome To Medical History'),
        ),
      ),
    );
  }
}
