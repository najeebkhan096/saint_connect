
import 'package:flutter/material.dart';
import 'package:saintconnect/Charts/barchart_module.dart';
import 'package:saintconnect/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SfChart extends StatefulWidget {
  final List<BarMmodel> ? mylist;

  SfChart({@required this.mylist});

  @override
  _SfChartState createState() => _SfChartState();
}

class _SfChartState extends State<SfChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState(){
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width*1,
            height: MediaQuery.of(context).size.height*0.2,
            child: SfCartesianChart(
              plotAreaBorderColor: Colors.transparent ,

                primaryXAxis: CategoryAxis(borderColor: Colors.transparent,
                ),
                // Chart title

                // Enable legend
                legend: Legend(isVisible: false),
                // Enable tooltip
                tooltipBehavior: _tooltipBehavior,


                series: <LineSeries<BarMmodel, String>>[
                  LineSeries<BarMmodel, String>(
                      dataSource:  widget.mylist!,

                      xValueMapper: (BarMmodel sales, _) => sales.year,
                      yValueMapper: (BarMmodel sales, _) => sales.value,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: false),
                    color: mycolor,

                  )
                ]
            )
        ),

      ],
    );

  }
}
