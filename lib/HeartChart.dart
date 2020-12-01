import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart' as intl;

import 'HeartModel.dart';

class HeartChart extends StatefulWidget {
  HeartChart({this.seriesList});
  final List<HeartModel> seriesList;
  @override
  _HeartChartState createState() => _HeartChartState();
}

class _HeartChartState extends State<HeartChart> {

  @override
  Widget build(BuildContext context) {
   
    final fromDate = DateTime.now().subtract(Duration(seconds: 50));
    final toDate = DateTime.now();

    final date1 = toDate.subtract(Duration(seconds: 2));
    final date2 = toDate.subtract(Duration(seconds: 3));
    final date3 = toDate.subtract(Duration(seconds: 10));
    final date4 = toDate.subtract(Duration(seconds: 15));
    final date5 = toDate.subtract(Duration(seconds: 19));
    final date6 = toDate.subtract(Duration(seconds: 26));

    return Center(
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          bezierChartScale: BezierChartScale.HOURLY,
          fromDate: fromDate,
          toDate: toDate,
          selectedDate: toDate,
          footerDateTimeBuilder: (DateTime value, BezierChartScale scaleType) {
            final newFormat = intl.DateFormat('mm');
            return newFormat.format(value);
          },
          series: [
            BezierLine(
              label: "Duty",
              data: [
                DataPoint<DateTime>(value: 0, xAxis: date1),
                DataPoint<DateTime>(value: 50, xAxis: date2),
                DataPoint<DateTime>(value: 200, xAxis: date3),
                DataPoint<DateTime>(value: 100, xAxis: date4),
                DataPoint<DateTime>(value: 40, xAxis: date5),
                DataPoint<DateTime>(value: 47, xAxis: date6),
              ],
            ),
          ],
          config: BezierChartConfig(

            verticalIndicatorStrokeWidth: 3.0,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,

            verticalIndicatorFixedPosition: false,
            bubbleIndicatorTitleStyle: TextStyle(
              color: Colors.blue,
            ),
            bubbleIndicatorLabelStyle: TextStyle(
              color: Colors.red,
            ),
            displayYAxis: true,
            stepsYAxis: 25,
            backgroundGradient: LinearGradient(
              colors: [
                Colors.red[300],
                Colors.red[400],
                Colors.red[400],
                Colors.red[500],
                Colors.red,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            footerHeight: 35.0,
          ),
        ),
      ),
    );
  }
}

//   charts.TimeSeriesChart(
//   _createSampleData(widget.seriesList),
//   primaryMeasureAxis: new charts.NumericAxisSpec(
//   tickProviderSpec: new charts.StaticNumericTickProviderSpec(
//   <charts.TickSpec<num>>[
//   charts.TickSpec<num>(0,style: charts.TextStyleSpec(
//   color: charts.ColorUtil.fromDartColor(Colors.white),
//   )),
//   charts.TickSpec<num>(40,style: charts.TextStyleSpec(
//   color: charts.ColorUtil.fromDartColor(Colors.white),
//   )),
//   charts.TickSpec<num>(80,style: charts.TextStyleSpec(
//   color: charts.ColorUtil.fromDartColor(Colors.white),
//   )),
//   charts.TickSpec<num>(120,style: charts.TextStyleSpec(
//   color: charts.ColorUtil.fromDartColor(Colors.white),
//   )),
//   charts.TickSpec<num>(160,style: charts.TextStyleSpec(
//   color: charts.ColorUtil.fromDartColor(Colors.white),
//   )),
//   charts.TickSpec<num>(200,style: charts.TextStyleSpec(
//   color: charts.ColorUtil.fromDartColor(Colors.white),
//   )),
//
//   ],
//   ),
//   ),
//   domainAxis: charts.DateTimeAxisSpec(
//   renderSpec: charts.SmallTickRendererSpec(
//   lineStyle: charts.LineStyleSpec(color: charts.ColorUtil.fromDartColor(Colors.white)),
//   labelRotation: 60,
//   labelStyle: charts.TextStyleSpec(fontSize: 10,
//   color: charts.ColorUtil.fromDartColor(Colors.white),
//   ),
//   ),
//   tickProviderSpec: charts.StaticDateTimeTickProviderSpec(
//   <charts.TickSpec<DateTime>>[
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,00)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,02)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,04)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,06)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,08)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,10)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,12)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,14)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,16)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,18)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,20)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,24)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,26)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,28)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,30)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,32)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,34)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,36)),
//   charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,38)),
//   ],
//   ),
//   tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
//   hour: charts.TimeFormatterSpec(
//   format: 'hh:mm a',
//   transitionFormat: 'hh:mm a',
//   ),
//   ),
//   ),
//   animate: false,
//   behaviors: [
//   // new charts.SeriesLegend(),
//   charts.SlidingViewport(
//   charts.SelectionModelType.action,
//   ),
//   charts.PanBehavior(),
//   ],
//   defaultRenderer: new charts.LineRendererConfig(includePoints: false),
//   // Custom renderer configuration for the point series.
//   customSeriesRenderers: [
//   new charts.PointRendererConfig(
//   // ID used to link series to this renderer.
//   customRendererId: 'customPoint')
//   ],
//   dateTimeFactory: const charts.LocalDateTimeFactory(),
//   );
// }
// /// Create one series with sample hard coded data.
// List<charts.Series<HeartModel, DateTime>> _createSampleData(List<HeartModel> data) {
//   return [
//     charts.Series<HeartModel, DateTime>(
//       id: 'heart beat',
//       domainFn: (HeartModel heart, _) => heart.time,
//       measureFn: (HeartModel heart, _) => heart.bpm,
//       colorFn: (_, __) => charts.MaterialPalette.white,
//       data: data,
//     )
//   ];
// }