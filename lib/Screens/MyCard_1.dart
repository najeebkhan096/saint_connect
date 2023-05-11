import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:saintconnect/Database/database.dart';
import 'package:saintconnect/Database/profile.dart';
import 'package:saintconnect/Screens/Insight.dart';
import 'package:saintconnect/Screens/MyCardStage3.dart';
import 'package:saintconnect/Screens/webview.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/MyProfile.dart';
import 'package:saintconnect/module/cards.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/widgets/bottomnavigattionbar.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:saintconnect/Screens/update_nfc.dart';




class MyCard_1 extends StatefulWidget {
  static const routename="MyCard_1";
  final MyCard ? current_card;
  MyCard_1(this.current_card);

  @override
  State<MyCard_1> createState() => _MyCard_1State();
}

class _MyCard_1State extends State<MyCard_1> {


  String ? selected_categ;
bool viewanalytics=false;
  @override
  void initState() {
    // TODO: implement initState
    //  selected_categ=widget.current_card!.connected_profile_username;
    //  print("jhund"+selected_categ.toString());
    super.initState();
  }
  String ? _show_delete ( String docid )
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Color(0xff111111),
          title: BuildItalicText(txt: "Delete Card", fontsize: 0.025),
          content:
          BuildItalicTextwhite(txt: "Are you sure you want to remove this card?", fontsize: 0.018),

