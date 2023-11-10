import 'package:covid_tracker/model/WorlsStatsModel.dart';
import 'package:covid_tracker/services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

import 'package:pie_chart/pie_chart.dart';

import 'countries_list.dart';
class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration:  Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[

  ];

  @override
  Widget build(BuildContext context) {

    StatsServices statsServices = StatsServices();

    return Scaffold(

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
             // SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              FutureBuilder(
                future: statsServices.fetchWorldStatsRecords(),
                  builder: (context,AsyncSnapshot<WorlsStatsModel> snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ),
                  );
                }else{
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          'Total' : double.parse(snapshot.data!.cases.toString()),
                          'Recovered': double.parse(snapshot.data!.recovered.toString()),
                          'Deaths':double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
                        chartRadius: MediaQuery.of(context).size.width / 2.8,
                        ringStrokeWidth: 18.0,
                        legendOptions: LegendOptions(legendPosition: LegendPosition.left,),
                        chartType: ChartType.ring,
                        baseChartColor: Colors.blue,
                        animationDuration: Duration(seconds: 2),
                        colorList: [
                          Colors.blue,
                          Colors.green,
                          Colors.redAccent
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40,horizontal:5 ),
                        child: Card(
                          
                          child: Column(
                            children: [
                              ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                              ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                              ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                              ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                              ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                              ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CountriesList()));
                          },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green[800],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text('Track Countries'),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),

              ],
            ),
          ),
        ),
      ),

    );
  }
}

class ReusableRow extends StatelessWidget {
   ReusableRow({super.key,required this.title,required this.value});
  String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5,left: 10,right: 10,top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider(color: Colors.white10,height: 15,thickness: 0.5,),
        ],
      ),
    );
  }
}
