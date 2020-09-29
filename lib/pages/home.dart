import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    void onTimerPress() {
      Navigator.pushNamed(context, '/timer');
    }


    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    //set background data,background color and txt color with "isDaytime"
    String bgImage = data['isDaytime'] ? 'daytime.jpg' : 'nightime.jpg';
    Color bgColor = data['isDaytime'] ? Colors.blueAccent : Colors.black;
    Color txtColor = data['isDaytime'] ? Colors.black : Colors.grey;


    return Scaffold(
      backgroundColor: bgColor,
        body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/$bgImage'),
                    fit: BoxFit.cover)
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,180,0,0),
                child: Column(
          children: <Widget>[
                FlatButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time' : result['time'],
                          'location' : result['location'],
                          'isDaytime' : result['isDaytime'],
                          'flag' : result['flag'],
                          'url' : result['url']
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(' Edit Location', style: TextStyle(color: Colors.grey[300],),)),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['url'],
                      style: TextStyle(
                        color: txtColor,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0
                      ),
                    )
                  ],
                ),
              SizedBox(height: 20),
              Text(
                data['time'],
                style: TextStyle(
                  color: txtColor,
                  fontSize: 90.0,

                ),
              )

          ],
        ),
              ),
            ),),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Timer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: txtColor
          ),),
          SizedBox(height: 5,),
          FloatingActionButton(
            tooltip: 'Timer' ,
            splashColor: Colors.black,
            backgroundColor: txtColor,
              child: Icon(Icons.timer,
              color: bgColor),

              onPressed: (){
              onTimerPress();

              }),
        ],
      ),
    );
  }
}

