import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

String email;
String pass;

class LoginPage extends StatelessWidget {

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.add_circle_outline_rounded,
                        color: Colors.redAccent,
                        size: 30,
                      ),
                      title: Text(
                        'Medi-Cord',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      horizontalTitleGap: 0,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '                Making Life Digital',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Image.asset('images/loginPageImg.jpeg',
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
                              labelText: 'Email',
                            ),
                          )),
                    ),
                    Card(
                      child: ListTile(
                          trailing: Icon(
                            Icons.remove_red_eye,
                            color: Colors.black38,
                          ),
                          title: TextField(
                            onChanged: (value){
                              pass = value;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Password',
                            ),
                          )),
                    ),
                    ListTile(
                      onTap: () async{
                        await _auth.sendPasswordResetEmail(email: email);
                        Fluttertoast.showToast(msg: "Reset Link has Sent To Your Email");
                      },
                      trailing: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black12,
                          )
                        ],
                      ),
                      width: 350,
                      child: ElevatedButton(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.2,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () async{
                          if(email == null || pass == null){
                            Fluttertoast.showToast(msg: 'Enter Required Fields');
                          }
                          else{
                            try{
                              final user = await _auth.signInWithEmailAndPassword(email: email, password: pass);
                              if (user != null){
                                Navigator.pushNamed(context, '/Dashboard');
                              }
                            }
                            catch (e) {
                              Fluttertoast.showToast(msg: 'Error:$e');
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black12,
                          )
                        ],
                      ),
                      width: 350,
                      child: ElevatedButton(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.2,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/RegisterPage');
                        },
                      ),
                    ),
                  ],
                )
            ),
            ),
          )
    );
  }
}
