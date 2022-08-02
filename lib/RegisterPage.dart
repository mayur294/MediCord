
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  String pName;
  String email;
  String pass;
  String dOB;
  String insuranceComp;
  String insurancePolicy;
  int weight;
  int height;
  String gender;
  String bloodGrp;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: TextField(
                              onChanged: (value){
                                pName = value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Name"
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: TextField(
                              onChanged: (value){
                                email = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "E-Mail"
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: TextField(
                              onChanged: (value){
                                pass = value;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Create Password"
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: TextField(
                              onChanged: (value){
                                dOB = value;
                              },
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Date of Birth(DD/MM/YYYY)"
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: TextField(
                              onChanged: (value){
                                insuranceComp = value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Insurance Company"
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: TextField(
                              onChanged: (value){
                                insurancePolicy = value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Policy No."
                              ),
                            ),
                          ),
                        ),
                        Card(

                          child: ListTile(
                            title: TextField(
                              onChanged: (value){
                                weight = int.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Weight"
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: TextField(
                              onChanged: (value){
                                height = int.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Height"
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: TextField(
                              onChanged: (value){
                                gender = value;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Gender"
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: TextField(
                              onChanged: (value){
                                bloodGrp = value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Blood Group"
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async{
                  if(email != null && pName != null && dOB != null && bloodGrp != null && height != null && weight != null && gender != null){

                    final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
                    if(newUser != null){
                      try{
                        await _firestore.collection("Users").add(
                            {
                              'Email': email,
                              'Name': pName,
                              'DOB': dOB,
                              'Blood Group': bloodGrp,
                              'Height': height,
                              'Weight': weight,
                              'Gender': gender,
                              'Insurance Company': insuranceComp,
                              'Policy': insurancePolicy,
                            }
                        ).whenComplete(() => Fluttertoast.showToast(msg: "User Created"));
                      }catch(e){
                        Fluttertoast.showToast(msg: "Error:$e");
                      }
                    }
                    Navigator.pushNamed(context, '/Dashboard');
                  }
                  else{
                    Fluttertoast.showToast(msg: "Fill All Required Feilds");
                  }
                },
                child: Text("Register"),
              )
            ],
          )
      ),
    );
  }
}
