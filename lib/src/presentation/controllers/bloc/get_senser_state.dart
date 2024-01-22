part of 'get_senser_bloc.dart';

sealed class GetSenserState extends Equatable {
  const GetSenserState();

  @override
  List<Object> get props => [];
}

final class GetSenserInitial extends GetSenserState {}

final class GetSenser extends GetSenserState {
  final ValueNotifier<String> valueNotifier = ValueNotifier<String>('');
  final List<TextEditingController> textEditingControllers;
  final List<bool> isEditingStates;
  final List<SensorModel> listSensorModel;
  final List<bool> expandableState;
  final int itemCount;

  GetSenser({
    required this.listSensorModel,
    required this.expandableState,
    required this.itemCount,
    required this.textEditingControllers,
    required this.isEditingStates,
  });

  void updateName(
    String newName,
    int index,
  ) {
    listSensorModel[index] = listSensorModel[index].copyWith(name: newName);
  }
}

final class GetSenserError extends GetSenserState {
  final String errorStr;

  const GetSenserError({
    required this.errorStr,
  });
}
