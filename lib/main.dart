import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  return runApp(ChartApp());
}

class ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chart Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Chart Demo"),
      ),
      body: ListView(
        children: <Widget>[
          _areaChart(),
          _lineChart(),
          _spineChart(),
          _columnChart(),
          _barChart(),
          _bubbleChart(),
          _candleStickChart(),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: _circularChart()),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: _pyramidChart()),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final double year;
  final double sales;
}

List<SalesData> chartData = <SalesData>[
  SalesData(2004, 35),
  SalesData(2005, 28),
  SalesData(2006, 34),
  SalesData(2007, 32),
  SalesData(2008, 10)
];

Widget _lineChart() {
  return SfCartesianChart(
    primaryXAxis: CategoryAxis(),
    isTransposed: false,
    title: ChartTitle(text: 'Line Charts'),
    // Enable legend
    legend: Legend(isVisible: true),
    series: [
      LineSeries<SalesData, double>(
        dataSource: chartData,
        xValueMapper: (SalesData sales, _) => sales.year,
        yValueMapper: (SalesData sales, _) => sales.sales,
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          color: Colors.cyan,
        ),
      )
    ],
  );
}

Widget _areaChart() {
  return SfCartesianChart(
      title: ChartTitle(text: "Area Chart"),
      series: <ChartSeries>[
        AreaSeries<SalesData, double>(
            gradient: LinearGradient(colors: [Colors.cyan, Colors.transparent]),
            dataSource: chartData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales)
      ]);
}

Widget _spineChart() {
  return SfCartesianChart(
    title: ChartTitle(text: "Spine Chart"),
    series: <ChartSeries>[
      SplineSeries<SalesData, double>(
          dataSource: chartData,
          cardinalSplineTension: 0.9,
          splineType: SplineType.natural,
          dataLabelSettings: DataLabelSettings(
            showCumulativeValues: true,
            isVisible: true,
          ),
          dashArray: <double>[1, 3],
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales),
    ],
  );
}

Widget _columnChart() {
  return SfCartesianChart(
    title: ChartTitle(text: "Column Chart"),
    series: <ChartSeries>[
      ColumnSeries<SalesData, double>(
          dataSource: chartData,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales),
    ],
  );
}

Widget _barChart() {
  return SfCartesianChart(
      title: ChartTitle(text: "Bar Chart"),
      series: <ChartSeries>[
        // Renders bar chart
        BarSeries<SalesData, double>(
            dataSource: chartData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales)
      ]);
}

Widget _bubbleChart() {
  return SfCartesianChart(series: <ChartSeries>[
    // Renders bubble chart
    BubbleSeries<ChartData, double>(
        dataSource: data,
        sizeValueMapper: (ChartData sales, _) => sales.size,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y)
  ]);
}

class ChartData {
  ChartData(this.x, this.y, this.size);

  final double x;
  final double y;
  final double size;
}

final List<ChartData> data = [
  ChartData(2003, 35, 0.5),
  ChartData(2004, 38, 0.71),
  ChartData(2005, 34, 0.38),
  ChartData(2006, 52, 0.29),
  ChartData(2007, 40, 0.34)
];

Widget _candleStickChart() {
  return SfCartesianChart(series: <ChartSeries>[
    // Renders CandleSeries
    CandleSeries<ShareData, double>(
      bullColor: Colors.green,
      trendlines: [Trendline(isVisible: true, color: Colors.green, width: 5)],
      dataSource: shareData,
      xValueMapper: (ShareData sales, _) => sales.year,
      lowValueMapper: (ShareData sales, _) => sales.low,
      highValueMapper: (ShareData sales, _) => sales.high,
      openValueMapper: (ShareData sales, _) => sales.open,
      closeValueMapper: (ShareData sales, _) => sales.close,
    ),
  ]);
}

class ShareData {
  final int low;
  final int high;
  final int open;
  final int close;
  final double year;

  ShareData(this.low, this.high, this.open, this.close, this.year);
}

List<ShareData> shareData = [
  ShareData(200, 400, 230, 400, 2002),
  ShareData(100, 500, 250, 50, 2003),
  ShareData(200, 400, 300, 400, 2004),
  ShareData(400, 800, 400, 803, 2005),
];

Widget _circularChart() {
  return SfCircularChart(
      // Chart title text
      title: ChartTitle(text: 'Circular Chart'),
      legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CircularSeries>[
        // Render pie chart
        PieSeries<CircularChart, String>(
            dataSource: [
              // Bind data source
              CircularChart('Jan', 35),
              CircularChart('Feb', 28),
              CircularChart('Mar', 34),
              CircularChart('Apr', 32),
              CircularChart('May', 40)
            ],
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
            ),
            pointColorMapper: (CircularChart data, _) => data.color,
            xValueMapper: (CircularChart data, _) => data.x,
            yValueMapper: (CircularChart data, _) => data.y)
      ]);
}

class CircularChart {
  CircularChart(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color color;
}

Widget _pyramidChart() {
  return SfPyramidChart(
      title: ChartTitle(text: "Pyramid Chart"),
      // Enables the tooltip for all the series in chart
      tooltipBehavior: TooltipBehavior(enable: true),
      legend: Legend(isVisible: true),
      series: PyramidSeries<PyramidChartData, String>(
        dataSource: pyramidChartData,
        dataLabelSettings: DataLabelSettings(isVisible: true),
        xValueMapper: (PyramidChartData data, _) => data.x,
        yValueMapper: (PyramidChartData data, _) => data.y,
      ));
}

class PyramidChartData {
  PyramidChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color color;
}

final List<PyramidChartData> pyramidChartData = [
  PyramidChartData('a', 25),
  PyramidChartData('b', 38),
  PyramidChartData('c', 34),
  PyramidChartData('d', 52)
];
