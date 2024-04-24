import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LayoutPercentageProvider extends ChangeNotifier {
  late double _layoutPercentage;
  final _prefsKey = 'layoutPercentage';

  double get layoutPercentage => _layoutPercentage;

  LayoutPercentageProvider() {
    _layoutPercentage = 1.0;
    _loadLayoutPercentage();
  }

  Future<void> _loadLayoutPercentage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _layoutPercentage = prefs.getDouble(_prefsKey) ?? 1.0;
    notifyListeners();
  }

  Future<void> _saveLayoutPercentage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_prefsKey, _layoutPercentage);
  }

  void setLayoutPercentage(double percentage) {
    _layoutPercentage = percentage;
    _saveLayoutPercentage();
    notifyListeners();
  }
}

class FontStyleProvider extends ChangeNotifier {
  late String _style;
  final _prefsKey = 'style';

  String get fontStyle => _style;

  FontStyleProvider() {
    _style = 'regular';
    _loadLayoutPercentage();
  }

  Future<void> _loadLayoutPercentage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _style = prefs.getString(_prefsKey) ?? 'regular';
    notifyListeners();
  }

  Future<void> _saveLayoutPercentage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, _style);
  }

  void setLayoutPercentage(String style) {
    _style = style;
    _saveLayoutPercentage();
    notifyListeners();
  }
}

class BorderLineProvider extends ChangeNotifier {
  late int _border;
  final _prefsKey = 'border';

  int get border => _border;

  LayoutPercentageProvider() {
    _border = 1;
    _loadLayoutPercentage();
  }

  Future<void> _loadLayoutPercentage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _border = prefs.getInt(_prefsKey) ?? 1;
    notifyListeners();
  }

  Future<void> _saveLayoutPercentage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefsKey, _border);
  }

  void setLayoutPercentage(int value) {
    _border = value;
    _saveLayoutPercentage();
    notifyListeners();
  }
}
