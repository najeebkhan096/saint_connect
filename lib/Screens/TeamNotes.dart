import 'package:flutter/material.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
class TeamNotes extends StatelessWidget {
  static const routename="TeamNotes";
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
        children: [
          SizedBox(height: height*0.05,),

          Center(
              child: BuildWhiteText(txt: "Notes PAGE\nTHIS IS NOT A PAGE", fontsize: 0.035)),
          SizedBox(height: height*0.05,),

          Container(
              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
              child: BuildWhiteText(txt: "When clicking the QR Code,it is to appear as a large image.When clicking the copy link, the link isto be brought into the clipboard of the device.", fontsize: 0.035))


        ],
      ),
    );
  }
}
