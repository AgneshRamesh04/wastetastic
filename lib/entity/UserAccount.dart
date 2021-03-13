import 'package:wastetastic/entity/WastePOI.dart';
import 'package:wastetastic/entity/WasteRecord.dart';

class UserAccount {
  String _username;
  String _email;
  String _password;
  String _name;
  List<WastePOI> _favorites = List<WastePOI>(5);
  List<WasteRecord> _waste_records;
  int _points;

  UserAccount({
    String username,
    String email,
    String password,
    String name,
  })  : _username = username,
        _email = email,
        _password = password,
        _name = name;

  String get username => _username;
  String get email => _email;
  String get name => _name;
  List<WastePOI> get favorites => _favorites;
  List<WasteRecord> get waste_records => _waste_records;
  int get points => _points;

  set username(String username) {
    _username = username;
  }

  set email(String email) {
    _email = email;
  }

  set name(String name) {
    _name = name;
  }

  set favorites(List<WastePOI> favorites) {
    _favorites = favorites;
  }

  set waste_records(List<WasteRecord> waste_records) {
    _waste_records = waste_records;
  }

  set points(int points) {
    _points = points;
  }

  void printUserDetails() {
    print("Username: " + _username);
    print("Email: " + _email);
    print("Name: " + _name);
    print("Favorites: ");
    for (WastePOI fav in _favorites) {
      fav.printDetails();
    }
    print("Waste Records: ");
    for (WasteRecord wr in _waste_records) {
      wr.printDetails();
    }
  }
}
