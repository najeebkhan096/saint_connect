import 'package:flutter/material.dart';
import 'package:saintconnect/Screens/ActivateDevice.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/MyProfile.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/widgets/bottomnavigattionbar.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';


class CardCreationSuccesScreen extends StatelessWidget {
  static const routename="CardCreationSuccesScreen";
  MyProfile ? desireduser;
  String ? cardtype='';
  String imgurl='';
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;

    List data=ModalRoute.of(context)!.settings.arguments as List;
    if(data.isNotEmpty){
      cardtype=data[1];
      desireduser=data[0];
      imgurl=data[2];
      print("gaando "+cardtype .toString());
    }

    return Scaffold(
      backgroundColor: bgcolor,
      body: Stack(
        children: [

          Container(

              width: width*1,
              height: height*1,
decoration: BoxDecoration(

  image: DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage("images/Saint Connect - Success.gif"))
),


          ),
          Column(

            children: [

              SizedBox(height: height*0.15,),

              BuildWhiteMuiliTextBold(txt: "🎉 Success! 🎉", fontsize: 0.0305),

              Container(
                    width: width*0.7,
                    child: BuildWhiteMuiliTextBold(txt: 'Your Profile has been Connected.', fontsize: 0.0305)),

              SizedBox(height: height*0.05,),

              Container(
                width: width*(1-0.4),
                height: height*0.25,
                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    Positioned(

                      bottom: 0,

                   child:  (cardtype=="White Connect Card" )?

                   Container(
                     height: height*0.195,
                     width: width*(1-0.4),
                     margin: EdgeInsets.only(top: height*0.0075,bottom: height*0.01),
                     child: AspectRatio(
                       aspectRatio: 17/11,
                       child: Center(
                         child: Container(
                           // height: height*0.16,
                           // width: width*1,
                           decoration: BoxDecoration(
                             color: Colors.white,
                             boxShadow: [
                               BoxShadow(
                                   color: Color(0xffDAC07A),
                                   blurRadius: 10
                               )
                             ],

                           ),

                           padding: EdgeInsets.only(left: height*0.015),
                           child:


                           Container(

                             alignment: Alignment.centerLeft,

                             child: RotatedBox (
                                 quarterTurns: 1,
                                 child: BuildItalicText(txt: "Connect",fontsize: 0.025)),
                           )
                           ,
                         ),
                       ),
                     ),
                   ):
                   cardtype=="Black Connect Card"?
                   Container(
                      height: height*0.195,
                      width: width*(1-0.4),
                     margin: EdgeInsets.only(top: height*0.0075,bottom: height*0.01),
                     child: AspectRatio(
                       aspectRatio: 17/11,
                       child: Center(
                         child: Container(
                           // height: height*0.16,
                           // width: width*1,
                           decoration: BoxDecoration(
                             color: Colors.black,
                             boxShadow: [
                               BoxShadow(
                                   color: Color(0xffDAC07A),
                                   blurRadius: 10
                               )
                             ],

                           ),

                           padding: EdgeInsets.only(left: height*0.015),
                           child:


                           Container(

                             alignment: Alignment.centerLeft,

                             child: RotatedBox (
                                 quarterTurns: 1,
                                 child: BuildItalicText(txt: "Connect",fontsize: 0.025)),
                           )
                           ,
                         ),
                       ),
                     ),
                   ):
                   Container(
                     height: height*0.2,
                     width: width*(1),
                     margin: EdgeInsets.only(top: height*0.0075,bottom: height*0.01),
                     child: AspectRatio(
                       aspectRatio: 17/11,
                       child: Center(
                         child: Container(
                           // height: height*0.16,
                           // width: width*1,
                           decoration: BoxDecoration(
                             color: Colors.black,
                             boxShadow: [
                               BoxShadow(
                                   color: Color(0xffDAC07A),
                                   blurRadius: 10
                               )
                             ],
                           ),
                           child: AspectRatio(
                             aspectRatio: 17/11,
                             child: Image.network(imgurl,fit: BoxFit.cover,),
                           )
                           ,
                         ),
                       ),
                     ),
                   ),


                    ),

                    Positioned(
                      top: 0,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Color(0xffDAC07A),
                        child:
                        desireduser!.profile_image!.isEmpty?
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Color(0xff111111),
                          child: Image.asset("images/logo.png",width: width*0.1,),
                        ):
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Color(0xff111111),
                          backgroundImage: NetworkImage(desireduser!.profile_image.toString()),
                        ),
                      ),
                    ),



                  ],
                ),
              ),

              SizedBox(height: height*0.15,),

              InkWell(

                  onTap: () {

                    Navigator.of(context).pushNamedAndRemoveUntil(ActivateDevice.routename, (route) => false);

                  },
                  child: BuildButton(text: "Complete",fontsize: 0.0253,)),



            ],
          ),
        ],
      ),
    // bottomNavigationBar: Home_Bottom_Navigation_BAr(),
    );
  }
}
