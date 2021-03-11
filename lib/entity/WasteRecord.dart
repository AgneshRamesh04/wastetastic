import 'package:wastetastic/entity/WasteCategory.dart';

class WasteRecord {
  DateTime _dateTime;
  WasteCategory _category;
  double _weight;

  WasteRecord({
    DateTime dateTime,
    WasteCategory category,
    double weight,
  })  : _dateTime = dateTime,
        _category = category,
        _weight = weight;

  DateTime get dateTime => _dateTime;
  WasteCategory get category => _category;
  double get weight => _weight;

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
    print('Date and Time: ' + _dateTime.toString());
    print('Waste Category: ' + _category.toString());
    print('Weight: ' + _weight.toString());
  }
}
