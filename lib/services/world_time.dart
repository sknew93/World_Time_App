import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime {

  String location; // location name for the UI
  String time; // time in that loc
  String flag; // url to asset flag icon
  String url; // loc url for constructor
  bool isDayTime; //true or false if daytime or not

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {

    try {
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      //  get properties for data
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      // print(datetime);
      // print(offset);

      // create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset.substring(1, 3)),minutes: int.parse(offset.substring(4,6))));

      // checking if day or night
      isDayTime = now.hour > 6 && now.hour < 17 ? true : false;
      // store time in a time property
      time = DateFormat.jm().format(now); // formating the only the time out of the datetime data
    }
    catch (e) {
      print('Caught error: $e');
      time = 'Could not get time data.';
    }
  }

}

