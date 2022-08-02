import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare_v1_3/Components/BloodPressure.dart';
import 'package:medicare_v1_3/Components/InfoMarquee.dart';
import 'package:medicare_v1_3/Components/Spo2.dart';
import 'package:medicare_v1_3/Components/UserInfoTile.dart';
import 'package:medicare_v1_3/Components/getCurrentUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Components/MyBottomNavigationBar.dart';

var userData;
var user;
var date = new DateTime.now().toString();
var dateParse = DateTime.parse(date);
var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";



class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _auth = FirebaseAuth.instance;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    user = getCurrentUser();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MyBottomNavigationBar(_currentIndex, context),
        appBar: AppBar(
          leading: ElevatedButton(
            child: Icon(Icons.arrow_back),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushNamed(context, '/LoginPage');
            },
          ),
          title: Row(
            children: [
              Text('MediCord'),
              Icon(
                Icons.add,
                color: Colors.red,
                size: 30,
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: ListView(
              children: [
              InfoMarquee(),
              UserInfoTile(),
              Card(
                margin: EdgeInsets.all(5),
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    BloodPressure(),
                    TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                int high,low;
                                return AlertDialog(
                                  title: Text('Add Data'),
                                  content: Container(
                                    height: 150,
                                    child: Column(
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                            labelText: 'High'
                                          ),
                                          onChanged: (value){
                                            high = int.parse(value);
                                          },
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            labelText: 'Low'
                                          ),
                                          onChanged: (value){
                                            low = int.parse(value);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(onPressed: ()async{
                                      await FirebaseFirestore.instance.collection('UserBloodPressure').add({
                                        'High': high,
                                        'Low' : low,
                                        'Date And Time' : formattedDate,
                                        'user' : user
                                      }).whenComplete(() => Navigator.pop(context));

                                    }, child: Text('+Add'))
                                  ],
                                );
                              });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Blood Pressure',style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(
                              '+ Add Data',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Row(
                children: [
                  Card(
                    margin: EdgeInsets.all(5),
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Spo2(),
                        Container(
                          child: TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      int Spo2;
                                      return AlertDialog(
                                        title: Text('Add Data'),
                                        content: Container(
                                          height: 150,
                                          child: Column(
                                            children: [
                                              TextField(
                                                decoration: InputDecoration(
                                                    labelText: 'Spo2'
                                                ),
                                                onChanged: (value){
                                                  Spo2 = int.parse(value);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(onPressed: ()async{
                                            await FirebaseFirestore.instance.collection('UserSpo2').add({
                                              'Spo2': Spo2,
                                              'Day' : dateParse.day,
                                              'Month' :dateParse.month,
                                              'Year' :dateParse.year,
                                              'user' : user
                                            }).whenComplete(() => Navigator.pop(context));

                                          }, child: Text('+Add'))
                                        ],
                                      );
                                    });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('SpO2',style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(
                                    '+ Add Data',
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                    Card(
                      margin: EdgeInsets.all(5),
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Spo2(),
                          Container(
                            child: TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        int Spo2;
                                        return AlertDialog(
                                          title: Text('Add Data'),
                                          content: Container(
                                            height: 150,
                                            child: Column(
                                              children: [
                                                TextField(
                                                  decoration: InputDecoration(
                                                      labelText: 'Spo2'
                                                  ),
                                                  onChanged: (value){
                                                    Spo2 = int.parse(value);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(onPressed: ()async{
                                              await FirebaseFirestore.instance.collection('UserSpo2').add({
                                                'Spo2': Spo2,
                                                'Day' : dateParse.day,
                                                'Month' :dateParse.month,
                                                'Year' :dateParse.year,
                                                'user' : user
                                              }).whenComplete(() => Navigator.pop(context));

                                            }, child: Text('+Add'))
                                          ],
                                        );
                                      });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('SpO2',style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text(
                                      '+ Add Data',
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                ],
              ),
                Card(
                  elevation: 15.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child: ListTile(
                      title: Text('Upcoming Appointments',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                      ),),
                      trailing: Column(
                        children: [
                          Text('Date:31/08/2021',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey
                          ),),
                          Text('Time: 02:30 PM',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey
                          ),),
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('For: Routine CheckUp',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey
                          ),),
                          Text('At: JK Hospital',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey
                          ),),
                        ],
                      ),
                    )
                  ),
                )
          ],
        ),
            ));
  }
}
