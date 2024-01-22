import 'package:bolid/core/failure.dart';
import 'package:bolid/core/services.dart';
import 'package:bolid/src/data/failure/failure_data.dart';
import 'package:bolid/src/domain/repositories/sensor_repository.dart';
import 'package:dartz/dartz.dart';

class SensorRepositoriImpl {
  final SensorRepositorty sensorRepositorty = services<SensorRepositorty>();

  Future<Either<Failure, List<SensorModel>>> getSensorModels() async {
    try {
      List<SensorModel> listSensorModels = await sensorRepositorty.getSensorModels();

      return Right(listSensorModels);
    } catch (e) {
      return Left(FailureData(errorStr: e));
    }
  }
}
