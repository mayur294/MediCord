import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'Components/getCurrentUser.dart';

var user;
var type;
var description;
List images =[];
final picker = ImagePicker();
final _storage = FirebaseStorage.instance;
CollectionReference imgRef;

class UploadMedicalRecord extends StatefulWidget {

  @override
  _UploadMedicalRecordState createState() => _UploadMedicalRecordState();
}

class _UploadMedicalRecordState extends State<UploadMedicalRecord> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          ElevatedButton(onPressed: (){
            chooseImage();
          }, child: Text('+')),
          ElevatedButton(onPressed: (){
            uploadFile().whenComplete(() => images.clear());
            Navigator.pushNamed(context, '/MedicalRecords');
          }, child: Text('Upload')),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Builder(
            builder: (context){
              if(images.isEmpty){
                return Container(

                  child: Text('Press + to add File'),

                  );
              }
              else{
                return Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(images.last)
                            )
                        ),
                        ),
                      ),
                      Container(
                        child: Card(
                          child: ListTile(
                              title: TextField(
                                onChanged: (value){
                                  type = value;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Type(prescription,LabReport,etc)',
                                ),
                              )),
                        ),
                      ),
                      Container(
                        child: Card(
                          child: ListTile(
                              title: TextField(
                                onChanged: (value){
                                  description = value;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Description',
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
  chooseImage() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      images.add(File(pickedFile?.path));
    });
  }
  Future uploadFile() async {

       var ref = _storage.ref().child('images/${Path.basename(images.last.path)}');
      await ref.putFile(images.last).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'DocUrl': value,'Type':type,'Description':description,'user': user});
        });
      });

  }

  @override
  void initState() {
    user = getCurrentUser();
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('UserMedicalRecords');
  }

}
