import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({
    required this.countryName,
    required this.image,
  required this.todayRecovered,
  required this.critical,
  required this.active,
  required this.tests,
  required this.totalCases,
  required this.totalDeaths,
  required this.totalRecovered,
  });
  String countryName,image;
  int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,tests;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName),
        centerTitle: true,
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                      ReusableRow(title: 'Total Cases', value: widget.totalCases.toString()),
                     ReusableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                      ReusableRow(title: 'Total Deaths', value: widget.totalDeaths.toString()),
                      ReusableRow(title: 'Critical', value: widget.critical.toString()),
                      ReusableRow(title: 'Active Cases', value: widget.active.toString()),
                      ReusableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                      ReusableRow(title: 'Tests', value: widget.tests.toString())

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          ),
        ],
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