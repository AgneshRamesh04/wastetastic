import 'package:wastetastic/entity/WasteCategory.dart';

class WasteRecord {
  String _username;
  DateTime _dateTime;
  WasteCategory _category;
  double _weight;

  WasteRecord({
    String username,
    DateTime dateTime,
    WasteCategory category,
    double weight,
  })  : _username = username,
        _dateTime = dateTime,
        _category = category,
        _weight = weight;

  String get username => _username;
  DateTime get dateTime => _dateTime;
  WasteCategory get category => _category;
  double get weight => _weight;

  set username(String username) {
    _username = username;
  }

  set dateTime(DateTime dateTime) {
    _dateTime = dateTime;
  }

  set category(WasteCategory category) {
    _category = category;
  }

  set weight(double weight) {
    _weight = weight;
  }

  void printDetails() {
    print('Username: ' + _username);
    print('Date and Time: ' + _dateTime.toString());
    print('Waste Category: ' + _category.toString());
    print('Weight: ' + _weight.toString());
  }
}
