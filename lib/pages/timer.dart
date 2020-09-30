import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';


class TimerClass extends StatefulWidget {
  @override
  _TimerClassState createState() => _TimerClassState();
}

class _TimerClassState extends State<TimerClass> with TickerProviderStateMixin{

  TabController tb;

  @override
  void initState() {
    tb = TabController(
      length: 1,
      vsync: this,
    );
    super.initState();
  }

  Widget timer(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                      child: Text('HH',
                        style: TextStyle(color: Colors.grey,
                            fontSize: 22),),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Text(':', style: TextStyle(color: Colors.white,)),
                ),
                Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                      child: Text('MM',
                        style: TextStyle(color: Colors.grey,
                            fontSize: 22),),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Text(':', style: TextStyle(color: Colors.white,)),
                ),
                Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 7, 25),
                      child: Text('SS',
                        style: TextStyle(color: Colors.grey,
                            fontSize: 22),),
                    )
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: TextField(
                    controller: myControllerHH,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly],
                    maxLength: 2,
                    autofocus: false,
                    style: TextStyle(fontSize: 22.0, color: Colors.white,),
                    decoration: InputDecoration(
                        filled: true,
                        hintText: '00',
                        hintStyle: TextStyle(color: Colors.white30)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Text(':', style: TextStyle(color: Colors.white,)),
                ),
                Flexible(
                  child: TextField(
                    controller: myControllerMM,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly],
                    maxLength: 2,
                    autofocus: false,
                    style: TextStyle(fontSize: 22.0, color: Colors.white),
                    decoration: InputDecoration(
                        filled: false,
                        hintText: '00',
                        hintStyle: TextStyle(color: Colors.white30)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Text(':', style: TextStyle(color: Colors.white,)),
                ),
                Flexible(
                  child: TextField(
                    controller: myControllerSS,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly],
                    maxLength: 2,
                    autofocus: false,
                    style: TextStyle(fontSize: 22.0, color: Colors.white),
                    decoration: InputDecoration(
                        filled: false,
                        hintText: '00',
                        hintStyle: TextStyle(color: Colors.white30)
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.blue[900],
              thickness: 2,
              height: 25,
            ),
            ((timeInSec < 1) == true) ? Text('Times Up!') : Text('Counter'),
            Text('$timeToDisplay',
              style: TextStyle(color: Colors.grey),),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
              child: RaisedButton.icon(
                onPressed: started ? starTimer : null,
                color: Colors.green,
                disabledColor: Colors.green[100],
                icon: Icon(Icons.timer),
                label: Text('Start Timer'),
                splashColor: Colors.blue[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton.icon(
                onPressed: stopped ? null : stopTimer,
                color: Colors.red[500],
                disabledColor: Colors.red[100],
                splashColor: Colors.blue[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),

                icon: Icon(Icons.refresh),
                label: Text('Reset Timer'),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
              child: LinearProgressIndicator(
                value: (linearScaleValue),
                backgroundColor: Colors.green,
                valueColor: AlwaysStoppedAnimation(Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime timeNow;
  int counter = 10;
  String timeToDisplay = 'Counter in Seconds.';
  bool started = true;
  bool stopped = true;
  int timeInSec = 0;
  int orgTimeInSec;
  double linearScaleValue = 1.0;
  dynamic myControllerHH = TextEditingController();
  dynamic myControllerMM = TextEditingController();
  dynamic myControllerSS = TextEditingController();
  int myHH;
  int myMM;
  int mySS;







  void starTimer() {
    // var now = new DateTime.now();
    // print(now);
    // int copyHH = myHH;
    // int copyMM = myMM;
    // int copySS = mySS;
    // now = now.add(Duration(hours: myHH, minutes: myMM, seconds: mySS));
    // print(now);
    setState(() {
      started = false;
      stopped = false;
    });


    int myHH = ((myControllerHH.text==null) ? 0 : (int.parse(myControllerHH.text)));
    int myMM = ((myControllerMM.text==null) ? 0 : (int.parse(myControllerMM.text)));
    int mySS = ((myControllerSS.text==null) ? 0 : (int.parse(myControllerSS.text)));

    timeInSec = ((myHH*60*60)+(myMM*60)+mySS);
    final orgTimeInSec = timeInSec;

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeInSec < 1) {
          timeToDisplay = 'Done';
          t.cancel();
        } else {
          timeInSec = timeInSec-1;
        }
        timeToDisplay = timeInSec.toString();
        myControllerSS.text = timeInSec.toString();
        linearScaleValue = timeInSec/orgTimeInSec;
      });
    });
  }

  void stopTimer() {
    setState(() {
      started = true;
      stopped = false;
      linearScaleValue = 1.0;
      myControllerHH.clear();
      myControllerMM.clear();
      myControllerSS.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        title: Text('Timer'),
        bottom: TabBar(tabs:
        [
          Text('Input Time Required')
        ],
        labelStyle: TextStyle(
          fontStyle: FontStyle.italic
        ),
        labelPadding: EdgeInsets.all(10),
        controller: tb,),
      ),

      body: TabBarView(
          children: <Widget>[
            timer(), // holding timer widget
          ],
        controller: tb,
      ),
    );

  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   myControllerHH.dispose();
  //   myControllerMM.dispose();
  //   myControllerSS.dispose();
  //   super.dispose();
  //   print('Cleared');
  // }

}


