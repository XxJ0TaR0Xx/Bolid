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
  GetSenserBloc() : super(InitialGetSenser()) {
    on<InitGetSenserEvent>(_onInitGetSenserEvent);
    on<ChangeNameSensorEvent>(_onChangeNameSensorEvent);
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
          ErrorGetSenser(
            errorStr: failure.toString(),
          ),
        );
      },
      (list) {
        final List<TextEditingController> textEditingControllers = List.generate(list.length, (index) => TextEditingController());
        final List<bool> expandableState = List.generate(list.length, (index) => false);
        final List<bool> isEditingStates = List.generate(list.length, (index) => false);

        List<SensorInfo> listSensorInfo = [];
        int index = 0;

        for (var e in list) {
          listSensorInfo.add(
            SensorInfo(
              textEditingController: textEditingControllers[index],
              isEditingStates: isEditingStates[index],
              model: SensorModel(
                name: e.name,
                sensorId: e.sensorId,
                status: e.status,
                humidity: e.humidity,
                temperature: e.temperature,
              ),
              expandableState: expandableState[index],
            ),
          );
          index++;
        }

        emit(
          SensorModelGetSenser(listSensorInfo: listSensorInfo),
        );
      },
    );
  }

  FutureOr<void> _onChangeNameSensorEvent(
    ChangeNameSensorEvent event,
    Emitter<GetSenserState> emit,
  ) {
    final currentState = (state as SensorModelGetSenser);
    final oldName = currentState.listSensorInfo[event.index].model.name;
    if (event.newName != oldName) {
      print("value name old ${currentState.listSensorInfo[event.index].model.name.toString()}");

      SensorModel sensorModel = currentState.listSensorInfo[event.index].model.copyWith(name: event.newName);
      currentState.listSensorInfo[event.index].model = sensorModel;
      print("value name new ${currentState.listSensorInfo[event.index].model.name.toString()}");

      emit(SensorModelGetSenser(listSensorInfo: currentState.listSensorInfo));
    }
  }
}
