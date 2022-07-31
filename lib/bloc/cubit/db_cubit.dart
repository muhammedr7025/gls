import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:email_password_login/model/db_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'db_state.dart';

class DbCubit extends Cubit<DbState> {
  DbCubit() : super(DbInitial());
  DbModel? db;

  fetchdb() async {
    emit(DbInitial());
    emit(Dbloading());
    var url = 'https://gls-app-566d3-default-rtdb.firebaseio.com/gls.json';
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data.isEmpty) {
        return;
      }
      final res = DbModel.fromMap(data);
      db = res;
      log(res.toString());
      emit(DbLoaded(db: res));
    } catch (e) {
      emit(DbFailed(error: e.toString()));
    }
  }

  create(bool value) async {
    emit(DbInitial());
    emit(Dbloading());
    var url = 'https://gls-app-566d3-default-rtdb.firebaseio.com/gls.json';
    try {
      print(value);
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({'nob': true}),
      );
      emit(DbLoaded(db: db!));
    } catch (e) {
      emit(DbFailed(error: e.toString()));
    }
  }
}
