import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel extends ChangeNotifier {
  String _temperatureUnit = 'Celsius';
  String _selectedCategory = "";

  String get temperatureUnit => _temperatureUnit;
  String get selectedCategory => _selectedCategory;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _temperatureUnit = prefs.getString('temperatureUnit') ?? 'Celsius';
    // _selectedCategory = prefs.getString('selectedCategories') ?? '';
    notifyListeners();
  }

  Future<void> setTemperatureUnit(String unit) async {
    _temperatureUnit = unit;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('temperatureUnit', unit);
    notifyListeners();
  }

  Future<void> toggleCategory(String category) async {
    _selectedCategory = category;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCategories', _selectedCategory);
    notifyListeners();
  }
}
