import 'package:intl/intl.dart';

class DateTimeUtil {

  static const String serverDateTimeFormat = "yyyy-MM-ddTHH:mm:ss";
  static const String serverDateTimeFormat2 = "yyyy-MM-ddTHH:mm:ssZ";
  static const String serverDateTimeFormat3 = "yyyy-MM-dd HH:mm:ssZ";
  static const String dateTimeFormat1 = "dd/MMM/yyyy";
  static const String dateTimeFormat2 = "dd MMM yyyy";
  static const String dateTimeFormat3 = "yyyy-MM-dd";
  static const String dateTimeFormat4 = "hh:mm a";
  static const String dateTimeFormat5 = "EE, MMM dd, yyyy";
  static const String dateTimeFormat6 = "MMM dd, yyyy";
  static const String dateTimeFormat7 = "dd MMMM yyyy";

  static const String dateTimeFormat8 ="HH:mm:ss";

  static const TOD_AM="AM",TOD_PM="PM";

  //static const timeFormat="hh:mm aa";


  static String formatDate(
    String? date, {
    String inputDateTimeFormat = serverDateTimeFormat,
    String outputDateTimeFormat = dateTimeFormat1,
  }) {
    if (date == null) return "";

    try {
      DateTime tempDate = DateFormat(inputDateTimeFormat).parse(date);
      return DateFormat(outputDateTimeFormat).format(tempDate);
    } on Exception catch (e) {
      print("Error parsing date time: $e");
      return "";
    }
  }

  static String formatDateToLocal(
      String? date, {
        String inputDateTimeFormat = serverDateTimeFormat,
        String outputDateTimeFormat = dateTimeFormat1,
      }) {
    if (date == null) return "";

    try {

      print("---------------");
      print(date);
      var formattedDate = DateTime.parse(date).toLocal().toString();
      DateTime tempDate = DateFormat(inputDateTimeFormat).parse(formattedDate);
      return DateFormat(outputDateTimeFormat).format(tempDate);
    } on Exception catch (e) {
      print("Error parsing date time: $e");
      return "";
    }
  }
  static String parseDateTime(String date,String formatIn,String formatOut,{bool isutc=false,}){
    DateTime dateTime=isutc?DateFormat(formatIn).parse(date,isutc,).toLocal():
    DateFormat(formatIn).parse(date,isutc,);
    return DateFormat(formatOut).format(dateTime);
  }

  static String formatDateInUTC(
      String? date, {
        String inputDateTimeFormat = serverDateTimeFormat,
        String outputDateTimeFormat = dateTimeFormat1,
      }) {
    if (date == null) return "";

    try {
      DateTime tempDate = DateFormat(inputDateTimeFormat).parse(date).toUtc();
      return DateFormat(outputDateTimeFormat).format(tempDate);
    } on Exception catch (e) {
      print("Error parsing date time: $e");
      return "";
    }
  }

  static String formatDateTime(
    DateTime? date, {
    String outputDateTimeFormat = dateTimeFormat3,
  }) {
    if (date == null) return "";

    return DateFormat(outputDateTimeFormat).format(date);
  }

  static DateTime stringToDate(String? date) {
    if (date == null) return DateTime.now();
    return DateTime.parse(date);
  }

  static bool areHoursAndMinutesEqual(DateTime dateTime1, DateTime dateTime2) {
    // Extract the hour and minute components from the DateTime objects
    int hour1 = dateTime1.hour;
    int minute1 = dateTime1.minute;
    int hour2 = dateTime2.hour;
    int minute2 = dateTime2.minute;

    // Check if the hours and minutes are the same
    return hour1 == hour2 && minute1 == minute2;
  }

  static DateTime getCurrentDate() {
    var now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    return currentDate;
  }

  static String getCurrentDay() {
    return DateFormat('EEEE').format(DateTime.now());
  }

  static int timeDifference12(String time12,String time212){
    return timeDifference24(formatTime24(time12),formatTime24(time212));
  }

  static int timeDifference24(String time24,String time224){
    //assert(date1.isAfter(date2) || date1.isAtSameMomentAs(date2));
    int secs1=getDuration(time24);
    int secs2=getDuration(time224);
    int secs=secs2-secs1;
    print("secs: $secs");
    return secs;
  }

  static String formatTime12(String time24){
    List<String> vals=time24.split(":");
    int hour=int.parse(vals[0]);
    int min=int.parse(vals[1]);
    String tod=TOD_AM;
    if(hour<=0){
      hour=12;
    }
    else if(hour==12){
      tod=TOD_PM;
    }
    else if(hour>12){
      hour=hour-12;
      tod=TOD_PM;
    }
    return "${_getUnit(hour)}:${_getUnit(min)} ${tod}";
  }


  static String formatTime24(String time12,{bool secs=false}){
    final List<int> vals=_extractTimeTo24(time12);
    return "${_getUnit(vals[0])}:${_getUnit(vals[1])}${secs?":00":""}";
  }


  static List<int> _extractTimeTo24(String time){
    List<String> list=time.split(" ");
    List<String> vals=list[0].split(":");
    String tod=list[1];
    int hour=int.parse(vals[0]);
    int min=int.parse(vals[1]);
    if(tod==TOD_PM && hour<12){
      hour=hour+12;
    }
    else if(tod==TOD_AM && hour==12){
      hour=0;
    }
    return [hour,min];
  }


  static int getDuration(String time24){
    int secs=0;
    List<String> list=time24.split(":");
    try {
      secs += int.parse(list[0]) * 3600;
      secs += int.parse(list[1]) * 60;
    }
    catch(ex){

    }
    //secs+=int.parse(list[0]);
    return secs;
  }



  static String _getUnit(int m){
    return "${m<=9?"0":""}${m}";
  }

}
