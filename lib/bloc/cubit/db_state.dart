part of 'db_cubit.dart';

@immutable
abstract class DbState {}

class DbInitial extends DbState {}

class Dbloading extends DbState {}

class DbLoaded extends DbState {
  final DbModel db;
  DbLoaded({
    required this.db,
  });
}

class DbFailed extends DbState {
  final String error;
  DbFailed({
    required this.error,
  });
}
