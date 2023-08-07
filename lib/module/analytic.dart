class ProfileAnalytic{
  double ? averageprofiletime;
  String ? date;
  MostEngaged ? most_engage;
  PopularDevices ? pupolar_devices;
int ? profileviews;
String ? userid;
ProfileAnalytic({this.averageprofiletime,this.date,this.most_engage,this.pupolar_devices,this.profileviews,this.userid});
}
class MostEngaged{
  int ? personalfb;
  int ? perosonalinst;
  int ? personaltwitter;
  int ? personalsnapchat;
  int ? personaltyoutube;
  int ? personalspotify;
  int ? personallinkedin;
  int ? personalwhatsapp;
  int ? personalPhone;
  int ? Finalbutton;
  int ? contactDownload;

  int ? businessfb;
  int ? businessinst;
  int ? businesstwitter;

  int ? businesssnapchat;
  int ? businessyoutube;
  int ? businessspotify;
  int ? businesscustom;
  int ? perosonalcustom;
  int ? businesslinkedin;
  int ? businesswhatssapp;
  int ? personalEmail;
  MostEngaged({
    this.perosonalcustom,
    this.businesscustom,
    this.personalfb,this.perosonalinst,this.personaltwitter,this.businessfb,this.businessinst,this.businesstwitter,this.businesslinkedin,this.businesssnapchat,this.businessspotify,this.businessyoutube,this.personallinkedin,this.personalsnapchat,this.personalspotify,this.personaltyoutube,this.businesswhatssapp,this.personalwhatsapp,this.Finalbutton,this.personalPhone,this.personalEmail,this.contactDownload});

}
class PopularDevices{
  int ? mobile;
  int ? desktop;
  PopularDevices({this.mobile,this.desktop});

}