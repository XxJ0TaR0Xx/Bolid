// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorModel _$SensorModelFromJson(Map<String, dynamic> json) => SensorModel(
      sensorId: json['sensor_id'] as int,
      name: json['name'] as String,
      status: json['status'] as int,
      temperature: json['temperature'] as int?,
      humidity: json['humidity'] as int?,
    );

Map<String, dynamic> _$SensorModelToJson(SensorModel instance) =>
    <String, dynamic>{
      'sensor_id': instance.sensorId,
      'name': instance.name,
      'status': instance.status,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _SensorRepositorty implements SensorRepositorty {
  _SensorRepositorty(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://file.notion.so/f/f';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<SensorModel>> getSensorModels() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<SensorModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/216de177-6269-4124-912b-88f16b5e3e0f/8f9a9f95-18b6-4da6-a01f-eded120a92be/events.json?id=01f43ab4-22ed-496b-b7de-86c25b39cd48&table=block&spaceId=216de177-6269-4124-912b-88f16b5e3e0f&expirationTimestamp=1705953600000&signature=UlcrmwuCgKtT4-lQCQYhIwSuTFHT1JCk_YD7NV8F_GA&downloadName=events.json',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => SensorModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
