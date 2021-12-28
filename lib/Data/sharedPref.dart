import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;
  factory SharedPrefs() => SharedPrefs._internal();
  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }


  String getprofileImg() {
    return _sharedPrefs.getString("profileImg") ?? "";
  } 

  // ignore: avoid_return_types_on_setters
  setProfileImg(String value) {
    _sharedPrefs.setString("profileImg", value);
  }
}

final sharedPrefs = SharedPrefs();
// constants/strings.dart
const String profileImg = "profileImg";