part of 'get_senser_bloc.dart';

sealed class GetSenserState extends Equatable {
  const GetSenserState();

  @override
  List<Object> get props => [];
}

final class InitialGetSenser extends GetSenserState {}

final class SensorModelGetSenser extends GetSenserState {
  final List<SensorInfo> listSensorInfo;

  const SensorModelGetSenser({
    required this.listSensorInfo,
  });
}

class SensorInfo {
  TextEditingController textEditingController;
  bool isEditingStates;
  SensorModel model;
  bool expandableState;
  SensorInfo({
    required this.textEditingController,
    required this.isEditingStates,
    required this.model,
    required this.expandableState,
  });
}

final class ErrorGetSenser extends GetSenserState {
  final String errorStr;

  const ErrorGetSenser({
    required this.errorStr,
  });
}
