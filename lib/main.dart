import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:smart_healthcare/HeartModel.dart';
import 'package:smart_healthcare/TemperatureChart.dart';
import 'package:smart_healthcare/database.dart';
import 'package:intl/intl.dart';

import 'HeartChart.dart';
import 'TemperatureModel.dart';

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEBE3E3),
        ),
        title: 'My app', // used by the OS task switcher
        home: LineChart()),
  );
}

class LineChart extends StatefulWidget {
  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  int _selectedIndex = 0;
  DatabaseService databaseService = new DatabaseService();
  Stream heartBeat;
  List<HeartModel> listHeart = [];
  List<TemperatureModel> listTemperature = [];
  @override
  void initState() {
    setState(() {
      databaseService.getHeartChart().then((value) {
        setState(() {
          heartBeat = value;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widgetOptions = [HeartChart(seriesList: listHeart), TemperatureChart(seriesList: listTemperature)];
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Heart rate")),
          elevation: 0,
          backgroundColor: Colors.redAccent,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.redAccent,
                child: DatePicker(
                  DateTime.now(),
                  onDateChange: (date) {
                    // New date selected
                    print(date.toString());
                  },
                ),
              ),
              Container(
                color: Colors.redAccent,
                child: GNav(
                    gap: 8,
                    activeColor: Colors.white,
                    iconSize: 24,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    duration: const Duration(milliseconds: 800),
                    tabBackgroundColor: Colors.red,
                    tabs: [
                      GButton(
                        icon: LineIcons.heartbeat,
                        text: 'Heart Chart',
                      ),
                      GButton(
                        icon: Icons.ac_unit,
                        text: 'Temperature Chart',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    }),
              ),
              SingleChildScrollView(
                child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.redAccent,
                    child: StreamBuilder(
                        stream: heartBeat,
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return CircularProgressIndicator();
                          }
                          final docs = snapshot.data.documents;
                          listHeart.clear();
                          listTemperature.clear();
                          for(int i = 0; i < snapshot.data.documents.length; i++){
                            // String times = docs[i]["timestamp"].substring(0, 19);
                            // print(times);
                            DateTime time = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(docs[i]["timestamp"]);
                            print(time);
                            listHeart.add(HeartModel(time: time,bpm: docs[i]["bpm"]));
                            listTemperature.add(TemperatureModel(time: time,temperature: docs[i]["temperature"]));
                          }
                          return widgetOptions.elementAt(_selectedIndex);
                        })),
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite, color: Colors.redAccent),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "101",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Stress relieving state",
                                  style: TextStyle(fontSize: 12)),
                              Text("Times/minutes",
                                  style: TextStyle(fontSize: 11)),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Average heart rate",
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("65 ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text("Times/minutes",
                                      style: TextStyle(fontSize: 11)),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text("Minimum heart rate",
                                  style: TextStyle(fontSize: 12)),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("51 ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text("Times/minutes",
                                      style: TextStyle(fontSize: 11)),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text("Maximum heart rate",
                                  style: TextStyle(fontSize: 12)),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("101 ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text("Times/minutes",
                                      style: TextStyle(fontSize: 11)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.tune,
                        color: Colors.redAccent,
                      ),
                      title: Text("Heart rate range",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      endIndent: 20.0,
                      indent: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tranquilization state ",
                                style: TextStyle(color: Colors.pink),
                              ),
                              Text("( < 99 times per minutes)",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                              SizedBox(
                                width: 30,
                              ),
                              Text("98%", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 50,
                            animation: true,
                            lineHeight: 5.0,
                            animationDuration: 2000,
                            percent: 0.98,
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Stress relieving state ",
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text("( 100-119 times per minutes)",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                              SizedBox(
                                width: 30,
                              ),
                              Text("2%", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 50,
                            animation: true,
                            lineHeight: 5.0,
                            animationDuration: 2000,
                            percent: 0.02,
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Fat buring state ",
                                style: TextStyle(color: Colors.green),
                              ),
                              Text("( 120-139 times per minutes)",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                              SizedBox(
                                width: 30,
                              ),
                              Text("0%", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 50,
                            animation: true,
                            lineHeight: 5.0,
                            animationDuration: 2000,
                            percent: 0,
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.green,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
