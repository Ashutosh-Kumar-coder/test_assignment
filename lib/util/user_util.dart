import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testassignment/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserUtil {
  static List<UserModel> userList = [];

  static Future<List<UserModel>> getUser() async {
    var prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.containsKey("user")) {
        print("if");
        var decodeData = json.decode(prefs.getString("user")!);
        List<dynamic> list =
            decodeData.map((result) => new UserModel.fromJson(result)).toList();
        userList.clear();
        for (int b = 0; b < list.length; b++) {
          UserModel userModel = list[b] as UserModel;
          userList.add(userModel);
        }
        return userList;
      } else {
        print("else");
        var request = http.Request(
            'GET', Uri.parse('https://jsonplaceholder.typicode.com/users'));

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          var data = await response.stream.bytesToString();
          var decodeData = jsonDecode(data);
          List<dynamic> list = decodeData
              .map((result) => new UserModel.fromJson(result))
              .toList();
          userList.clear();
          for (int b = 0; b < list.length; b++) {
            UserModel userModel = list[b] as UserModel;
            userList.add(userModel);
            saveData(userList);
          }
          return userList;
        } else {
          print(response.reasonPhrase);
          return [];
        }
      }
    } catch (e) {
      print("Exception in get User $e");
      return [];
    }
  }

  static saveData(value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("user", json.encode(value));
    } catch (e) {
      print("Exception____D___$e");
    }
  }
}
