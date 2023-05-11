import 'dart:async';
import 'package:flutter/material.dart';
import 'package:saintconnect/Screens/welcome.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/wrapper.dart';

class SplashScreen extends StatefulWidget {

  static const routename="ActivateDevice";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 @override
  void initState() {
   // TODO: implement initState
   Timer(Duration(seconds: 5), ()=>Navigator.of(context).pushNamed(Wrapper.routename));
   super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      backgroundColor: bgcolor,

      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          Center(child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Image.asset("images/logo.png",height: MediaQuery.of(context).size.height*0.065),
               // Image.asset("images/logo.png",height: 50,width: 63,),
              SizedBox(width: MediaQuery.of(context).size.width*0.025,),
                  BuildItalicText(txt: "Connect", fontsize: 0.0465),

            ],
          )
          )

        ],
      ),
    );
  }
}
