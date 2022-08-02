import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare_v1_3/Components/getCurrentUser.dart';

var user;
var userData;

class UserInfoTile extends StatefulWidget {
  @override
  _UserInfoTileState createState() => _UserInfoTileState();
}

class _UserInfoTileState extends State<UserInfoTile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = getCurrentUser();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('Email', isEqualTo: user)
            .snapshots(),
        builder: (context, snapshot) {
          var myCard;
          if (snapshot.hasData) {
            userData = snapshot.data.docs;
            final userdata = userData.first;
            myCard = Container(
              height: 100,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 15,
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(Icons.verified_user,size: 75,color: Colors.blue,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Name: ${userdata.get('Name')}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Weight: ${userdata.get('Weight')} Kgs',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey
                                ),),
                                Text(
                                    'Height: ${userdata.get('Height')} Cms',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey
                                  ),),
                                SizedBox(width: 15,)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('DOB: ${userdata.get('DOB')}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey
                                  ),),
                                Text('BGrp: ${userdata.get('Blood Group')}',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey
                                ),),
                                SizedBox(width: 15,)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    'Insurance Company: ${userdata.get('Insurance Company')}',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    'Policy No.: ${userdata.get('Policy')}',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            );
            return myCard;
          }
          return Container(child: Text('Something Went Wrong'));
        },
      ),
    );
  }
}
