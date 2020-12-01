import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'TemperatureModel.dart';

class TemperatureChart extends StatefulWidget {
  TemperatureChart({this.seriesList});
  final List<TemperatureModel> seriesList;
  @override
  _TemperatureChartState createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      _createSampleData(widget.seriesList),
      primaryMeasureAxis: new charts.NumericAxisSpec(
        tickProviderSpec: new charts.StaticNumericTickProviderSpec(
          <charts.TickSpec<num>>[

            charts.TickSpec<num>(40,style: charts.TextStyleSpec(
              color: charts.ColorUtil.fromDartColor(Colors.white),
            )),

          ],
        ),
      ),
      domainAxis: charts.DateTimeAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          lineStyle: charts.LineStyleSpec(color: charts.ColorUtil.fromDartColor(Colors.white)),
          labelRotation: 60,
          labelStyle: charts.TextStyleSpec(fontSize: 10,
            color: charts.ColorUtil.fromDartColor(Colors.white),
          ),
        ),
        tickProviderSpec: charts.StaticDateTimeTickProviderSpec(
          <charts.TickSpec<DateTime>>[
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,00,00)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,02,02)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,04,04)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,06,06)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,08,08)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,10,10)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,12,12)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,14,14)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,16,16)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,18,18)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,20,20)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,22,22)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,24,24)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,26,26)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,28,28)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,30,30)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,32,32)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,34,34)),
            charts.TickSpec<DateTime>(DateTime(2020, 11, 30,11,36,36)),
          ],
        ),
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          hour: charts.TimeFormatterSpec(
            format: 'mm:ss a',
            transitionFormat: 'mm:ss a',
          ),
        ),
      ),
      animate: false,
      behaviors: [
        // new charts.SeriesLegend(),
        new charts.SlidingViewport(),
        new charts.PanAndZoomBehavior(),
      ],
      defaultRenderer: new charts.LineRendererConfig(includePoints: false),
      // Custom renderer configuration for the point series.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
  /// Create one series with sample hard coded data.
  List<charts.Series<TemperatureModel, DateTime>> _createSampleData(List<TemperatureModel> data) {
    return [
      charts.Series<TemperatureModel, DateTime>(
        id: 'temperature beat',
        domainFn: (TemperatureModel temp, _) => temp.time,
        measureFn: (TemperatureModel temp, _) => temp.temperature,
        colorFn: (_, __) => charts.MaterialPalette.white,
        data: data,
      )
    ];
  }
}
