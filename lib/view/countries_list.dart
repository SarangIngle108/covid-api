import 'package:covid_tracker/services/stats_services.dart';
import 'package:covid_tracker/view/detail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  TextEditingController searchContrller = TextEditingController();
  StatsServices statsServices = StatsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchContrller,
              onChanged: (value){
                setState(() {

                });
              },

              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'search',
              ),

            ),
          ),
          Expanded(
              child: FutureBuilder(
                future: statsServices.fetchCountryStatsRecords(),
                builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context,index){
                            return Shimmer.fromColors(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(height: 10,width: 100,color: Colors.white,),
                                      subtitle: Container(height: 10,width: 100,color: Colors.white,),
                                      leading: Container(height: 10,width: 100,color: Colors.white,),
                                    ),
                                  ],
                                ),
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                            );
                          });
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String country = snapshot.data![index]['country'];
                        String continent = snapshot.data![index]['continent'];
                        if(searchContrller.text.isEmpty){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>DetailScreen(
                                    countryName: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    tests: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    totalRecovered: snapshot.data![index]['recovered'],
                                  )));
                          },
                                child: ListTile(
                                  leading: Image(
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']['flag'],
                                    ),
                                    height: 50,width: 50,
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['continent']),
                                ),
                              ),
                            ],
                          );
                        }
                        else if(country.toLowerCase().contains(searchContrller.text.toLowerCase())
                        || continent.toLowerCase().contains(searchContrller.text.toLowerCase())
                        ){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>DetailScreen(
                                    countryName: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    tests: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    totalRecovered: snapshot.data![index]['recovered'],
                                  )));
                          },
                                child: ListTile(
                                  leading: Image(
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']['flag'],
                                    ),
                                    height: 50,width: 50,
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['continent']),
                                ),
                              ),
                            ],
                          );
                        }
                        else{
                        return Container();
                        }

                    },
                    );
                  }
                },
              ),
          ),
        ],
      ),
    ),
    );
  }
}
