import 'package:flutter/material.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:flutter_svg/flutter_svg.dart';
class BuildTeam extends StatelessWidget {
final String ? path;
final String ? title;
final String ? subtitle;
BuildTeam({this.path,this.title,this.subtitle});
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Container(
      height: height*0.17,
      width: width*1,
      margin: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.025),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Color(0xff2A2A2A),
          border: Border.all(
              color: mycolor
          )
      ),

      child: Row(

        children: [

          Container(

              width: width*0.33,

              child:
title=="View Your Card"?
              Image.asset("images/view_card.png",height: height*.075):
SvgPicture.asset(path!,height: height*0.075,
              color: mycolor,
              )
          ),

          Expanded(
            child: Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildWhiteMuiliTextBold(txt: title, fontsize: 0.02,start: true),
                  BuildWhiteMuiliText(txt: subtitle, fontsize: 0.016),

                ],
              ),
            ),
          )



        ],
      ),
    );
  }
}
