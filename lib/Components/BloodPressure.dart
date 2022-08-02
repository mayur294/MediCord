import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'getCurrentUser.dart';
import 'package:charts_flutter/flutter.dart' as charts;

var user;
var usersBP;
var MyBloodPressure;
List<charts.Series> seriesList;
List<Data> lowerBP=[];
List<Data> higherBP=[];

class BloodPressure extends StatefulWidget {
  @override
  _BloodPressureState createState() => _BloodPressureState();
}

class _BloodPressureState extends State<BloodPressure> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = getCurrentUser();
    lowerBP.clear();
    higherBP.clear();
    if(seriesList != null)
    seriesList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("UserBloodPressure")
            .where('user', isEqualTo: user)
            .limit(4)
            .snapshots(),
        builder: (context,snapshot){
          print(user);
          if(snapshot.hasData == false){
            print('No Data Found');
            return Container();
          }
            usersBP = snapshot.data.docs;
            for(var userBP in usersBP){
              lowerBP.add(Data(userBP.get("Date And Time"),userBP.get('High')));
              higherBP.add(Data(userBP.get("Date And Time"),userBP.get('Low')));
              print(userBP.get("Date And Time"));
            }
            seriesList=getData();
            return MyBloodPressure = Container(
              width: double.infinity,
              height: 100,
              child: Card(
                child: new charts.BarChart(seriesList,barGroupingType: charts.BarGroupingType.grouped,),
              ),
            );
        }
        );
  }
}


List<charts.Series<Data, String>> getData(){
  return [
    new charts.Series<Data, String>(
      id: 'High',
      domainFn: (Data date, _) => date.date,
      measureFn: (Data date, _) => date.bP,
      data: higherBP,
    ),
    new charts.Series<Data, String>(
      id: 'Low',
      domainFn: (Data date, _) => date.date,
      measureFn: (Data date, _) => date.bP,
      data: lowerBP,
    ),
  ];
}

class Data {
  final String date;
  final int bP;

  Data(this.date, this.bP);
}
