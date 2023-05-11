import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saintconnect/Screens/ActivateDevice.dart';
import 'package:saintconnect/Screens/Newpassword.dart';
import 'package:saintconnect/Screens/change_email.dart';
import 'package:saintconnect/Screens/nfcscreen.dart';
import 'package:saintconnect/Screens/webview.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/MyProfile.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/widgets/bottomnavigattionbar.dart';
import 'package:saintconnect/widgets/buildpacage.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:saintconnect/widgets/wrapper.dart';
import 'package:url_launcher/url_launcher.dart';


class Setting extends StatefulWidget {
  static const routename="Setting";

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  _launchURL() async {
    if (Platform.isIOS) {
      const url = 'https://apps.apple.com/us/app/APP_NAME/idAPP_ID';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else if (Platform.isAndroid) {
      const url = 'https://play.google.com/store/apps/details?id=PACKAGE_NAME';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
  List<String> social=[
    'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/setting_social_icons%2Fsetting_fb.png?alt=media&token=b02c6645-325e-46ad-85c7-36af0128a9cb',
    'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/setting_social_icons%2Fsetting_insta.png?alt=media&token=99c58131-757e-4972-9aad-461bea52baf6',
   'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/setting_social_icons%2Fsetting_yt.png?alt=media&token=781644c8-529d-467a-8b89-0de77b0db768',
    'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/setting_social_icons%2Fsetting_twitter.png?alt=media&token=f3f61f78-e4e2-4f5f-9732-a1f03652f910',
    'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/setting_social_icons%2Fsetting_ld.png?alt=media&token=c34f1b63-6890-46ad-a2cb-3626642ba579',
  'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/setting_social_icons%2Fsetting_tiktok.png?alt=media&token=90753f25-45dd-4d60-92a7-05e4bd20abdd'


  ];
  String ? _show_logout()
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Color(0xff111111),
          title: BuildItalicText(txt: "Alert", fontsize: 0.018525),
          content:
          BuildItalicTextwhite(txt: "Are you sure you want to logout?", fontsize: 0.018),

          actions: <Widget>[

            Container(
              decoration: BoxDecoration(
                color: Color(0xffDAC07A),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                 child: Text('Yes',style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  try{
                    final googleSignIn = GoogleSignIn();
                    await googleSignIn.signOut().then((value) {

                    });
                  }catch(error){

                  }

                  FirebaseAuth _auth=  FirebaseAuth.instance;
                  await _auth.signOut().then((value) {


                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Wrapper()),
                            (route)=>false
                    );
                  });
                },
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
            Container(
             decoration: BoxDecoration(
               color: Colors.black38,
               borderRadius: BorderRadius.circular(10)
             ),
              child: TextButton(
                child: Text('No',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  Navigator.of(ctx).pop();
                },
              ),

            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.1,),
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Home_Bottom_Navigation_BAr(),
      backgroundColor: bgcolor,
      extendBody: true,
      body: ListView(
        children: [
          SizedBox(height: height*0.025,),

          Container(

            height: height*0.05,

            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Image.asset("images/logo.png",height: height*0.05,fit: BoxFit.fill,),

                SizedBox(width: width*0.025,),

                BuildItalicText(txt: "Connect", fontsize: 0.035),

              ],
            ),
          ),
          SizedBox(height: height*0.05,),

          Container(
              margin: EdgeInsets.only(left: width*0.08,right: width*0.08),
              height: height*0.155,
              width: width*1,

              decoration: BoxDecoration(
                  border: Border.all(
                    color: mycolor,
                    width: 0.75
                  ),
                  color: Color(0xff2A2A2A),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.only(left: width*0.05),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  BuildWhiteMuiliTextBold(txt:
                  currentuser_MyProfile==null?'':
                  currentuser_MyProfile!.your_details!.name!, fontsize: 0.018527),
                  SizedBox(height: height*0.005),
                  BuildWhiteMuiliText(txt: currentuser!.email, fontsize: 0.014),
                  SizedBox(height: height*0.005),
                  BuildWhiteMuiliText(txt: "Member Since : "+currentuser!.date!.day.toString()+"/"+currentuser!.date!.month.toString()+"/"+currentuser!.date!.year.toString(), fontsize: 0.014),
                  SizedBox(height: height*0.005),


                ],
              )
          ),
          SizedBox(height: height*0.025,),
          Container(
            margin: EdgeInsets.only(left: width*0.08,right: width*0.08),
            child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [

    Expanded(
      child : InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(NewPassword.routename);
      },
      child: Container(
            height: height*0.049,

            decoration: BoxDecoration(
                color: Color(0xff2A2A2A),
                border: Border.all(
                    color: mycolor,
                    width: 0.75
                ),
                borderRadius: BorderRadius.circular(5)
            ),

            alignment: Alignment.center,
            child:BuildWhiteMuiliTextBold(txt: "Change Password", fontsize: 0.0185)
      ),
      ),
    ),
    Expanded(
      child: InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(ChangeEmail.routename).then((value) {
            setState(() {

            });
        });
      },
      child: Container(
            height: height*0.049,

            margin: EdgeInsets.only(left: width*0.025),

            decoration: BoxDecoration(
                color: Color(0xff2A2A2A),
                border: Border.all(
                    color: mycolor,
                    width: 0.75
                ),
                borderRadius: BorderRadius.circular(5)
            ),

            alignment: Alignment.center,
            child:BuildWhiteMuiliTextBold(txt: "Change Email", fontsize: 0.0185)
      ),
      ),
    ),
  ],
),
          ),
          SizedBox(height: height*0.025,),
          Container(
              margin: EdgeInsets.only(left: width*0.08,right: width*0.08),
              width: width*0.42,

              decoration: BoxDecoration(
                  color: Color(0xff2A2A2A),
                  border: Border.all(
                      color: mycolor,
                      width: 0.75
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
              alignment: Alignment.centerLeft,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.015,),
                  InkWell(

                      onTap: (){
                        Navigator.of(context).pushNamed(ActivateDevice.routename);
                      },
                      child: BuildWhiteMuiliTextBold(txt: "Activate A Device", fontsize: 0.018522)),
                Divider(
                  color: mycolor,
                ),
                  InkWell(
                      onTap: (){
                        _launchURL();
                      },
                      child: BuildWhiteMuiliTextBold(txt: "Billing and Payments", fontsize: 0.018522,start: false)),
                  Divider(
                    color: mycolor,
                  ),
                  InkWell(
                      onTap: ()async{

                     await  launchUrl(Uri.parse("https://saintconnect.info/terms-and-privacy-policy",
                     ),
                         mode: LaunchMode.externalApplication
                     );

                      },
                      child: BuildWhiteMuiliTextBold(txt: "Terms & Conditions", fontsize: 0.018522)),
                  Divider(
                    color: mycolor,
                  ),


                  InkWell(
                      onTap: ()async{
                        await  launchUrl(Uri.parse("https://saintconnect.info",
                        ),
                            mode: LaunchMode.externalApplication
                        );

                      },
                      child: BuildWhiteMuiliTextBold(txt: "Visit Saint Connect", fontsize: 0.018522)),

                  Divider(
                    color: mycolor,
                  ),

                  InkWell(
                      onTap: ()async{


                        await  launchUrl(Uri.parse("https://saintconnect.info/our-products-saint-connect",
                        ),
                            mode: LaunchMode.externalApplication
                        );
                      },
                      child: BuildWhiteMuiliTextBold(txt: "Visit the Shop", fontsize: 0.018522)),

                  Divider(
                    color: mycolor,
                  ),
                  InkWell(
                      onTap: ()async{
                        await  launchUrl(Uri.parse("https://www.saintfinancialgroup.co.uk/saintfg-solutions",
                        ),
                            mode: LaunchMode.externalApplication
                        );
                      },
                      child: BuildWhiteMuiliTextBold(txt: "More from Saint?", fontsize: 0.018522)),

                  SizedBox(height: height*0.025,),
                ],
              )
          ),

          SizedBox(height: height*0.025,),
          InkWell(
            onTap: ()async{


              await  launchUrl(Uri.parse("https://saintconnect.info/faq-saint-connect",
              ),
                  mode: LaunchMode.externalApplication
              );
            },
            child: Container(
                margin: EdgeInsets.only(left: width*0.08,right: width*0.08),
                height: height*0.16,
                width: width*0.42,

                decoration: BoxDecoration(
                    color: Color(0xff2A2A2A),
                    border: Border.all(
                        color: mycolor,
                        width: 0.75
                    ),
                    borderRadius: BorderRadius.circular(5)
                ),
                padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                alignment: Alignment.centerLeft,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height*0.015,),
                    BuildWhiteMuiliTextBold(txt: "Frequently Asked Questions (FAQ)", fontsize: 0.0185),
                    Divider(
                      color: mycolor,
                    ),
                    InkWell(
                        onTap: ()async{

                          await  launchUrl(Uri.parse("https://saintconnect.info/contact",
                          ),
                              mode: LaunchMode.externalApplication
                          );
                        },
                        child : BuildWhiteMuiliTextBold(txt: "Need support?", fontsize: 0.0185)),
                    Divider(
                      color: mycolor,
                    ),
                    InkWell(
                        onTap: ()async{

                          await  launchUrl(Uri.parse("https://play.google.com/store",
                          ),
                              mode: LaunchMode.externalApplication
                          );
                        },
                        child : BuildWhiteMuiliTextBold(txt: "Review Us", fontsize: 0.0185)),

                  ],
                )
            ),
          ),
          SizedBox(height: height*0.025,),

          Container(
              height: height*0.135,
              width: width*0.42,
              margin: EdgeInsets.only(left: width*0.08,right: width*0.08),
              decoration: BoxDecoration(
                  color: Color(0xff2A2A2A),
                  border: Border.all(
                      color: mycolor,
                      width: 0.75
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
              alignment: Alignment.centerLeft,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  BuildWhiteMuiliTextBold(txt: "Visit Our Socials", fontsize: 0.01852),
                  SizedBox(height: height*0.015,),
                 Row(

                   mainAxisAlignment: MainAxisAlignment.center,

                   children: List.generate(social.length, (index) => InkWell(
                     onTap: () async {
                       if(index==0){

                         await  launchUrl(Uri.parse("https://www.facebook.com/SaintConnect",
                         ),
                             mode: LaunchMode.externalApplication
                         );
                       }
                      else  if(index==1){

                         await  launchUrl(Uri.parse("https://www.instagram.com/saintconnectofficial/",
                         ),
                             mode: LaunchMode.externalApplication
                         );
                       }
                       else if(index==2){

                         await  launchUrl(Uri.parse("https://www.youtube.com/channel/UCo1y4qvonumEd8RksGLpO4w",
                         ),
                             mode: LaunchMode.externalApplication
                         );
                       }
                       else                          if(index==3){

                         await  launchUrl(Uri.parse("https://twitter.com/saint_connect",
                         ),
                             mode: LaunchMode.externalApplication
                         );
                       }
                       else                          if(index==4){

                         await  launchUrl(Uri.parse("https://www.linkedin.com/company/69531810/",
                         ),
                             mode: LaunchMode.externalApplication
                         );
                       }
                       else                          if(index==5){

                         await  launchUrl(Uri.parse("https://www.tiktok.com/@saintconnect",
                         ),
                             mode: LaunchMode.externalApplication
                         );
                       }
                       else{

                       }
                     },
                     child: Container(
                     margin: EdgeInsets.only(left: width*0.025),
                       child:  Image.network(social[index],height: height*0.035,color: mycolor,fit: BoxFit.cover,)
                     ),
                   )),
                 )

                ],
              )
          ),

          SizedBox(height: height*0.025,),


          Container(
              margin: EdgeInsets.only(left: width*0.08,right: width*0.08),
              height: height*0.07,
              width: width*0.42,
              decoration: BoxDecoration(
                  color: Color(0xff2A2A2A),
                  border: Border.all(
                      color: mycolor,
                      width: 0.75
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.only(left: width*0.05),
              alignment: Alignment.centerLeft,
              child:BuildWhiteMuiliTextBold(txt: "Become a partner (Referral Scheme)", fontsize: 0.01852,
              start: true,
              )
          ),

          SizedBox(height: height*0.025,),
          InkWell(
            onTap: ()async{
           _show_logout();
            },
            child: Container(
                height: height*0.07,
                width: width*0.42,
                margin: EdgeInsets.only(left: width*0.08,right: width*0.08),
                decoration: BoxDecoration(
                    color: Color(0xff2A2A2A),
                    border: Border.all(
                        color: mycolor,
                        width: 0.75
                    ),
                    borderRadius: BorderRadius.circular(5)
                ),
                padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                alignment: Alignment.centerLeft,
                child:BuildWhiteMuiliTextBold(txt: "Logout", fontsize: 0.01852)
            ),
          ),


          SizedBox(height: height*0.025,),
          Container(
              height: height*0.07,
              width: width*0.42,
              margin: EdgeInsets.only(left: width*0.08,right: width*0.08),
              decoration: BoxDecoration(
                  color: Color(0xff2A2A2A),
                  border: Border.all(
                      color: mycolor,
                      width: 0.75
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
              alignment: Alignment.centerLeft,
              child:BuildWhiteMuiliTextBold(txt: "Delete Account", fontsize: 0.01852)
          ),


          SizedBox(height: height*0.1,),
        ],
      ),
    );
  }
}
