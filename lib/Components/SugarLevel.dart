import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'getCurrentUser.dart';
import 'package:charts_flutter/flutter.dart' as charts;

var user;
var usersSpo2;
List<charts.Series<Data, DateTime>> seriesList = [];
List<Data> oxygenLevel=[];


class Spo2 extends StatefulWidget {
  @override
  _Spo2State createState() => _Spo2State();
}

class _Spo2State extends State<Spo2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seriesList.clear();
    oxygenLevel.clear();
    seriesList = getData();

  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('UserSpo2')
            .where('user', isEqualTo: user)
            .limit(4)
            .snapshots(),
        builder: (context,snapshot){
          print(user);
          if(snapshot.hasData == false){
            return Container();
          }
          usersSpo2 = snapshot.data.docs;
          for(var userSpo2 in usersSpo2){
            oxygenLevel.add(Data(DateTime(userSpo2.get("Year"),userSpo2.get("Month"),userSpo2.get("Day")),userSpo2.get('Spo2')));
          }
          seriesList=getData();
          return Container(
            height: 100,
            width: MediaQuery.of(context).size.width/2-10,
            child: Card(
                child: new charts.TimeSeriesChart(seriesList,
                  primaryMeasureAxis: new charts.NumericAxisSpec(
                      viewport: new charts.NumericExtents(50, 100)
                  ),
                )
            ),
          );
        }
    );
  }
}

List<charts.Series<Data, DateTime>> getData(){
  return [
    new charts.Series<Data, DateTime>(
      id: 'Low',
      domainFn: (Data date, _) => date.date,
      measureFn: (Data date, _) => date.spo2,
      data: oxygenLevel,
    ),
  ];
}

class Data {
  final DateTime date;
  final int spo2;

  Data(this.date, this.spo2);
}