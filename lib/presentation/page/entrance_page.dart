import 'package:carpark_display/presentation/bloc/gate_bloc.dart';
import 'package:carpark_display/presentation/widget/entrance_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntrancePage extends StatefulWidget {
  const EntrancePage({super.key});

  @override
  State<EntrancePage> createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {
  late final GateBloc _gateBloc;

  @override
  void initState() {
    super.initState();
    _gateBloc = context.read<GateBloc>()..add(const Load());
    _gateBloc.add(const Subscribe());
  }

  @override
  void dispose() {
    _gateBloc.add(const Unsubscribe());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GateBloc, GateState>(builder: (context, state) {
      if (state.gateIn == null) {
        return Scaffold(appBar: AppBar(), body: Container());
      }
      return EntranceDisplay(gateLog: state.gateIn!);
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
