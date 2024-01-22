import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

part 'sensor_repository.g.dart';

@RestApi(baseUrl: 'https://file.notion.so/f/f')
abstract class SensorRepositorty {
  factory SensorRepositorty(Dio dio, {String baseUrl}) = _SensorRepositorty;

  @GET('/216de177-6269-4124-912b-88f16b5e3e0f/8f9a9f95-18b6-4da6-a01f-eded120a92be/events.json?id=01f43ab4-22ed-496b-b7de-86c25b39cd48&table=block&spaceId=216de177-6269-4124-912b-88f16b5e3e0f&expirationTimestamp=1705953600000&signature=UlcrmwuCgKtT4-lQCQYhIwSuTFHT1JCk_YD7NV8F_GA&downloadName=events.json')
  Future<List<SensorModel>> getSensorModels();
}

@JsonSerializable()
class SensorModel {
  @JsonKey(name: 'sensor_id')
  final int sensorId;
  final String name;
  final int status;
  final int? temperature;
  final int? humidity;

  SensorModel({
    required this.sensorId,
    required this.name,
    required this.status,
    this.temperature,
    this.humidity,
  });

  factory SensorModel.fromJson(Map<String, dynamic> json) => _$SensorModelFromJson(json);

  Map<String, dynamic> toJson() => _$SensorModelToJson(this);

  SensorModel copyWith({
    int? sensorId,
    String? name,
    int? status,
    int? temperature,
    int? humidity,
  }) {
    return SensorModel(
      sensorId: sensorId ?? this.sensorId,
      name: name ?? this.name,
      status: status ?? this.status,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
    );
  }
}
