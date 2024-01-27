import 'package:bolid/core/services.dart';
import 'package:bolid/src/presentation/controllers/bloc/get_senser_bloc.dart';
import 'package:bolid/src/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services<GetSenserBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const MainPage(),
      ),
    );
  }
}
