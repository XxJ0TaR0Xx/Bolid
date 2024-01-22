import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bolid/core/failure.dart';
import 'package:bolid/core/services.dart';
import 'package:bolid/src/data/repositories/sensor_repositore_impl.dart';
import 'package:bolid/src/domain/repositories/sensor_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'get_senser_event.dart';
part 'get_senser_state.dart';

class GetSenserBloc extends Bloc<GetSenserEvent, GetSenserState> {
  GetSenserBloc() : super(GetSenserInitial()) {
    on<InitGetSenserEvent>(_onInitGetSenserEvent);
  }

  FutureOr<void> _onInitGetSenserEvent(
    GetSenserEvent event,
    Emitter<GetSenserState> emit,
  ) async {
    final SensorRepositoriImpl sensorRepositoreImpl = services<SensorRepositoriImpl>();
    final Either<Failure, List<SensorModel>> serverOrFailure0 = await sensorRepositoreImpl.getSensorModels();

    serverOrFailure0.fold(
      (failure) {
        emit(
          GetSenserError(
            errorStr: failure.toString(),
          ),
        );
      },
      (list) {
        final int itemCount = list.length;
        final List<bool> expandableState = List.generate(itemCount, (index) => false);
        final List<TextEditingController> textEditingControllers = List.generate(itemCount, (index) => TextEditingController());
        final List<bool> isEditingStates = List.generate(itemCount, (index) => false);

        emit(
          GetSenser(
            listSensorModel: list,
            expandableState: expandableState,
            itemCount: itemCount,
            textEditingControllers: textEditingControllers,
            isEditingStates: isEditingStates,
          ),
        );
      },
    );
  }
}
