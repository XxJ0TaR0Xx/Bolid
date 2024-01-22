import 'dart:async';

import 'package:bolid/src/data/repositories/sensor_repositore_impl.dart';
import 'package:bolid/src/domain/repositories/sensor_repository.dart';
import 'package:bolid/src/presentation/controllers/bloc/get_senser_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt services = GetIt.I;

FutureOr<void> initServices() async {
  services.registerLazySingleton<Dio>(() => Dio());
  final Dio dio = services<Dio>();

  /// Reposotory
  services.registerLazySingleton<SensorRepositorty>(() => SensorRepositorty(dio));
  services.registerLazySingleton<SensorRepositoriImpl>(() => SensorRepositoriImpl());

  services.registerLazySingleton<GetSenserBloc>(() => GetSenserBloc()..add(InitGetSenserEvent()));
}
