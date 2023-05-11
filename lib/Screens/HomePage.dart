import 'package:flutter/material.dart';
import 'package:saintconnect/Database/database.dart';
import 'package:saintconnect/Screens/ActivateDevice.dart';
import 'package:saintconnect/Screens/Insight.dart';
import 'package:saintconnect/Screens/MyCard_1.dart';
import 'package:saintconnect/Screens/MyTeam.dart';
import 'package:saintconnect/Screens/QrCode.dart';
import 'package:saintconnect/Screens/webview.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/MyProfile.dart';
import 'package:saintconnect/module/cards.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/widgets/bottomnavigattionbar.dart';
import 'package:saintconnect/widgets/buildTeam.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const routename="HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    current_index=0;
    super.initState();
  }

  bool gotdata=false;
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  if(gotdata==false){

    currentuser_MyProfile=await database.fetch_profile_userid(id: currentuser!.uid!);


  }
    gotdata=true;
  }
  List<BuildTeam> quickaccess=[
    BuildTeam(
      path: "icons/view_team.svg",
      title: "View Your Team",
      subtitle: "Have an overview of your team, manage their profiles and update information",
    ),
    BuildTeam(
      path: "icons/view_card.png",
      title: "View Your Card",
      subtitle: "See all of your cards and who they are assigned to",
    ),
    BuildTeam(
      path: "icons/insight.svg",
      title: "Insight & Performance",
      subtitle: "See the latest stats from your team",
    ),
    BuildTeam(
      path: "icons/faqs.svg",
      title: "FAQs",
      subtitle: "Visit the FAQs to see what people are asking",
    ),
    BuildTeam(
      path: "icons/activate_device.svg",
      title: "Activate a Device",
      subtitle: "Looking to activate a new product?",
    ),
    BuildTeam(
      path: "icons/view_shop.svg",
      title: "Visit the Shop",
      subtitle: "Take a look through Saint Connect shop for more Saint Connect Devices.",
    ),
    BuildTeam(
      path: "icons/visit_saint_connect.svg",
      title: "Visit Saint Connect",
      subtitle: "Visit the Saint Connect website to see latest.",
    ),
    BuildTeam(
      path: "icons/resourcehub.svg",
      title: "Resource Hub",
      subtitle: "Visit the Saint Connect Resource Hub for free access to articles and resources.",
    ),
  ];


double percentage=0.3;
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgcolor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Home_Bottom_Navigation_BAr(),

      body: ListView(

        children: [

          SizedBox(height: height*0.025,),

          Row(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Image.asset("images/logo.png",height: height*0.045,fit: BoxFit.fill,),

              SizedBox(width: width*0.025,),

              BuildItalicText(txt: "Connect", fontsize: 0.035),

            ],
          ),
          // SizedBox(height: height*0.025,),
          //
          // Container(
          //   margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
          //   decoration: BoxDecoration(
          //     color: Color(0xff2A2A2A),
          //     border: Border.all(color: Color(0xffDAC07A))
          //   ),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       SizedBox(height: height*0.025,),
          //       Container(
          //           margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
          //           child: BuildItalicText(txt: "Saint Connect",fontsize: 0.035,)),
          //       SizedBox(height: height*0.025,),
          //       Container(
          //           margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
          //           child: BuildWhiteMuiliText(txt: "The only business card you need! Welcome to Saint.Connect. Build online digital profiles for you and your team, all simply managed within this app.\n\nTake it a step further with a physical NFC devicewhich can simply tap your digital profile across.Sending over your details, promotional content andmore,", fontsize:0.017 )),
          //       SizedBox(height: height*0.025,),
          //
          //
          //     ],
          //   ),
          // ),
          SizedBox(height: height*0.025,),

          Container(
              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
              child: BuildItalicText(txt: "Quick Access", fontsize: 0.0358)),
          SizedBox(height: height*0.02,),


          Container(
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
            child: LinearProgressIndicator(
              value: 0.15,
              backgroundColor: bgcolor,
              color: mycolor,
              minHeight: height*0.00252,
            ),
          ),

          SizedBox(height: height*0.025,),
          Column(
            children: List.generate(quickaccess.length, (index) => InkWell(
              onTap: () async {
                if(index==0){
                  Navigator.of(context).pushNamed(MyTeam.routename);
                }
               else if(index==1){
                  Navigator.of(context).pushNamed(QrCode.routename);
                }
                else if(index==2){
                  Navigator.of(context).pushNamed(Insights.routename);
                }
                else if(index==3){


                await  launchUrl(Uri.parse("https://saintconnect.info/faq-saint-connect",
                ),
                    mode: LaunchMode.externalApplication
                );
                }
                else if(index==4){
                  Navigator.of(context).pushNamed(ActivateDevice.routename);
                }
                else if(index==5){

                  await  launchUrl(Uri.parse("https://saintconnect.info/our-products-saint-connect",
                  ),
                      mode: LaunchMode.externalApplication
                  );
                } else if(index==6){

                  await  launchUrl(Uri.parse("https://saintconnect.info",
                  ),
                      mode: LaunchMode.externalApplication
                  );
                } else if(index==7){

                  await  launchUrl(Uri.parse("https://saintconnect.info/resources-saint-connect",
                  ),
                      mode: LaunchMode.externalApplication
                  );

               }},
              child: BuildTeam(
              path:quickaccess[index].path,
                title: quickaccess[index].title,
                subtitle: quickaccess[index].subtitle
              ),
            ),
            ),
          ),
          SizedBox(height: height*0.25,),
        ],
      ),
    );


  }


}
