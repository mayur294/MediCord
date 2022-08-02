import 'package:flutter/material.dart';

BottomNavigationBar MyBottomNavigationBar(int _currentIndex,context){
  return BottomNavigationBar(

    currentIndex: _currentIndex,
    onTap: (index){
      if(index==0 && index!=_currentIndex)
        Navigator.pushNamed(context, '/Dashboard');
      if(index==1 && index!=_currentIndex)
        Navigator.pushNamed(context, '/MedicalRecords');
      if(index==2 && index!=_currentIndex)
        Navigator.pushNamed(context, '/MedicalHistory');
        _currentIndex = index;
    },
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home),
          label: 'General Records'),
      BottomNavigationBarItem(icon: Icon(Icons.receipt_outlined),
          label: 'Medical Records'),
      BottomNavigationBarItem(icon: Icon(Icons.history),
          label: 'Medical History'),

    ],
  );
}