import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:saintconnect/Charts/barchart_module.dart';
import 'package:saintconnect/Charts/sfchart.dart';
import 'package:saintconnect/Database/database.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/MyProfile.dart';
import 'package:saintconnect/module/analytic.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/module/view.dart';
import 'package:saintconnect/module/view.dart';
import 'package:saintconnect/module/view.dart';
import 'package:saintconnect/module/view.dart';
import 'package:saintconnect/widgets/bottomnavigattionbar.dart';
import 'package:saintconnect/widgets/buildpacage.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class Insights extends StatefulWidget {
  static const routename = "Insights";

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  @override
  void initState() {
    // TODO: implement initState
    current_index = 3;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  DateTimeRange? daterange = DateTimeRange(
      start: DateTime.now().subtract(Duration(days: 30)), end: DateTime.now());
  String get_range_date() {
    return daterange!.start.day.toString() +
        "/" +
        daterange!.start.month.toString() +
        "-" +
        daterange!.end.day.toString() +
        "/" +
        daterange!.end.month.toString();
  }

  Future pickdate(BuildContext context) async {
    DateTimeRange? new_date_range = await showDateRangePicker(
        context: context,
        initialDateRange: daterange,
        firstDate: daterange!.start,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              primaryColor: bgcolor,
              colorScheme: ColorScheme.light(
                primary: mycolor, // <-- SEE HERE
                onPrimary: bgcolor, // <-- SEE HERE
                onSurface: mycolor, // <
                background: bgcolor, // -- SEE HERE
              ),
              backgroundColor: bgcolor,
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: bgcolor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        lastDate: DateTime.now());
    if (new_date_range == null) return;

    setState(() => daterange = new_date_range);
  }

  bool fetchedonce = false;

  Map<String, double> getdatamap(PopularDevices mydevice) {
print("lannat "+mydevice.mobile.toString());
    Map<String, double> _data = {};

    _data = {
      'DESKTOP':
      mydevice.desktop==null?0:
      mydevice.desktop!.toDouble(),
      'MOBILE':
      mydevice.mobile==null?0:
      mydevice.mobile!.toDouble(),

    };
    return _data;
  }

  String? selected_user = currentuser_MyProfile == null
      ? null
      : currentuser_MyProfile!.your_details!.name;

  int? selected_days;

  List<int> days = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    23,
    25,
    26,
    27,
    28,
    29,
    30
  ];

  DateTime get_StartDate({required int days}) {
    DateTime today = DateTime.now();
    DateTime startdate = today.subtract(Duration(days: days));
    return startdate;
  }

  bool gotdata = false;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (gotdata == false) {

      currentuser_MyProfile=await database.fetch_first_profile_userid(id: currentuser!.uid!);

      desiredprofile = currentuser_MyProfile;

    }
    gotdata = true;
  }

  MyProfile? desiredprofile;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final mydata = ModalRoute.of(context)!.settings.arguments;

    if (mydata != null && fetchedonce == false) {
      desiredprofile = mydata as MyProfile;

      selected_user = desiredprofile!.your_details!.name.toString();

      fetchedonce = true;
    }

    return Scaffold(
        backgroundColor: bgcolor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Home_Bottom_Navigation_BAr(),
        body: FutureBuilder(
            future: database.fetch_profiles_by_desired_id(
                id: mydata == null ? currentuser!.uid! : desiredprofile!.uid!),
            builder: (context, AsyncSnapshot<List<MyProfile>> snapshot) {
              return snapshot.connectionState == ConnectionState
                  ? SpinKitRing(color: mycolor)
                  : !snapshot.hasData
                      ? Center(
                          child: Text(
                            'No profile',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : desiredprofile == null
                          ? Center(
                              child: BuildWhiteMuiliText(
                                  txt:
                                      "No Profile associated with this account",
                                  fontsize: 0.017))
                          : FutureBuilder(
                              future: database.fetch_profileAnalatics(
                                  id: desiredprofile!.docid!,
                              desired_date: daterange
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot<ProfileAnalytic?>
                                      analtcis_snapshot) {
                                return analtcis_snapshot.connectionState ==
                                        ConnectionState
                                    ? SpinKitCircle(
                                        color: Colors.white,
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.075,
                                            right: width * 0.075),
                                        child: ListView(
                                          children: [
                                            SizedBox(
                                              height: height * 0.025,
                                            ),
                                            Container(
                                              height: height * 0.05,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "images/logo.png",
                                                    height: height * 0.05,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.025,
                                                  ),
                                                  BuildItalicText(
                                                      txt: "Connect",
                                                      fontsize: 0.0358),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.05,
                                            ),
                                            BuildItalicText(
                                                txt: "Insights & Performance",
                                                fontsize: 0.0358),
                                            SizedBox(
                                              height: height * 0.025,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [

                                                Expanded(
                                                  child: Container(
                                                      height: height * 0.05,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xff2A2A2A),
                                                          border: Border.all(
                                                              color: mycolor,
                                                              width: 0.75),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.05,
                                                          right: width * 0.025),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            daterange == null
                                                                ? "Select Date"
                                                                : get_range_date(),
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xffABA5A5),
                                                                fontFamily:
                                                                    'ProximaNova-Regular',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    14.51),
                                                          ),
                                                          InkWell(
                                                              onTap: () {
                                                                if (desiredprofile !=
                                                                    null) {
                                                                  pickdate(
                                                                      context);
                                                                }
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .date_range,
                                                                color: mycolor,
                                                              ))
                                                        ],
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: width * 0.025,
                                                ),

                                                Expanded(
                                                  child: Container(
                                                    height: height * 0.05,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff2A2A2A),
                                                        border: Border.all(
                                                            color: mycolor,
                                                            width: 0.75),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    padding: EdgeInsets.only(
                                                        left: width * 0.05,
                                                        right: width * 0.025),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: DropdownButton(
                                                      dropdownColor:
                                                          Color(0xffDAC07A),
                                                      hint: Text(
                                                        "Select Profile",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffABA5A5),
                                                            fontFamily:
                                                                'ProximaNova-Regular',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12.51),
                                                      ),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff5D5D5D),
                                                          fontFamily:
                                                              'Muli-Regular',
                                                          fontSize: 10),
                                                      underline: Text(""),
                                                      value: selected_user,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selected_user =
                                                              (value as String);
                                                          desiredprofile = snapshot
                                                              .data!
                                                              .singleWhere(
                                                                  (element) =>
                                                                      element
                                                                          .your_details!
                                                                          .name ==
                                                                      value);
                                                        });
                                                      },
                                                      icon: Image.asset(
                                                        'images/dropdown.png',
                                                        height: height * 0.0185,
                                                      ),
                                                      isExpanded: true,
                                                      items: snapshot.data!
                                                          .map((e) =>
                                                              DropdownMenuItem(
                                                                  value: e
                                                                      .your_details!
                                                                      .name,
                                                                  child: Text(
                                                                    e.your_details!
                                                                        .name!,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontFamily: 'Muli-Regular',
                                                                        fontSize: height * (0.015),
                                                                        //21 heigt 0.027

                                                                        fontWeight: FontWeight.w700),
                                                                  )))
                                                          .toList(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * 0.025,
                                            ),
                                            if (desiredprofile != null)
                                              analtcis_snapshot.data == null
                                                  ? ProfileView_widget(
                                                      context,
                                                      ProfileAnalytic(
                                                          profileviews: 0))
                                                  : ProfileView_widget(context,
                                                      analtcis_snapshot.data!),
                                            SizedBox(
                                              height: height * 0.025,
                                            ),


                                            analtcis_snapshot.data == null
                                                ? MostEngage(
                                                    context,
                                                    ProfileAnalytic(
                                                        most_engage:
                                                            MostEngaged(
                                                                personaltwitter: 0,
                                                                perosonalinst: 0,
                                                                personalfb: 0)))

                                                : MostEngage(context,
                                                    analtcis_snapshot.data!),

                                            SizedBox(
                                              height: height * 0.025,
                                            ),


                                            analtcis_snapshot.data == null
                                                ? BusinessMostEngage(
                                                context,
                                                ProfileAnalytic(
                                                    most_engage:
                                                    MostEngaged(
                                                        businesstwitter: 0,
                                                        businessinst: 0,
                                                        businessfb: 0)))
                                                : BusinessMostEngage(context,
                                                analtcis_snapshot.data!),

                                            SizedBox(
                                              height: height * 0.025,
                                            ),
                                            Container(
                                                // height: height*0.09,
                                                width: width * 0.42,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff2A2A2A),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                padding: EdgeInsets.only(
                                                    left: width * 0.05,
                                                    right: width * 0.05,
                                                    top: height * 0.025,
                                                    bottom: height * 0.025),
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    BuildWhiteMuiliTextBold(
                                                        txt:
                                                            "Average Time on Your Profile",
                                                        fontsize: 0.024,
                                                        start: true),
                                                    if(analtcis_snapshot.hasData && analtcis_snapshot.data!.averageprofiletime!=null)
                                                    BuildWhiteMuiliText(
                                                        txt: "${analtcis_snapshot.data!.averageprofiletime!.toStringAsFixed(2)} Minutes",
                                                        fontsize: 0.022),
                                                  ],
                                                )),
                                            SizedBox(
                                              height: height * 0.025,
                                            ),
                                            Container(
                                                height: height * 0.275,
                                                width: width * 0.42,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff2A2A2A),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                padding: EdgeInsets.only(
                                                    left: width * 0.05,
                                                    right: width * 0.05,
                                                    top: height * 0.025),
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    BuildWhiteMuiliTextBold(
                                                        txt: "Popular Devices",
                                                        fontsize: 0.025),
                                                    Row(
                                                      children: [
                                                        // Image.asset("images/piechart.png",height: height*0.2),

                                                        if (desiredprofile !=
                                                                null &&
                                                            desiredprofile!
                                                                    .platforms !=
                                                                null
                                                        &&
                                                            analtcis_snapshot.data!=null
                                                        )
                                                          PieChart(
                                                            dataMap: getdatamap(
                                                                analtcis_snapshot.data!.pupolar_devices!),
                                                            legendOptions:
                                                                LegendOptions(
                                                              showLegendsInRow:
                                                                  false,
                                                              legendPosition:
                                                                  LegendPosition
                                                                      .right,
                                                              showLegends: true,
                                                              legendShape:
                                                                  BoxShape
                                                                      .circle,
                                                              legendTextStyle:
                                                                  TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            animationDuration:
                                                                Duration(
                                                                    milliseconds:
                                                                        800),
                                                            chartLegendSpacing:
                                                                13,
                                                            chartRadius:
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    3.2,
                                                            colorList: [
                                                              Colors.green,
                                                              Colors.red,
                                                              Colors.yellow
                                                            ],
                                                            initialAngleInDegree:
                                                                0,
                                                            chartType:
                                                                ChartType.disc,
                                                            ringStrokeWidth: 32,

                                                            chartValuesOptions:
                                                                ChartValuesOptions(
                                                              showChartValueBackground:
                                                                  false,
                                                              showChartValues:
                                                                  false,
                                                              showChartValuesInPercentage:
                                                                  false,
                                                              showChartValuesOutside:
                                                                  false,
                                                              decimalPlaces: 1,
                                                            ),
                                                            // gradientList: ---To add gradient colors---
                                                            // emptyColorGradient: ---Empty Color gradient---
                                                          ),

                                                      ],
                                                    )
                                                  ],
                                                )),
                                            SizedBox(
                                              height: height * 0.2,
                                            ),
                                          ],
                                        ),
                                      );
                              });
            }));
  }

  Widget MostEngage(BuildContext context, ProfileAnalytic analytics) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(color: Color(0xff2A2A2A)),
      padding: EdgeInsets.only(right: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.05),
            child: BuildItalicText(
                txt: "Personal Connection",
                fontsize: 0.022),
          ),

          Container(
              margin: EdgeInsets.only(left: width * 0.05),
              child:
                  BuildWhiteMuiliTextBold(txt: "Most Engaged", fontsize: 0.027)),
          Container(
              margin: EdgeInsets.only(left: width * 0.05),
              child: BuildWhiteMuiliTextBold(
                  txt: daterange == null
                      ? "Last 1 day"
                      : "Last ${daterange!.duration.inDays.toString()} days",
                  fontsize: 0.0145)),
          SizedBox(
            height: height * 0.025,
          ),
          if (desiredprofile != null)
            Column(
              children: List.generate(
                  desiredprofile!.personal_connection!.length,
                  (index) => BuildTile(

                     context:
                      context,
                      title: desiredprofile!.personal_connection![index].title,

                      url: desiredprofile!.personal_connection![index].media!,
                      click: desiredprofile!.personal_connection![index].title ==
                              "Facebook"
                          ? analytics.most_engage!.personalfb.toString()
                          : desiredprofile!.personal_connection![index].title ==
                                  "Instagram"
                              ? analytics.most_engage!.perosonalinst.toString()
                              : desiredprofile!
                                          .personal_connection![index].title ==
                                      "Snapchat"
                                  ? analytics.most_engage!.personalsnapchat .toString()
                                  : desiredprofile!.personal_connection![index]
                                              .title ==
                                          "Twitter"
                                      ? analytics.most_engage!.personaltwitter
                                          .toString()
                                      : desiredprofile!
                                                  .personal_connection![index]
                                                  .title ==
                                              "WhatsApp"
                                          ? analytics.most_engage!.personalwhatsapp.toString()
                                          : desiredprofile!
                                                      .personal_connection![
                                                          index]
                                                      .title ==
                                                  "Spotify"
                                              ? analytics.most_engage!.personalspotify
                                                  .toString()
                                              : desiredprofile!
                                                          .personal_connection![
                                                              index]
                                                          .title ==
                                                      "LinkedIn"
                                                  ? analytics.most_engage!.personallinkedin
                                                      .toString()
                                                  : desiredprofile!
                                                              .personal_connection![
                                                                  index]
                                                              .title ==
                                                          "YouTube"
                                                      ? analytics
                                                          .most_engage!.personaltyoutube
                                                          .toString()
                                                      :  analytics
                          .most_engage!.perosonalcustom
                          .toString())),
            )
        ],
      ),
    );
  }

  Widget BusinessMostEngage(BuildContext context, ProfileAnalytic analytics) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    List data = ['Email', 'Website', 'Facebook', 'Added to Contacts'];
    return Container(
      decoration: BoxDecoration(color: Color(0xff2A2A2A)),
      padding: EdgeInsets.only(right: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.05),
            child: BuildItalicText(
                txt: "Business Connection",
                fontsize: 0.022),
          ),

          Container(
              margin: EdgeInsets.only(left: width * 0.05),
              child:
              BuildWhiteMuiliTextBold(txt: "Most Engaged", fontsize: 0.027)),
          Container(
              margin: EdgeInsets.only(left: width * 0.05),
              child: BuildWhiteMuiliTextBold(
                  txt: daterange == null
                      ? "Last 1 day"
                      : "Last ${daterange!.duration.inDays.toString()} days",
                  fontsize: 0.0145)),
          SizedBox(
            height: height * 0.025,
          ),
          if (desiredprofile != null)
            Column(
              children: List.generate(
                  desiredprofile!.business_connection!.length,
                      (index) => BuildTile(
                        url:       desiredprofile!.business_connection![index].media!,
                     context:
                      context,
                      title:
                      desiredprofile!.business_connection![index].title,
                      click:
                      desiredprofile!.business_connection![index].title ==
                          "Facebook"
                          ? analytics.most_engage!.businessfb.toString()
                          : desiredprofile!.business_connection![index].title ==
                          "Instagram"
                          ? analytics.most_engage!.businessinst.toString()
                          : desiredprofile!
                          .business_connection![index].title ==
                          "Snapchat"
                          ? analytics.most_engage!.businesssnapchat.toString()
                          : desiredprofile!.business_connection![index]
                          .title ==
                          "Twitter"
                          ? analytics.most_engage!.businesstwitter
                          .toString()
                          : desiredprofile!
                          .business_connection![index]
                          .title ==
                          "WhatsApp"
                          ? analytics.most_engage!.businesswhatssapp.toString()
                          : desiredprofile!
                          .business_connection![
                      index]
                          .title ==
                          "Spotify"
                          ? analytics.most_engage!.businessspotify
                          .toString()
                          : desiredprofile!
                          .business_connection![
                      index]
                          .title ==
                          "LinkedIn"
                          ? analytics.most_engage!.businesslinkedin
                          .toString()
                          : desiredprofile!
                          .business_connection![
                      index]
                          .title ==
                          "YouTube"
                          ? analytics
                          .most_engage!.businessyoutube
                          .toString()
                          :  analytics
                          .most_engage!.businesscustom
                          .toString())),
            )
        ],
      ),
    );
  }

  Widget ProfileView_widget(BuildContext context, ProfileAnalytic analytic) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Future<List<BarMmodel>> chartdata(List<ProfileView> views) async {
      print("step10 and " + views.length.toString());
      List<BarMmodel> users_data = [];
      int mon = 0, tue = 0, wed = 0, thur = 0, fri = 0, sat = 0, sun = 0;

      DateTime start_date = daterange!.start;
      print("start3");
      views.forEach((element) {
        if ((element.date!.isAfter(start_date) ||
                element.date ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day)) &&
            element.date!.weekday == 1) {
          mon++;
        } else if ((element.date!.isAfter(start_date) ||
                element.date ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day)) &&
            element.date!.weekday == 2) {
          print("gandu");
          tue++;
        } else if ((element.date!.isAfter(start_date) ||
                element.date ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day)) &&
            element.date!.weekday == 3) {
          wed++;
        } else if ((element.date!.isAfter(start_date) ||
                element.date ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day)) &&
            element.date!.weekday == 4) {
          thur++;
        } else if ((element.date!.isAfter(start_date) ||
                element.date ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day)) &&
            element.date!.weekday == 5) {
          fri++;
        } else if ((element.date!.isAfter(start_date) ||
                element.date ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day)) &&
            element.date!.weekday == 6) {
          print("Azadi " + element.date!.weekday.toString());
          sat++;
        } else if ((element.date!.isAfter(start_date) ||
                element.date ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day)) &&
            element.date!.weekday == 7) {
          sun++;
        }
      });

      users_data = [
        BarMmodel("Mon", mon),
        BarMmodel("Tue", tue),
        BarMmodel("Wed", wed),
        BarMmodel("Thur", thur),
        BarMmodel("Fri", fri),
        BarMmodel("Sat", sat),
        BarMmodel("Sun", sun),
      ];

      return users_data;
    }

    return Container(
      decoration: BoxDecoration(color: Color(0xff2A2A2A)),
      padding: EdgeInsets.only(
          left: width * 0.025, top: height * 0.025, right: width * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: width * 0.025),
              child: BuildWhiteMuiliTextBold(
                  txt: "Profile Views", fontsize: 0.027)),
          SizedBox(
            height: height * 0.005,
          ),
          Container(
              margin: EdgeInsets.only(left: width * 0.025),
              child: BuildWhiteMuiliTextBold(
                  txt:
                      "Last ${daterange == null ? '1' : daterange!.duration.inDays.toString()} days",
                  fontsize: 0.014)),
          SizedBox(
            height: height * 0.005,
          ),
          Container(
              margin: EdgeInsets.only(left: width * 0.025),
              child: BuildWhiteMuiliTextBold(
                  txt:
    analytic.profileviews==null?'':
                  analytic.profileviews.toString(), fontsize: 0.027)),
          SizedBox(
            height: height * 0.025,
          ),
          FutureBuilder(
              future: chartdata(desiredprofile!.views!),
              builder: (context, AsyncSnapshot<List<BarMmodel>> sanpshot) {
                return sanpshot.connectionState == ConnectionState.waiting
                    ? Container(
                        padding: EdgeInsets.only(bottom: height * 0.025),
                        child: Center(
                            child: Text(
                          "Waiting...",
                          style: TextStyle(color: Colors.white),
                        )))
                    : (sanpshot.hasData)
                        ? SfChart(mylist: sanpshot.data)
                        : Container(
                            padding: EdgeInsets.only(bottom: height * 0.025),
                            child: Center(
                                child: Text(
                              "No data",
                              style: TextStyle(color: Colors.white),
                            )));
              })
        ],
      ),
    );
  }

  Widget BuildTile({
    required
    context,
    required
    String ? url,
    required
    String ? title,
    required
    String ? click,
  }
  ) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network(url!, height: height * 0.05, width: width * 0.2),

              BuildWhiteMuiliTextBold(txt: title, fontsize: 0.022)
              // title ==
              //         "https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FFacebook.png?alt=media&token=c977d16c-d397-430a-a6fe-071f6b360a53"
              //     ? BuildWhiteMuiliTextBold(txt: "Facebook", fontsize: 0.022)
              //     : title ==
              //             "gs://saintconnect-9c0c9.appspot.com/Social_Icons/Instagram.png"
              //         ? BuildWhiteMuiliTextBold(
              //             txt: "Instagram", fontsize: 0.022)
              //         : title ==
              //                 "gs://saintconnect-9c0c9.appspot.com/Social_Icons/Linkedin.png"
              //             ? BuildWhiteMuiliTextBold(
              //                 txt: "Linkedin", fontsize: 0.022)
              //             : title ==
              //                     "https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FSnapchat.png?alt=media&token=8823afc0-810e-49bd-bd6b-cfd084e21123"
              //                 ? BuildWhiteMuiliTextBold(
              //                     txt: "Snapchat", fontsize: 0.022)
              //                 : title ==
              //                         "gs://saintconnect-9c0c9.appspot.com/Social_Icons/Twitter.png"
              //                     ? BuildWhiteMuiliTextBold(
              //                         txt: "Twitter", fontsize: 0.022)
              //                     : title ==
              //                             "gs://saintconnect-9c0c9.appspot.com/Social_Icons/Whatsapp.png"
              //                         ? BuildWhiteMuiliTextBold(
              //                             txt: "Whatsapp", fontsize: 0.022)
              //                         : title ==
              //                                 "https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FYoutube.png?alt=media&token=f199925a-e704-4f14-b781-60c8fab1a8c3"
              //                             ? BuildWhiteMuiliTextBold(
              //                                 txt: "Youtube", fontsize: 0.022)
              //                             : BuildWhiteMuiliTextBold(
              //                                 txt: "", fontsize: 0.022)
            ],
          ),

          BuildWhiteMuiliTextBold(txt:
          "${
              click=="null"?0:
              click} Clicks", fontsize: 0.018),
        ],
      ),
    );
  }
}
