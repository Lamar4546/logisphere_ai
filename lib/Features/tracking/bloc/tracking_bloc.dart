import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

// Define Tracking Events
abstract class TrackingEvent {}
class ConnectToTelemetryStream extends TrackingEvent {}
class UpdateShipmentLocation extends TrackingEvent {
  final Map<String, dynamic> telemetryData;
  UpdateShipmentLocation(this.telemetryData);
}

// Define Tracking States
abstract class TrackingState {}
class TrackingInitial extends TrackingState {}
class TrackingConnected extends TrackingState {
  final List<Map<String, dynamic>> activeVessels;
  TrackingConnected(this.activeVessels);
}

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  WebSocketChannel? _channel;
  final List<Map<String, dynamic>> _vesselCache = [];

  TrackingBloc() : super(TrackingInitial()) {
    on<ConnectToTelemetryStream>((event, emit) async {
      // Connect to your real-time backend stream
      _channel = WebSocketChannel.connect(
        Uri.parse('wss://api.logisphere.ai/v1/telemetry/live'),
      );

      _channel?.stream.listen((message) {
        final data = jsonDecode(message);
        add(UpdateShipmentLocation(data));
      });
    });

    on<UpdateShipmentLocation>((event, emit) {
      final updatedIndex = _vesselCache.indexWhere((element) => element['id'] == event.telemetryData['id']);
      if (updatedIndex != -1) {
        _vesselCache[updatedIndex] = event.telemetryData;
      } else {
        _vesselCache.add(event.telemetryData);
      }
      emit(TrackingConnected(List.from(_vesselCache)));
    });
  }

  @override
  Future<void> close() {
    _channel?.sink.close();
    return super.close();
  }
}