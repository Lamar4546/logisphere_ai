import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../bloc/tracking_bloc.dart';

class MapVisibilityView extends StatelessWidget {
  const MapVisibilityView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrackingBloc()..add(ConnectToTelemetryStream()),
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        body: BlocBuilder<TrackingBloc, TrackingState>(
          builder: (context, state) {
            if (state is TrackingInitial) {
              return const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6)));
            }
            
            if (state is TrackingConnected) {
              return Row(
                children: [
                  // Active Shipments Inventory Split View
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: const Color(0xFF020617),
                      child: ListView.builder(
                        itemCount: state.activeVessels.length,
                        itemBuilder: (context, index) {
                          final item = state.activeVessels[index];
                          return ListTile(
                            leading: const Icon(Icons.directions_boat_filled_rounded, color: Color(0xFF3B82F6)),
                            title: Text(item['name'] ?? 'Unknown Cargo'),
                            subtitle: Text('ETA: ${item['eta'] ?? "Calculating..."}'),
                            trailing: Text(item['status'] ?? 'Transit', style: const TextStyle(color:  Color(0xFF10B981))),
                          );
                        },
                      ),
                    ),
                  ),
                  // Map Engine Implementation
                  Expanded(
                    flex: 3,
                    child: GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(30.0, -40.0), // Central Atlantic trade lane coordinates
                        zoom: 3,
                      ),
                      markers: state.activeVessels.map((vessel) {
                        return Marker(
                          markerId: MarkerId(vessel['id'].toString()),
                          position: LatLng(vessel['lat'] ?? 0.0, vessel['lng'] ?? 0.0),
                          infoWindow: InfoWindow(title: vessel['name'], snippet: 'Status: ' + vessel['status']),
                        );
                      }).toSet(),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('Data Connection Disconnected'));
          },
        ),
      ),
    );
  }
}