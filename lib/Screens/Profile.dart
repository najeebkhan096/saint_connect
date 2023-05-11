import 'package:flutter/material.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
class Profile extends StatelessWidget {
  static const routename="Profile";
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
              Center(child: Image.asset("images/connectlogo.png",height: height*0.05,)),
              SizedBox(height: height*0.05,),
              BuildWhiteText(txt: "Success", fontsize: 0.035),
              BuildWhiteText(txt: 'Your Profile has been Created.', fontsize: 0.035),
              SizedBox(height: height*0.025,),

              Container(
                height: height*0.23,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Color(0xffDAC07A),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage: NetworkImage("https://tse1.mm.bing.net/th?id=OIP.jv5Prpg0qyrbhudscnKrxQHaJF&pid=Api&P=0"),
                      ),
                    ),

                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: CircleAvatar(
                        radius: 27,
                        backgroundColor: mycolor,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black,
                          child: Image.asset("images/logo.png",height: height*0.025),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(height: height*0.15,),
              BuildButton(text: "Connect Profile to a Card",fontsize: 0.028),



            ],
          ),
        ],
      ),
    );
  }
}
