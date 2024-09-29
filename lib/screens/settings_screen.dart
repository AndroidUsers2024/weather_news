import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_model.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        children: [
          // Temperature Unit Selection
          ListTile(
            title: Text('Temperature Unit'),
            subtitle: Text(settings.temperatureUnit),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Select Temperature Unit'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('Celsius'),
                          onTap: () {
                            settings.setTemperatureUnit('Celsius');
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          title: Text('Fahrenheit'),
                          onTap: () {
                            settings.setTemperatureUnit('Fahrenheit');
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          Divider(),
          // News Category Selection
          Text('Select News Categories'),
          Expanded(
            child: ListView(
              children: [
                ...['Technology', 'Health', 'Science', 'Business'].map((category) {
                  return CheckboxListTile(
                    title: Text(category),
                    value: settings.selectedCategory==category,
                    onChanged: (value) {
                      settings.toggleCategory(category);
                    },
                  );
                }).toList(),
              ],
            ),
          ),

          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Save"))
        ],
      ),
    );
  }
}
