import 'dart:async';
import 'dart:math';

import 'package:dobareh_bloc/presentation/components/general/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';

import '../../../data/model/order/order_response.dart';
import '../../../utils/colors.dart';
import '../../../utils/location_geolocator.dart';

class OpenStreetWidget extends StatefulWidget {
  const OpenStreetWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  State<OpenStreetWidget> createState() => _OpenStreetWidgetState();
}

class _OpenStreetWidgetState extends State<OpenStreetWidget> {
  LatLngBounds? bounds;
  List<Marker> markers = [];
  late Polyline polyline;

  // HomeLargeMapViewModel homeLargeMapViewModel = HomeLargeMapViewModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initValues(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return FlutterMap(
            options: MapOptions(
              center:
                  LatLng(markers[0].point.latitude, markers[0].point.longitude),
              zoom: 12,
              bounds: bounds,
            ),
            children: [
              TileLayer(
                tileSize: 256,
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              PolylineLayer(
                polylines: [polyline],
              ),
              MarkerLayer(
                rotate: true,
                markers: markers,
              ),
            ],
          );
        } else {
          return const Center(child: LoadingWidget());
        }
      },
    );
  }

  Future<bool> initValues() async {
    await createMarker();
    var selectedOrder = widget.order;
    await getPolyline(double.parse(selectedOrder.address!.latitude!),
        double.parse(selectedOrder.address!.longitude!));
    await createBounds();
    return true;
  }

  Future<void> createMarker() async {
    var currentLocations = await determinePosition();
    // var myLocation = await LocationService().getLocation();

    markers.add(Marker(
        width: 32.w,
        height: 32.h,
        // point: LatLng(myLocation.latitude ??0, myLocation.longitude ??0),
        point: LatLng(currentLocations.latitude, currentLocations.longitude),
        builder: (context) {
          return SvgPicture.asset("assets/icons/my_location.svg");
        }));
    var item = widget.order;

    double latitude = double.parse(item.address?.latitude ?? "0");
    double longitude = double.parse(item.address?.longitude ?? "0");
    markers.add(Marker(
        width: 48.w,
        height: 48.h,
        point: LatLng(latitude, longitude),
        builder: (context) {
          return SvgPicture.asset("assets/images/marker.svg");
        }));
  }

  Future<void> createBounds() async {
    var longs = markers.map((e) => e.point.longitude);
    var latis = markers.map((e) => e.point.latitude);

    double topMost = longs.reduce(max);
    double leftMost = latis.reduce(min);
    double rightMost = latis.reduce(max);
    double bottomMost = longs.reduce(min);

    bounds = LatLngBounds(
      LatLng(rightMost, topMost),
      LatLng(leftMost, bottomMost),
    );
  }

  Future<void> getPolyline(double endLat, double endLng) async {
    // Initialize the openrouteservice with your API key.
    final OpenRouteService client = OpenRouteService(
        apiKey: '5b3ce3597851110001cf624852fa353744464ff0b50de2c992d27769');

    var currentPosition = await determinePosition();
    // Form Route between coordinates
    final List<ORSCoordinate> routeCoordinates =
        await client.directionsRouteCoordsGet(
      startCoordinate: ORSCoordinate(
          latitude: currentPosition.latitude,
          longitude: currentPosition.longitude),
      endCoordinate: ORSCoordinate(latitude: endLat, longitude: endLng),
    );

    // Map route coordinates to a list of LatLng (requires google_maps_flutter package)
    // to be used in the Map route Polyline.
    final List<LatLng> routePoints = routeCoordinates
        .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
        .toList();

    // Create Polyline (requires Material UI for Color)
    polyline = Polyline(points: routePoints, color: natural2, strokeWidth: 4);

    // Use Polyline to draw route on map or do anything else with the data :)
  }
}
