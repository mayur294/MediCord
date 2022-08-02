import 'package:flutter/material.dart';
import 'Components/MyBottomNavigationBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:medicare_v1_3/Components/getCurrentUser.dart';

class MedicalRecords extends StatefulWidget {
  @override
  _MedicalRecordsState createState() => _MedicalRecordsState();
}

class _MedicalRecordsState extends State<MedicalRecords> {

  int _currentIndex = 1;
  var user = getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(onPressed: (){Navigator.pushNamed(context, '/UploadMedicalRecord');}, child: Text('Upload'))
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(_currentIndex, context),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('/UserMedicalRecords').where('user', isEqualTo: user).snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Container(
            padding: EdgeInsets.all(4),
            child: GridView.builder(
                itemCount: snapshot.data.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Card(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                      ),
                      onPressed: (){
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            content: FadeInImage.memoryNetwork(
                                fit: BoxFit.contain,
                                placeholder: kTransparentImage,
                                image: snapshot.data.docs[index].get('DocUrl')),
                            actions: [
                              ElevatedButton(onPressed: (){
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: Text('Scan to View Document'),
                                    content: BarcodeWidget(
                                      data: snapshot.data.docs[index].get('DocUrl'),
                                      barcode: Barcode.qrCode(),
                                      backgroundColor: Colors.white,
                                      height: 200,
                                      width: 200,
                                    ),
                                  );
                                });
                              }, child: Text('Share')),
                              ElevatedButton(onPressed: (){}, child: Text('Download'))

                            ],
                          );
                        });
                      },
                        child: Column(
                          children: [
                            Expanded(
                              child: FadeInImage.memoryNetwork(
                                  fit: BoxFit.contain,
                                  placeholder: kTransparentImage,
                                  image: snapshot.data.docs[index].get('DocUrl')),
                            ),
                            Text(('Type: ${snapshot.data.docs[index].get('Type')}')),
                            Text('Description: ${snapshot.data.docs[index].get('Description')}')
                          ],
                        ),
                      ),
                  );
                }),
          );
        },
      ),
    );
  }
}
