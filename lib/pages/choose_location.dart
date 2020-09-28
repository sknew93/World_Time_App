import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {


  @override
  Widget build(BuildContext context) {

    List<WorldTime> locations = [
      WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
      WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
      WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
      WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
      WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
      WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
      WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
      WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
      WorldTime(url: 'Asia/Kolkata', location: 'India', flag: 'india.png'),
    ];

    void updateTime(index) async {
      WorldTime instance = locations[index];
      await instance.getTime(); //await because it may take a second to collect data

      Navigator.pop(context, {
        'location' : instance.location,
        'url' : instance.url,
        'flag' : instance.flag,
        'time' : instance.time,
        'isDaytime' : instance.isDayTime
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                child: ListTile(
                  onTap: (){
                    updateTime(index);
                  },
                  title: Text(locations[index].location,),
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: AssetImage('assets/world.jpg'),
                  ),
                ),
              ),
            );
          }),

    );
  }
}
