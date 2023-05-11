import 'package:flutter/material.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
class Notes extends StatelessWidget {
  static const routename="Notes";
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgcolor,
      body: Stack(
        children: [

          Image.asset("images/colorfulBG.png",height: height*1,alignment: Alignment.bottomCenter,fit: BoxFit.cover),

          Column(
            children: [
              SizedBox(height: height*0.05,),

              Center(
                  child: BuildWhiteText(txt: "NOTES PAGE\nTHIS IS NOT A PAGE", fontsize: 0.035)),
              SizedBox(height: height*0.05,),

                Container(
                    margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                    child: BuildWhiteText(txt: "Profile Connections.A popup to appear allowing them to add any social platform that they want including spotify, YT, FB, Insta, etc \n\nPlaceholder Text.The text in the text boxes currently is to be used as placeholders.\n\nAccreditations is Image upload Video is to request a YT Link?\n-\nTO DO- A tutorial around the app when signed up. - Showing the different sections", fontsize: 0.035))
              

            ],
          ),
        ],
      ),
    );
  }
}
