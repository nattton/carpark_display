import 'package:carpark_display/presentation/bloc/gate_bloc.dart';
import 'package:carpark_display/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GateBloc(
        apiRepository: GetIt.I.get(),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Car Park Display',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
            brightness: Brightness.dark,
          ),
          fontFamily: 'Prompt',
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
