import 'package:flutter/material.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';

class ShareDetails extends StatelessWidget {
  static const routename="ShareDetails";
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height*0.05,),

          Center(
              child: BuildWhiteText(txt: "Notes PAGE\nTHIS IS NOT A PAGE", fontsize: 0.035)),

          SizedBox(height: height*0.05,),

          Container(
              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
              child: BuildWhiteText(txt: "Profiles User will be able to switch between all profiles in the MyTeam section by swiping left and right.", fontsize: 0.035)),

          SizedBox(height: height*0.05,),

          Container(
              margin: EdgeInsets.only(
                left: width*0.05,right: width*0.05
              ),
              child: BuildWhiteText(txt: "QR Code Tapping the QR code brings up a larger image.", fontsize: 0.03)),

          SizedBox(height: height*0.05,),

            Container(
                margin: EdgeInsets.only(
                    left: width*0.05,right: width*0.05
                ),
                child: BuildWhiteText(txt: "SHARE FEATURE\n Ability to airdrop\nAbility to add to apple wallet\nAbility to share to social medias\nView live profile\nCopy live profile link\nAbility to message", fontsize: 0.03)),

          SizedBox(height: height*0.05,),


          Container(
              margin: EdgeInsets.only(
                  left: width*0.05,right: width*0.05
              ),
              child: BuildWhiteText(txt: "The ones I have listed are for IOS,Andriod versions needed.eg. nearby share & Google pay", fontsize: 0.03))

        ],
      ),
    );
  }
}
