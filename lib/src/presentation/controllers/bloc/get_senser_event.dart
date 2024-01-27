part of 'get_senser_bloc.dart';

sealed class GetSenserEvent extends Equatable {
  const GetSenserEvent();

  @override
  List<Object> get props => [];
}

final class InitGetSenserEvent extends GetSenserEvent {}

final class ChangeNameSensorEvent extends GetSenserEvent {
  final String newName;
  final int index;

  const ChangeNameSensorEvent({
    required this.newName,
    required this.index,
  });
}
