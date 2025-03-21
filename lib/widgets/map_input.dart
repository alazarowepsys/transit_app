import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapInput extends StatefulWidget {
  const MapInput({super.key});

  @override
  State<MapInput> createState() => _MapInputState();
}

class _MapInputState extends State<MapInput> {
  LatLng? selectedLocation;
  late LocationData _locationData;

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(
          _locationData.latitude!,
          _locationData.longitude!,
        ),
        initialZoom: 13,
        onTap: (tapPosition, point) {
          setState(() {
            selectedLocation = point;
          });
        },
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        ),
        if (selectedLocation != null)
          MarkerLayer(
            markers: [
              Marker(
                point: selectedLocation!,
                width: 50,
                height: 50,
                child: Icon(Icons.location_on, color: Colors.red, size: 40),
              ),
            ],
          ),
      ],
    );
  }
}
