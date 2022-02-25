import 'package:flutter/cupertino.dart';
import 'package:flutter_graphql_api_integration/models/history_model.dart';
import 'package:flutter_graphql_api_integration/models/upcoming_model.dart';
import 'package:flutter_graphql_api_integration/models/users_model.dart';
import 'package:flutter_graphql_api_integration/services/queries_mutations.dart';

class Services {
  QueriesMutations _queries = QueriesMutations();

  Future<UsersModel> fetchUsers() async {
    try {
      var data = await _queries.getUsers();
      return UsersModel.fromJson(data);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<UpComingModel> fetchUpComing() async {
    try {
      var data = await _queries.getUpComing();
      return UpComingModel.fromJson(data);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<HistoryModel> fetchHistory() async {
    try {
      var data = await _queries.getHistory();
      return HistoryModel.fromJson(data);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> addUser({String name, String rocket, String twitter}) async {
    try {
      await _queries.addUser(name: name, rocket: rocket, twitter: twitter);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _queries.deleteUser(id);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateUser(
      {String id, String name, String rocket, String twitter}) async {
    try {
      await _queries.updateUser(
          id: id, name: name, rocket: rocket, twitter: twitter);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
