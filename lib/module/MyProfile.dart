import 'package:saintconnect/module/view.dart';

class MyProfile{
  String ? profile_image;
  String ? logo;
  String ? qrcode;
  YourDetails ? your_details;
  List<SocialMedia> ? personal_connection=[];
  List<SocialMedia> ? business_connection=[];
  List<String> ? Accreditation=[];
  BusinessDetails ? business_details;
  Design_Appearance ? design_appearance;
  String ? Backgroundimage;
  List<String> ?images=[];
  List<String> ? platforms;
  String? video;
String ? docid;
String ? uid;
DateTime ? date;
FinalButton ? final_button;
  String ? personal_connection_title;
  String ? businesss_connection_title;
  List<ProfileView> ? views;
  String ? vcf_url;
  bool ? payment;
  DateTime ? ExpirayDate;
  MyProfile({
    this.vcf_url,
    this.businesss_connection_title,
    this.personal_connection_title,
    this.date,
    this.final_button,
this.payment,
    required
    this.profile_image,
    this.uid,
    required this.business_connection,
    required this.logo,required this.your_details,required this.personal_connection,required this.Accreditation,
    required this.business_details,
    required  this.design_appearance,
    required this.Backgroundimage,
    required this.images,
    this.docid,
    this.qrcode,
    this.views,
    required this.video,
    this.platforms,
    this.ExpirayDate
  });

}
class FinalButton{
  String ? title;
  String ? url;
  FinalButton({this.title,this.url});
}

class SocialMedia{
  final String ? media;
  final String ? url;
  final String ? title;

  SocialMedia({this.media,this.url,required this.title});
}
class YourDetails{
  String ? name;
  String ? email;
  String ? contact_no;
  String ? location;
  String ? title;
  String ? intro_heading;
  String ? paragraph;
  String ? bio;
  String ? finalbutton;


  YourDetails({this.name,this.email,this.contact_no,this.location,this.intro_heading,this.title,this.paragraph,this.bio,this.finalbutton});
}

class CustomColor{

   String ? hexcode;
  CustomColor({  required  this.hexcode});
}

class Design_Appearance
{
  CustomColor  ? BackgroundTheme;
  CustomColor ? TextColor;
  CustomColor ? ButtonColor;
  CustomColor ? BorderColor;
  Design_Appearance({this.BackgroundTheme,this.ButtonColor,this.TextColor,this.BorderColor});
}
class BusinessDetails{
  String ? Business_name;
  String ? company_sector;
  String ? website;
  String ? company_contact_no;


  BusinessDetails({this.Business_name,this.company_sector,this.website,this.company_contact_no});
}
MyProfile ? currentuser_MyProfile;
