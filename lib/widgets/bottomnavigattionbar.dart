import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saintconnect/Screens/ActivateDevice.dart';
import 'package:saintconnect/Screens/HomePage.dart';
import 'package:saintconnect/Screens/Insight.dart';
import 'package:saintconnect/Screens/MyTeam.dart';
import 'package:saintconnect/Screens/QrCode.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/myuser.dart';


int current_index=0;
class Home_Bottom_Navigation_BAr extends StatefulWidget {
  const Home_Bottom_Navigation_BAr({Key? key}) : super(key: key);

  @override
  State<Home_Bottom_Navigation_BAr> createState() => _Home_Bottom_Navigation_BArState();
}

class _Home_Bottom_Navigation_BArState extends State<Home_Bottom_Navigation_BAr> {


  bool is_pressed = true;

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Container(
color: Colors.transparent,
      height: height*0.14,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          NavigationBarTheme(
            data: NavigationBarThemeData(
            indicatorColor:
            current_index==2?Colors.transparent:
            mycolor.withOpacity(0.25)
            ),
            child: NavigationBar(
              height: height*0.1,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              animationDuration: Duration(seconds: 0),
              selectedIndex: current_index,
              onDestinationSelected: (index) async {
                setState((){
                  current_index=index;
                });
if(index==0){
  Navigator.of(context).pushNamed(HomeScreen.routename);
}

if(index==1){
  Navigator.of(context).pushReplacementNamed(ActivateDevice.routename);
}

if(index==3){
  Navigator.of(context).pushNamed(Insights.routename);
}

if(index==4){
  Navigator.of(context).pushNamed(MyTeam.routename);
}


              },
              backgroundColor: Color(0xff2A2A2A),
              destinations: [


                NavigationDestination(
                  
                  icon:  SvgPicture.asset("navicons/home.svg",height: height*.05),

                  label: "Home",
                ),


                NavigationDestination(
                  icon:  SvgPicture.asset("navicons/mycards.svg",height: height*.05),


                  label: "Menu",
                ),

                NavigationDestination(

                  icon:  Icon(Icons.add,color: Color(0xff2A2A2A),),
                  label: "Nothing",
                ),


                NavigationDestination(
                  icon:  SvgPicture.asset("navicons/insights.svg",height: height*.05),

                  label: "Insight",
                ),
                NavigationDestination(
                  icon:  CircleAvatar(
                      radius: 15,
                      backgroundColor: mycolor,
                      child: CircleAvatar(
                          radius: 13,
                          backgroundColor: bgcolor,
                          child: SvgPicture.asset("navicons/profile.svg",height: height*.05))),

                  label: "Profile",
                ),
              ],
            ),
          ),
          Positioned(
top: 0,
            child: Container(

              height: height*0.1,
              width: width*1,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(QrCode.routename);

                  },
                  child: Container(

                    height: height*0.1,
                    width: width*0.2,
                    decoration: BoxDecoration(
                        color: Color(0xff3A3434),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  padding: EdgeInsets.all(8),
                  child: Image.network(currentuser!.qr_image.toString(), height: height*0.025,color: mycolor),

                  ),
                )
              ],
            ),
            ),
          ),
        ],
      ),
    );
  }


}
