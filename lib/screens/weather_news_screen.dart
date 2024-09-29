
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_news/screens/settings_screen.dart';

import '../providers/settings_model.dart';
import '../providers/weather_news_provider.dart';

class WeatherNewsScreen extends StatefulWidget {
  @override
  State<WeatherNewsScreen> createState() => _WeatherNewsScreenState();
}

class _WeatherNewsScreenState extends State<WeatherNewsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<WeatherNewsProvider>(context, listen: false)
        .fetchWeather();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text('Weather & News'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(),));
          }, icon: Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 5.0,left: 5.0,right: 5.0),
        child: Consumer<WeatherNewsProvider>(
          builder: (context, provider, child) {
            if (provider.weather == null) {
              return CircularProgressIndicator();
            }
            return Container(
              height: MediaQuery.of(context).size.height*0.9,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.15,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Todays weather: ",style: TextStyle(fontSize: 18),),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on,color: Colors.red,),
                                        Text(
                                          provider.weather!.city,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.height*0.1,
                                      width: MediaQuery.of(context).size.width/2.2,

                                      child: Card(
                                        color: Colors.blue[50],
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.fill,
                                              child: Text(
                                                "Weather Condition",
                                                style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),
                                              ),
                                            ),
                                            Text(
                                              provider.weather!.description,
                                              style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ),
                                    Container(
                                      height: MediaQuery.of(context).size.height*0.1,
                                      width: MediaQuery.of(context).size.width/2.2,
                                      child: Card(
                                        color: Colors.blue[50],
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("Temperature",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),),
                                            Center(
                                              child: Text(Provider.of<SettingsModel>(context).temperatureUnit=="Celsius"?
                                                '${provider.weather!.temperature}°C':provider.toForenheit(provider.weather!.temperature),
                                                style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),

                  /*// Five-day Forecast Line Chart
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('5-Day Temperature Forecast', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 38,
                              getTitlesWidget: (value, meta) {
                                // Customize x-axis labels
                                final index = value.toInt();
                                if (index < provider.forecast.length) {
                                  return Transform.rotate(
                                      angle:  0,
                                      child: Text(provider.forecast[index].date.substring(8, 10))); // Show date
                                }
                                return Container();
                              },
                            ),
                          ),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))
                        ),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: provider.forecast
                                .asMap()
                                .entries
                                .map((entry) => FlSpot(entry.key.toDouble(), entry.value.temperature))
                                .toList(),
                            isCurved: true,
                            color: Colors.blue,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),*/

                  // Five-day Forecast
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('5-Day Forecast', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.2,
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.forecast.length,
                      itemBuilder: (context, index) {
                        final forecast = provider.forecast[index];
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width/3,
                            height: MediaQuery.of(context).size.height/5,
                            child: Card(
                              color: Colors.blue[50],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(forecast.condition,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.025),),
                                  Text(Provider.of<SettingsModel>(context).temperatureUnit=="Celsius"?
                                    '${forecast.temperature}°C':'${provider.toForenheit(forecast.temperature)}'
                                    ,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.06),),
                                  Text(forecast.date,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.025)),
                                ],
                              )
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text('News:', style: TextStyle(fontSize: 20)),
                  if (provider.news == null)
                    CircularProgressIndicator()
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.news!.length,
                        itemBuilder: (context, index) {
                          final news = provider.news![index];
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ListTile(
                              title: Text(news.title),
                              subtitle: Text(news.description),
                              tileColor: Colors.blue[50],
                              onTap: () async {
                                final Uri uri = Uri.parse(news.url);
                                try{
                                  if (!await launchUrl(uri)) {
                                    throw 'Could not launch ${news.url}';
                                  }
                                }catch(e){
                                  print('Error launching URL: $e');
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

