import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carpark_display/common/config/constant.dart';
import 'package:carpark_display/common/model/delayed_result.dart';
import 'package:carpark_display/data/model/gate_log.dart';
import 'package:carpark_display/domain/model/gate_model.dart';
import 'package:carpark_display/domain/repository/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'gate_event.dart';
part 'gate_state.dart';

const wsUrl = '$kHostWS/ws';

class GateBloc extends Bloc<GateEvent, GateState> {
  final ApiRepository _apiRepository;

  late WebSocket channel;

  GateBloc({required ApiRepository apiRepository})
      : _apiRepository = apiRepository,
        super(const GateState(loadingResult: DelayedResult.idle())) {
    on<Load>(_onLoad);
    on<Subscribe>(_onSubscribe);
    on<Unsubscribe>(_onUnsubscribe);
    on<ClearError>(_onClearError);
    on<GateInChanged>(_onGateInChanged);
    on<GateOutChanged>(_onGateOutChanged);
  }

  FutureOr<void> _onLoad(Load event, Emitter<GateState> emit) async {
    try {
      emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
      final lastGate = await _apiRepository.getLastGate();
      emit(state.copyWith(gateIn: lastGate.gateIn, gateOut: lastGate.gateOut));
      emit(state.copyWith(loadingResult: const DelayedResult.idle()));
    } on Exception catch (e) {
      emit(state.copyWith(loadingResult: DelayedResult.fromError(e)));
    }
  }

  FutureOr<void> _onSubscribe(Subscribe event, Emitter<GateState> emit) async {
    if (kIsWeb) {
      initWebSocketChannelConnection();
    } else {
      initWebSocketConnection();
    }
  }

  FutureOr<void> _onUnsubscribe(Unsubscribe event, Emitter<GateState> emit) {
    if (!kIsWeb) {
      channel.close();
    }
  }

  initWebSocketChannelConnection() async {
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(wsUrl));
    channel.stream.listen((streamData) {
      _updateStream(streamData);
    });
  }

  void initWebSocketConnection() async {
    print('connecting...');
    channel = await connectWs();
    print("socket connection initializied");
    channel.done.then((dynamic _) => _onDisconnected());
    broadcastNotifications();
  }

  Future<WebSocket> connectWs() async {
    try {
      return await WebSocket.connect(wsUrl);
    } catch (e) {
      print("Error! can not connect WS connectWs $e");
      await Future.delayed(const Duration(milliseconds: 5000));
      return await connectWs();
    }
  }

  void _onDisconnected() {
    initWebSocketConnection();
  }

  broadcastNotifications() {
    channel.listen((streamData) {
      _updateStream(streamData);
    }, onDone: () {
      print("conecting aborted");
      initWebSocketConnection();
    }, onError: (e) {
      print('Server error: $e');
      initWebSocketConnection();
    });
  }

  void _updateStream(dynamic streamData) {
    print(streamData);
    final gateLog = GateLog.fromJson(jsonDecode(streamData)).toGateModel();
    if (gateLog.gateName == 'in') {
      add(GateInChanged(gateIn: gateLog));
    } else if (gateLog.gateName == 'out') {
      add(GateOutChanged(gateOut: gateLog));
    }
  }

  FutureOr<void> _onClearError(ClearError event, Emitter<GateState> emit) {
    emit(state.copyWith(loadingResult: const DelayedResult.idle()));
  }

  FutureOr<void> _onGateInChanged(
      GateInChanged event, Emitter<GateState> emit) {
    emit(state.copyWith(gateIn: event.gateIn));
  }

  FutureOr<void> _onGateOutChanged(
      GateOutChanged event, Emitter<GateState> emit) {
    emit(state.copyWith(gateOut: event.gateOut));
  }
}
