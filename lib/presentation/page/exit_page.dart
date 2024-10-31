import 'package:carpark_display/presentation/bloc/gate_bloc.dart';
import 'package:carpark_display/presentation/widget/exit_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullscreen_window/fullscreen_window.dart';

class ExitPage extends StatefulWidget {
  const ExitPage({super.key});

  @override
  State<ExitPage> createState() => _ExitPageState();
}

class _ExitPageState extends State<ExitPage> {
  late final GateBloc _gateBloc;

  @override
  void initState() {
    super.initState();
    _gateBloc = context.read<GateBloc>()..add(const Load());
    _gateBloc.add(const Subscribe());
    FullScreenWindow.setFullScreen(true);
  }

  @override
  void dispose() {
    _gateBloc.add(const Unsubscribe());
    FullScreenWindow.setFullScreen(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GateBloc, GateState>(builder: (context, state) {
      if (state.gateOut == null) {
        return Scaffold(appBar: AppBar(), body: Container());
      }
      return ExitDisplay(gateLog: state.gateOut!);
    }, listener: (context, state) {
      if (state.loadingResult.error != null) {
        _gateBloc.add(const ClearError());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to perform this action'),
          ),
        );
      }
      if (state.loadingResult.value != null) {
        _gateBloc.add(const ClearError());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.loadingResult.value!),
          ),
        );
      }
    });
  }
}
