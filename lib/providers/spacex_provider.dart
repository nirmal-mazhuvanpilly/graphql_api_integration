import 'package:flutter/material.dart';
import 'package:flutter_graphql_api_integration/models/history_model.dart';
import 'package:flutter_graphql_api_integration/models/upcoming_model.dart';
import 'package:flutter_graphql_api_integration/models/users_model.dart';
import 'package:flutter_graphql_api_integration/services/services.dart';

class SpaceXProvider with ChangeNotifier {
  Services _services = Services();

  UsersModel _usersModel;
  UsersModel get usersModel => _usersModel;

  set usersModel(UsersModel usersModel) {
    _usersModel = usersModel;
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    usersModel = await _services.fetchUsers();
    notifyListeners();
  }

  UpComingModel _upComingModel;
  UpComingModel get upComingModel => _upComingModel;

  set upComingModel(UpComingModel upComingModel) {
    _upComingModel = upComingModel;
    notifyListeners();
  }

  Future<void> fetchUpComing() async {
    upComingModel = await _services.fetchUpComing();
    notifyListeners();
  }

  HistoryModel _historyModel;
  HistoryModel get historyModel => _historyModel;

  set historyModel(HistoryModel historyModel) {
    _historyModel = historyModel;
    notifyListeners();
  }

  Future<void> fetchHistory() async {
    historyModel = await _services.fetchHistory();
    notifyListeners();
  }

  Future<void> addUser({String name, String rocket, String twitter}) async {
    await _services.addUser(name: name, rocket: rocket, twitter: twitter);
    notifyListeners();
  }

  Future<void> deleteUser(String id) async {
    await _services.deleteUser(id);
    notifyListeners();
  }

  Future<void> updateUser(
      {String id, String name, String rocket, String twitter}) async {
    await _services.updateUser(
        id: id, name: name, rocket: rocket, twitter: twitter);
    notifyListeners();
  }
}
