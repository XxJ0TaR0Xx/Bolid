part of 'get_senser_bloc.dart';

sealed class GetSenserEvent extends Equatable {
  const GetSenserEvent();

  @override
  List<Object> get props => [];
}

final class InitGetSenserEvent extends GetSenserEvent {}
