import 'package:equatable/equatable.dart';

class Sensor extends Equatable {
  final String sensorId;
  final String name;
  final int status;
  final int? temperature;
  final int? humidity;

  const Sensor({
    required this.sensorId,
    required this.name,
    required this.status,
    this.temperature,
    this.humidity,
  });

  @override
  List<Object?> get props => [sensorId];
}
