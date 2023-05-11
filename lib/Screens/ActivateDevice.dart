import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:saintconnect/Database/database.dart';
import 'package:saintconnect/Database/profile.dart';
import 'package:saintconnect/Screens/MyCard_1.dart';
import 'package:saintconnect/Screens/PurchaseNewDevice.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/cards.dart';
import 'package:saintconnect/widgets/bottomnavigattionbar.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class ActivateDevice extends StatefulWidget {
 static const routename="ActivateDevice";

  @override
  State<ActivateDevice> createState() => _ActivateDeviceState();
}

class _ActivateDeviceState extends State<ActivateDevice> {
  @override
  void initState() {
    // TODO: implement initState
    current_index=1;
    super.initState();
  }
  bool isScroll=true;
List data=[
  {

    'title':'Metal Saint Connect Card',
    'subtitle':'Connected to John Wallhicks profile'
  },
  {

    'title':'Custom PVC Card',
    'subtitle':'Not connected'
  },
];
  CarouselController controller = CarouselController();
  int _active_index=0;
  CarouselSlider ? carouselSlider;

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff111111),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Home_Bottom_Navigation_BAr(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height*0.025,),
            Container(
              height: height*0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image.asset("images/logo.png",height: height*0.045,fit: BoxFit.fill,),

                  SizedBox(width: width*0.025,),

                  BuildItalicText(txt: "Connect", fontsize: 0.035),

                ],
              ),
            ),
            SizedBox(height: height*0.025,),
            FutureBuilder(
                future: database.fetch_all_cards(),
                builder: (context,AsyncSnapshot<List<MyCard?>> snapshot){

                  return snapshot.connectionState==ConnectionState?

                  SpinKitRing(color: Colors.white):

                  snapshot.hasData && snapshot.data!.length>0?

              Column(
                children: List.generate(snapshot.data!.length, (index) =>     BuildCustomCard(context,snapshot.data![index]!)),
              )
                 //  Container(
                 //    height: height*0.64,
                 //
                 //    child: Row(
                 //      mainAxisAlignment: MainAxisAlignment.start,
                 //      crossAxisAlignment: CrossAxisAlignment.start,
                 //
                 //      children: [
                 //
                 //
                 //        Expanded(
                 //          child: Container(
                 //            height:
                 //            snapshot.data!.length==1?
                 //    height*(0.55)
                 //                :
                 //            height*(0.64),
                 //
                 //
                 //            child: CarouselSlider(
                 //              carouselController: controller,
                 //              options: CarouselOptions(
                 //
                 //    disableCenter: true,
                 //    padEnds: false,
                 //    enlargeCenterPage: false,
                 //    enableInfiniteScroll: false,
                 //    reverse: false,
                 //
                 //    onScrolled: (value){
                 //         print("value is "+value.toString());
                 //    },
                 //    onPageChanged: (index,reason){
                 //      int target_index=snapshot.data!.length-3;
                 //
                 //
                 //      setState(() {
                 //        _active_index=index;
                 // if(index>=target_index){
                 //     isScroll=false;
                 // }
                 //      });
                 //    },
                 //    scrollDirection: Axis.vertical,
                 //                viewportFraction:
                 //
                 //                snapshot.data!.length==1?
                 //                0.7
                 //                    :
                 //                0.6
                 //    ),
                 //
                 //              items: snapshot.data!.map((index) {
                 //                return
                 //                  BuildCustomCard(context,index!);
                 //              }).toList(),
                 //            ),
                 //          ),
                 //        ),
                 //        Container(
                 //
                 //          margin: EdgeInsets.only(right: width*0.025,top: height*0.05),
                 //          child: Center(
                 //            child: AnimatedSmoothIndicator(
                 //              axisDirection: Axis.vertical,
                 //              count: snapshot.data!.length,
                 //              effect: SlideEffect(
                 //                  spacing: 12.0,
                 //                  radius: 4.0,
                 //                  dotWidth: 30.0,
                 //                  dotHeight: 3.0,
                 //                  paintStyle: PaintingStyle.fill,
                 //                  strokeWidth: 1.5,
                 //                  dotColor: Color(0xffA49D9D),
                 //                  activeDotColor: mycolor),
                 //              onDotClicked: (index) => controller.animateToPage(index,
                 //                  duration: Duration(milliseconds: 500), curve: Curves.bounceOut), activeIndex: _active_index,
                 //            ),
                 //          ),
                 //        ),
                 //      ],
                 //    ),
                 //  )
                      :
                  Container(
                    height: height*0.55,
                    child: Column(
                      children: [
                        Center(
                          child: Container(

                              width: width*1,

                              height: height*0.4,

                              padding: EdgeInsets.only(left: width*0.025,right: width*0.025,top: height*0.01,bottom: height*0.01),

                              margin: EdgeInsets.only(left: width*0.1,right: width*0.1,),

                              child: SvgPicture.asset("icons/nocard.svg",color: mycolor,)

                          ),
                        ),

                        Container(
                         margin: EdgeInsets.only(left: width*0.1,right: width*0.1,top: height*0.025),
                          child:
                  Text("You currently don't have your profile connected to a Saint Connect Card, get started by pressing the button below!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Muli-Regular',
                  fontSize: height*( 0.018),

                  ),
                  )

                        ),
                      ],
                    ),
                  );
                }),



            SizedBox(height: height*0.05,),
            InkWell(
                onTap: ()async{
                  // final url = Uri.parse('https://qrcode-monkey.p.rapidapi.com/qr/custom');
                  // final headers = {
                  //   'content-type': 'application/json',
                  //   'X-RapidAPI-Key': 'dcb12462ecmsh85695a37047c7f3p1b8d0ejsn592c9d3f0746',
                  //   'X-RapidAPI-Host': 'qrcode-monkey.p.rapidapi.com',
                  //   'useQueryString': 'true',
                  // };
                  // final body = jsonEncode({
                  //   'data': 'https://www.qrcode-monkey.com',
                  //   'config': {
                  //     'body': 'rounded-pointed',
                  //     'eye': 'frame14',
                  //     'eyeBall': 'ball16',
                  //     'erf1': [],
                  //     'erf2': ['fh'],
                  //     'erf3': ['fv'],
                  //     'brf1': [],
                  //     'brf2': ['fh'],
                  //     'brf3': ['fv'],
                  //     'bodyColor': '#5C8B29',
                  //     'bgColor': '#FFFFFF',
                  //     'eye1Color': '#3F6B2B',
                  //     'eye2Color': '#3F6B2B',
                  //     'eye3Color': '#3F6B2B',
                  //     'eyeBall1Color': '#60A541',
                  //     'eyeBall2Color': '#60A541',
                  //     'eyeBall3Color': '#60A541',
                  //     'gradientColor1': '#5C8B29',
                  //     'gradientColor2': '#25492F',
                  //     'gradientType': 'radial',
                  //     'gradientOnEyes': false,
                  //     'logo': '',
                  //   },
                  //   'size': 300,
                  //   'download': false,
                  //   'file': 'png',
                  // });
                  //
                  // final response = await http.post(url, headers: headers, body: body);
                  // print("behenchod reponse is "+response.body);
                    Navigator.of(context).pushNamed(PurchaseNewDevice.routename).then((value) {
setState(() {

});
                    });

                },
                child: BuildButton(text: "Activate a New Device",fontsize: 0.0253,)),
            SizedBox(height: height*0.2,),

          ],
        ),
      ),
    );
  }
  String ? _show_delete ( String docid )
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Delete Card'),
          content: Text("Are you sure you want to remove this card?"),
          actions: <Widget>[

            Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                child: Text('Yes',style: TextStyle(color: Colors.white)),
                onPressed: () async {

                  await profileDatabase.delete_card(docid: docid).then((value) {
                    setState(() {

                    });
                    Navigator.of(context).pop();
                  });

                },
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
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

Widget BuildCustomCard(BuildContext context,MyCard myCard){
  final height=MediaQuery.of(context).size.height;
  final width=MediaQuery.of(context).size.width;
    return Container(
height: height*0.4,
      width: width*1,
      decoration: BoxDecoration(
         color: Color(0xff2A2A2A)

      ),
      padding: EdgeInsets.only(top: width*0.075,bottom: width*0.06),
      margin: EdgeInsets.only(left: width*0.075,right: width*0.075,bottom: height*0.025),
child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    AspectRatio(
      aspectRatio: 19/11,
      child: Container(
        // height: height*0.18,
        // width: width*1,
alignment: Alignment.center,
        child: Stack(
          children: [
            (myCard.card_type=="White Connect Card" )?

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
            myCard.card_type=="Black Connect Card"?
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
                      color: bgcolor,
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xffDAC07A),
                            blurRadius: 10
                        )
                      ],

                    ),

                    child:


                    AspectRatio(
                      aspectRatio: 17/11,
                      child: Image.network(myCard.card_image!,fit: BoxFit.cover,),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCard_1(myCard))).then((value) {
                            setState(() {

                            });
                          });
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: mycolor,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Color(0xff2A2A2A),
                            child: Icon(Icons.edit,color: mycolor,size:11),
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

Container(
  decoration: BoxDecoration(

  ),
  child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          margin: EdgeInsets.only(left: width*0.075,right: width*0.025,),
          alignment: Alignment.centerLeft,
          child: BuildWhiteMuiliTextBold_shadow(txt:

          (myCard.card_type=="White Connect Card" )?
          "Metal Saint Connect Card":
          (myCard.card_type=="Custom PVC Card" )?
          "Custom PVC Card"
              :
          "Metal Saint Connect Card", fontsize: 0.02)),
      Container(

          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: width*0.075,right: width*0.025),
          child: BuildWhiteMuiliTextBold_shadow_more(txt:  "Connected to "+myCard.connected_profile_username.toString(), fontsize: 0.01475)),

    ],
  ),
)

  ],
),
    );
}
  // Widget BuildCustomCard(BuildContext context,MyCard myCard){
  //   final height=MediaQuery.of(context).size.height;
  //   final width=MediaQuery.of(context).size.width;
  //   return Container(
  //     height: height*0.3,
  //     width: width*1,
  //     decoration: BoxDecoration(
  //         color: Color(0xff2A2A2A)
  //
  //     ),
  //     padding: EdgeInsets.only(top: width*0.075,bottom: width*0.06),
  //     margin: EdgeInsets.only(left: width*0.075,right: width*0.075,bottom: height*0.025),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         AspectRatio(
  //           aspectRatio: 19/11,
  //           child: Container(
  //             // height: height*0.18,
  //             // width: width*1,
  //             alignment: Alignment.center,
  //             child: Stack(
  //               children: [
  //                 (myCard.card_type=="White Connect Card" )?
  //
  //                 Container(
  //                   margin: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.0075,bottom: height*0.01),
  //                   child: AspectRatio(
  //                     aspectRatio: 17/11,
  //                     child: Center(
  //                       child: Container(
  //                         // height: height*0.16,
  //                         // width: width*1,
  //                         decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           boxShadow: [
  //                             BoxShadow(
  //                                 color: Color(0xffDAC07A),
  //                                 blurRadius: 10
  //                             )
  //                           ],
  //
  //                         ),
  //
  //                         padding: EdgeInsets.only(left: height*0.015),
  //                         child:
  //
  //
  //                         Container(
  //
  //                           alignment: Alignment.centerLeft,
  //
  //                           child: RotatedBox (
  //                               quarterTurns: 1,
  //                               child: BuildItalicText(txt: "Connect",fontsize: 0.025)),
  //                         )
  //                         ,
  //                       ),
  //                     ),
  //                   ),
  //                 ):
  //                 myCard.card_type=="Black Connect Card"?
  //                 Container(
  //                   margin: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.0075,bottom: height*0.01),
  //                   child: AspectRatio(
  //                     aspectRatio: 17/11,
  //                     child: Center(
  //                       child: Container(
  //                         // height: height*0.16,
  //                         // width: width*1,
  //                         decoration: BoxDecoration(
  //                           color: Colors.black,
  //                           boxShadow: [
  //                             BoxShadow(
  //                                 color: Color(0xffDAC07A),
  //                                 blurRadius: 10
  //                             )
  //                           ],
  //
  //                         ),
  //
  //                         padding: EdgeInsets.only(left: height*0.015),
  //                         child:
  //
  //
  //                         Container(
  //
  //                           alignment: Alignment.centerLeft,
  //
  //                           child: RotatedBox (
  //                               quarterTurns: 1,
  //                               child: BuildItalicText(txt: "Connect",fontsize: 0.025)),
  //                         )
  //                         ,
  //                       ),
  //                     ),
  //                   ),
  //                 ):
  //                 Container(
  //                   margin: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.0075,bottom: height*0.01),
  //                   child: AspectRatio(
  //                     aspectRatio: 17/11,
  //                     child: Center(
  //                       child: Container(
  //                         // height: height*0.16,
  //                         // width: width*1,
  //                         decoration: BoxDecoration(
  //                           color: bgcolor,
  //                           boxShadow: [
  //                             BoxShadow(
  //                                 color: Color(0xffDAC07A),
  //                                 blurRadius: 10
  //                             )
  //                           ],
  //
  //                         ),
  //
  //                         child:
  //
  //
  //                         AspectRatio(
  //                           aspectRatio: 17/11,
  //                           child: Image.network(myCard.card_image!,fit: BoxFit.cover,),
  //                         )
  //                         ,
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //                 ,
  //
  //
  //                 AspectRatio(
  //                   aspectRatio: 17/11,
  //                   child: Container(
  //
  //                     child: Stack  (
  //                       children: [
  //                         Positioned(
  //                           right: width*0.0,
  //                           bottom: height*0.0,
  //                           child: InkWell(
  //                             onTap: (){
  //                               Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCard_1(myCard))).then((value) {
  //                                 setState(() {
  //
  //                                 });
  //                               });
  //                             },
  //                             child: CircleAvatar(
  //                               radius: 15,
  //                               backgroundColor: mycolor,
  //                               child: CircleAvatar(
  //                                 radius: 14,
  //                                 backgroundColor: Color(0xff2A2A2A),
  //                                 child: Icon(Icons.edit,color: mycolor,size:11),
  //                               ),
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //
  //               ],
  //             ),
  //           ),
  //         ),
  //
  //         Container(
  //           decoration: BoxDecoration(
  //
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                   margin: EdgeInsets.only(left: width*0.075,right: width*0.025,),
  //                   alignment: Alignment.centerLeft,
  //                   child: BuildWhiteMuiliTextBold_shadow(txt:
  //
  //                   (myCard.card_type=="White Connect Card" )?
  //                   "Metal Saint Connect Card":
  //                   (myCard.card_type=="Custom PVC Card" )?
  //                   "Custom PVC Card"
  //                       :
  //                   "Metal Saint Connect Card", fontsize: 0.02)),
  //               Container(
  //
  //                   alignment: Alignment.centerLeft,
  //                   margin: EdgeInsets.only(left: width*0.075,right: width*0.025),
  //                   child: BuildWhiteMuiliTextBold_shadow_more(txt:  "Connected to "+myCard.connected_profile_username.toString(), fontsize: 0.01475)),
  //
  //             ],
  //           ),
  //         )
  //
  //       ],
  //     ),
  //   );
  // }
}
