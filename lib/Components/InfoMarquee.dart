import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';



class InfoMarquee extends StatefulWidget {
  @override
  _InfoMarqueeState createState() => _InfoMarqueeState();
}

class _InfoMarqueeState extends State<InfoMarquee> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      child: Container(
        height: 100,
        child: Marquee(
          child: Row(
            children: [
              Image.network('https://pmjay.gov.in/sites/default/files/2020-12/slider-6.png',width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
              SizedBox(width: 5,),
              Image.network('https://pmjay.gov.in/sites/default/files/2020-12/slider-2a.png',width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
            ],
          ),

        ),
      ),
    );
  }
}
