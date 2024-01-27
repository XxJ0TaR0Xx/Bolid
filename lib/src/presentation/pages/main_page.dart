import 'package:bolid/core/services.dart';
import 'package:bolid/src/presentation/controllers/bloc/get_senser_bloc.dart';
import 'package:bolid/src/presentation/pages/home_page.dart';
import 'package:bolid/src/presentation/pages/initila_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetSenserBloc, GetSenserState>(
        bloc: services<GetSenserBloc>(),
        builder: (context, state) {
          switch (state) {
            case InitialGetSenser():
              return const InitialHomeWidget();
            case SensorModelGetSenser():
              final SensorModelGetSenser getSenserState = state;
              return HomePage(
                listSensorInfo: getSenserState.listSensorInfo,
              );
            case ErrorGetSenser():
              final ErrorGetSenser getSenserError = state;
              return AboutDialog(
                applicationName: getSenserError.errorStr,
              );
          }
        },
      ),
    );
  }
}
