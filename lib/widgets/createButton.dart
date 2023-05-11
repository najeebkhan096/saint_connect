import 'package:flutter/material.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/widgets/buildtext.dart';
class BuildButton extends StatelessWidget {
final double ?fontsize;
final String ? text;

BuildButton({required this.text,required this.fontsize});

  @override

  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Container(
      height: height*0.065,
      width: width*1,
      margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
      decoration: BoxDecoration(
        color: Color(0xff2A2A2A),
          border: Border.all(
            color: mycolor,
          ),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Text(text!,style: TextStyle(
            color: Colors.white,
            fontFamily: 'Muli-Regular',
       fontSize: height*fontsize!,
            //fontSize: 21,
            fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
class BuildWhiteButton extends StatelessWidget {

  final String ? text;

  BuildWhiteButton({required this.text});

  @override

  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Container(
      height: height*0.055,
      width: width*1,

      decoration: BoxDecoration(
         color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: BuildBlackMuiliText(txt: text!, fontsize: 0.024)
      ),
    );
  }
}
class BuildTextField extends StatelessWidget {

  final String ? text;
  String ? value;



  BuildTextField({required this.text});

  @override

  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Container(
      height: height*0.06,
      width: width*1,
      margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
      decoration: BoxDecoration(
        color: Color(0xff2A2A2A),
          border: Border.all(
            color: mycolor,
          ),
          borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.only(left: width*0.05),
      child:TextField(
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Muli-Regular',

        ),
        decoration: InputDecoration(
            border: InputBorder.none
        ),
      )
    );
  }
}
class BuildWhiteField extends StatelessWidget {

  final String ? text;

  BuildWhiteField({required this.text});

  @override

  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Container(
        height: height*0.054,
        width: width*1,

        decoration: BoxDecoration(
          color: Colors.white,

            borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.only(left: width*0.05),
        child:TextField(
          style: TextStyle(
            color: Color(0xff5D5D5D),
              fontFamily: 'Muli-Regular',

          ),
          decoration: InputDecoration(
              hintText: text,
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(0xff5D5D5D),
                fontFamily: 'Corporate A Italic',
                fontSize: 15

              )

          ),
        )
    );
  }
}
class BuildSocialButon extends StatelessWidget {

  final String ? text;
  final String ? image;

  BuildSocialButon({required this.text,required this.image});

  @override

  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Container(

      height: height*0.06 ,
      width: width*1,
      margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
      decoration: BoxDecoration(
          color: Colors.white,

      ),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,
     crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Image.asset("images/${image}",
              height: height*0.04,width: width*0.1,


          ),
          SizedBox(width: width*0.02,),
          BuildMuliGrey(txt: text!, fontsize: 0.02)

        ],
      ),
    );
  }
}