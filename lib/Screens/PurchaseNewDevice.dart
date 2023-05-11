import 'package:flutter/material.dart';
import 'package:saintconnect/Screens/MyCardStage2.dart';
import 'package:saintconnect/Screens/uploadCardDesign.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/widgets/bottomnavigattionbar.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:url_launcher/url_launcher.dart';

class PurchaseNewDevice extends StatelessWidget {
  static const routename="PurchaseNewDevice";
  List data=[
    {

      'title':'White Connect Card',

    },
    {

      'title':'Black Connect Card',
    },
    {

      'title':'Custom Card',
    },
  ];
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
  @override

  Widget build(BuildContext context) {

    final height=MediaQuery.of(context).size.height;

    final width=MediaQuery.of(context).size.width;

    return Scaffold(


      backgroundColor: bgcolor,

      body: ListView(

        children: [


          SizedBox(height: height*0.025,),


          Container(

            height: height*0.05,
            child: Row(

              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Container(
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.088),
                  child: IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.arrow_back,color: Colors.white,size: width*0.075,)),
                ),

                Image.asset("images/logo.png",height: height*0.05,fit: BoxFit.fill,),

                SizedBox(width: width*0.025,),

                BuildItalicText(txt: "Connect", fontsize: 0.0358),

              ],
            ),
          ),
          SizedBox(height: height*0.05,),

          Container(
            alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width*0.065,right: width*0.1),
              child: BuildWhiteMuiliText(txt: "Active a Saint Connect Device", fontsize: 0.023)),
          SizedBox(height: height*0.05,),
          Container(
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
            height:  height *0.5,
            child:   GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: height*0.025,
                    crossAxisCount: 2,
                    mainAxisExtent: height*0.195,
                    crossAxisSpacing: width*0.025

                ),

                itemCount: 3,
                itemBuilder: (context,index){

                  return InkWell(
                      onTap: (){

                        if(index==2){
                          Navigator.of(context).pushNamed(
                              UploadCardDesign.routename,
                          arguments:data[index]['title']
                          );
                        }
                        else {
                          Navigator.of(context).pushNamed(
                              MyCardStage2.routename,
                              arguments:[data[index]['title'].toString(),data[index]['title'].toString()]
                          );
                        }
                        },
                      child: BuildCustomCard(context,index));

                }),
          ),


          InkWell(
              onTap: (){
                launchUrl(Uri.parse("https://saintconnect.info/our-products-saint-connect"));
              },
              child: BuildButton(text: "Purchase a New Device",fontsize: 0.0253)),
        ],

      ),
      bottomNavigationBar: Home_Bottom_Navigation_BAr(),
    );


  }

  Widget BuildCustomCard(BuildContext context,int index){
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Container(

      width: width*1,
      decoration: BoxDecoration(
          color: Color(0xff2A2A2A),
        borderRadius: BorderRadius.circular(5)
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            height: height*0.11,
            width: width*1,
            alignment: Alignment.centerLeft,

            decoration: BoxDecoration(
              color:
              index==1?
              Colors.black:
              Colors.white,
            ),
            padding: EdgeInsets.only(bottom: width*0.02,left: height*0.01),
            child:

            index==2?

                Container(
                  height: height*0.095,
                  width: width*1,
                  margin: EdgeInsets.only(right: width*0.017,top: height*0.01,),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff707070)
                    ),

                  ),

                  child: Center(child: BuildMuliGreyBold(txt: "Custom Card",   fontsize: 0.016 )),
            ):

            RotatedBox (
                quarterTurns: 1,
                child: BuildItalicText(txt: "Connect",fontsize: 0.012)),
          ),

          SizedBox(height: height*0.015,),

          BuildWhiteMuiliTextBold(txt: data[index]['title'], fontsize: 0.015),

        ],
      ),
    );
  }

}