          actions: <Widget>[

            Container(
              decoration: BoxDecoration(
                  color: Color(0xffDAC07A),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                child: Text('Yes',style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  await profileDatabase.delete_card(docid: docid).then((value) {
                    setState(() {

                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
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
    // current_card=ModalRoute.of(context)!.settings.arguments as MyCard;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: bgcolor,
        leading:  InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: width*0.065,right: width*0.075),
            child: IconButton(onPressed: (){
              Navigator.of(context).pop();
            }, icon: Icon(Icons.arrow_back,color: Colors.white,size: width*0.075,)),
          ),
        ),
        title:    Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: width*0.125,),
            Image.asset("images/logo.png",height: height*0.05,),
            SizedBox(width: width*0.025,),
            BuildItalicText(txt: "Connect", fontsize: 0.0358),

          ],
        ),
      ),

      backgroundColor: bgcolor,
      body:

      ListView(

        children: [

      SizedBox(height: height*0.05,),
          Container(
            margin: EdgeInsets.only(left: width*0.025, right: width*0.025),
            child: AspectRatio(
              aspectRatio: 19/11,
              child: Container(
                // height: height*0.18,
                // width: width*1,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    (widget.current_card!.card_type=="White Connect Card" )?

                    Container(
                      margin: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.0075,bottom: height*0.01),
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
                    widget.current_card!.card_type=="Black Connect Card"?
                    Container(
                      margin: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.0075,bottom: height*0.01),
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
                      margin: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.0075,bottom: height*0.01),
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


                            AspectRatio(
                              aspectRatio: 17/11,
                              child: Image.network(widget.current_card!.card_image!,fit: BoxFit.cover,),
                            )
                            ,
                          ),
                        ),
                      ),
                    )
                    ,


                    AspectRatio(
                      aspectRatio: 17/11,
                      child: Container(

                        child: Stack  (
                          children: [
                            Positioned(
                              right: width*0.0,
                              bottom: height*0.0,
                              child: InkWell(
                                onTap: (){
                                  _show_delete(widget.current_card!.docid!);
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: mycolor,
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Color(0xff2A2A2A),
                                    child: Icon(Icons.delete,color: mycolor,size:11),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

          Container(
              margin: EdgeInsets.only(left: width*0.1),
              alignment: Alignment.centerLeft,
              child: BuildWhiteMuiliTextBold(txt:

              (widget.current_card!.card_type=="White Connect Card" )?
              "Metal Saint Connect Card":
              (widget.current_card!.card_type=="Custom PVC Card" )?
              "Custom PVC Card"
                  :
              "Metal Saint Connect Card", fontsize: 0.02)),

          SizedBox(height: height*0.025,),


          Container(
              margin: EdgeInsets.only(left: width*0.1),
              child: BuildWhiteMuiliText(txt: "Connected to", fontsize: 0.01475)),

          SizedBox(height: height*0.015,),

          FutureBuilder(
              future: database.fetch_profiles_by_desired_id(id: currentuser!.uid!),
              builder: (context,AsyncSnapshot<List<MyProfile?>>snapshot){
                return snapshot.connectionState==ConnectionState.waiting?
                SpinKitRing(color: Colors.white,):
                (snapshot.hasData && snapshot.data!.length>0)?
                Container(
                    margin: EdgeInsets.only(left: width*0.1, right: width*0.1),
                    height: 37,
                    width: width*1,
                    padding:  EdgeInsets.only(left: width*0.025, right: width*0.05),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.centerLeft,
                    //  BuildMuliGrey(txt: current_card!.connected_profile_username!, fontsize: 0.02),
                    child:
                    DropdownButton<String>(

                      hint: BuildMuliGrey(txt: widget.current_card!.connected_profile_username!, fontsize: 0.02),
                      value: selected_categ,
                      onChanged: (value) async {

                          MyProfile ? desired=snapshot.data!.firstWhere((element) => element!.your_details!.name ==value.toString());
print("lala "+desired!.your_details!.name.toString());

                          Navigator.of(context).pushNamed(
                              update_NFC.routename,
                              arguments: [widget.current_card,desired.profile_image,desired,widget.current_card!.docid!]
                          );
             // await  database.update_card(docid: widget.current_card!.docid!,connected_profile_username: desired.your_details!.name ,connected_profile_uid: desired.docid).then((value) {
             //
             // });
                        setState(() {
                          selected_categ = desired.your_details!.name;
                        });

                      },
                      underline: Text(""),
                      icon:  Image.asset("images/dropdown.png",height: height*0.017,),
                      isExpanded: true,

                      items:snapshot.data!.map(
                              (e) => DropdownMenuItem(value: e!.your_details!.name!, child: Text(e.your_details!.name .toString())))
                          .toList(),
                    )

                )
                    :Text("No data");
              }),

          SizedBox(height: height*0.05,),
          InkWell(
              onTap: ()async{
                setState(() {
                  viewanalytics=true;
                });
                try{
                  print(widget.current_card!.connected_profile_uid.toString());
                  await database.fetch_profile_by_docid(
                      id: widget.current_card!.connected_profile_uid.toString()
                  ).then((desiredprofile) {

                    Navigator.of(context).pushNamed(Insights.routename,arguments: desiredprofile);
                  });
                }catch(error){
                  setState(() {
                    viewanalytics=true;
                  });
                }


                },
              child: BuildButton(text: "View Analytics",fontsize: 0.0253)),
          SizedBox(height: height*0.025,),
          InkWell(
              onTap: ()async{
                await  launchUrl(Uri.parse("https://saintconnect.info/our-products-saint-connect",
                ),
                    mode: LaunchMode.externalApplication
                );

              },
              child: BuildButton(text: "Buy Another",fontsize: 0.0253)),


        ],
      ),
      bottomNavigationBar: Home_Bottom_Navigation_BAr(),
    );

  }

  Widget BuildCustomCard(BuildContext context){
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Container(
      height: height*0.3,
      width: width*1,
      decoration: BoxDecoration(
          color: Color(0xff2A2A2A)
      ),
      margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height*0.22,
            width: width*1,

            child: Stack(
              children: [


                Positioned(
                  right: width*0.04,
                  bottom: height*0.01,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: mycolor,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xff2A2A2A),
                      child: Icon(Icons.edit,color: mycolor,size:11),
                    ),
                  ),
                )
              ],
            ),
          ),

          BuildWhiteText(txt: "Metal Saint Connect Card", fontsize: 0.025),
          BuildWhiteText(txt: "Connected to John Wallhicks profile", fontsize: 0.015)

        ],
      ),
    );
  }
}
