import 'package:flutter/material.dart';
import 'package:saintconnect/Screens/CreateAccount.dart';
import 'package:saintconnect/Screens/HomePage.dart';
import 'package:saintconnect/Screens/Register.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
class Welcome extends StatelessWidget {
  static const routename="Welcome";
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgcolor,

      body: ListView(
        children: [
            SizedBox(height: height*0.05,),
          Center(
            child: Container(
              alignment: Alignment.center,

              child:       Image.asset("images/logo.png",height: height*0.05,),
            ),
          ),

          SizedBox(height: height*0.05,),

         Center(child: BuildItalicText(txt: "Welcome to Saint Connect",fontsize: 0.03,)),

          SizedBox(height: height*0.075,),

          Center(
            child: Container(

               width: width*1,
               height: height*0.4,
margin: EdgeInsets.only(right: width*0.1,
left: width*0.1
),
color: bgcolor,


                child: Image.asset("images/welcome.gif",)

            ),
          ),


          SizedBox(height: height*0.1,),

          InkWell(

              onTap: (){

                Navigator.of(context).pushNamed(RegisterScreen.routename);

              },

              child: BuildButton(text: "Create an Account",fontsize: 0.024,)),



          SizedBox(height: height*0.025,),

          InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(CreateAccount.routename);
              },
              child: Center(child: BuildDTextDemiItalic(txt: "Already a Saint? Sign in here", fontsize: 0.02)))


        ],
      ),
    );
  }


}
