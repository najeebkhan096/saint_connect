import 'package:flutter/material.dart';
import 'package:saintconnect/Screens/ActivateDevice.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/MyProfile.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/widgets/bottomnavigattionbar.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';


class ProfileCreated extends StatelessWidget {
  static const routename="ProfileCreated";
  MyProfile ? desireduser;

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;

    desireduser=ModalRoute.of(context)!.settings.arguments as MyProfile;


    return Scaffold(
      bottomNavigationBar: Home_Bottom_Navigation_BAr(),
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
              SizedBox(height: height*0.05,),
              Center(
                child: Container(
                 height:  height*0.05,
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Image.asset("images/logo.png",height: height*0.05,fit: BoxFit.fill,),

                     SizedBox(width: width*0.025,),

                     BuildItalicText(txt: "Connect", fontsize: 0.0358),
                   ],
                 ),
                      ),
              ),


              SizedBox(height: height*0.1,),

              BuildWhiteMuiliTextBold(txt: "🎉 Success! 🎉", fontsize: 0.0305),

              Container(
                  width: width*0.7,
                  child: BuildWhiteMuiliTextBold(txt: 'Your Profile has been Created.', fontsize: 0.0305)),

              SizedBox(height: height*0.05,),

              Container(
                width: width*(1-0.49),
                height: height*0.21,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      child: CircleAvatar(
                        radius: height*0.1,
                        backgroundColor: Color(0xffDAC07A),
                        child:
                        desireduser!.profile_image!.isEmpty?
                        CircleAvatar(
                          radius: height*0.0975,
                          backgroundColor: Color(0xff111111),
                          child: Image.asset("images/logo.png",width: width*0.15,fit: BoxFit.fill),
                        ):
                        CircleAvatar(
                          radius: height*0.0975,
                          backgroundColor: Color(0xff111111),
                          backgroundImage: NetworkImage(desireduser!.profile_image.toString()),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right:0,
                      child: CircleAvatar(
                        radius: height*0.04,
                        backgroundColor: Color(0xffDAC07A),
                        child:
                        desireduser!.logo!.isEmpty?
                        CircleAvatar(
                          radius: height*0.038,
                          backgroundColor: Color(0xff111111),
                          child: Image.asset("images/comp logo.png",width: width*0.13,),
                        ):
                        CircleAvatar(
                          radius: height*0.038,
                          backgroundColor: Color(0xff111111),
                          backgroundImage: NetworkImage(desireduser!.logo.toString()),
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
                  child: BuildButton(text: "Connect Profile to a Card",fontsize: 0.0235,)),



            ],
          ),
        ],
      ),
      // bottomNavigationBar: Home_Bottom_Navigation_BAr(),
    );
  }
}
