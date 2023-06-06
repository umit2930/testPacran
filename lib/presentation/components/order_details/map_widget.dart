import 'dart:async';
import 'dart:math';

import 'package:dobareh_bloc/presentation/components/general/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_route_service/open_route_service.dart';

import '../../../data/model/order/order_response.dart';
import '../../../utils/colors.dart';
import '../../../utils/location_geolocator.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  GoogleMapController? mapController;

  LatLngBounds? bounds;

  // HomeLargeMapViewModel homeLargeMapViewModel = HomeLargeMapViewModel();

  @override
  Widget build(BuildContext context) {
    var selectedOrder = widget.order;
    return FutureBuilder(
      future: getPolyline(double.parse(selectedOrder.address!.latitude!),
          double.parse(selectedOrder.address!.longitude!)),
      builder: (BuildContext context, AsyncSnapshot<Polyline> snapshot) {
        if (snapshot.hasData) {
          var polyline = snapshot.data!;
          return FutureBuilder(
            future: createMarker(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<MarkerId, Marker>> snapshot) {
              if (snapshot.hasData) {
                var markers = snapshot.data!;
                return GoogleMap(
                  liteModeEnabled: true,
                  mapType: MapType.normal,
                  cameraTargetBounds: CameraTargetBounds(bounds),
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  myLocationEnabled: true,
                  markers: Set<Marker>.of(markers.values),
                  polylines: {polyline},
                  initialCameraPosition: CameraPosition(
                      target: markers.values.first.position, zoom: 14),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    _goToCurrentLocation();
                  },
                );
              } else {
                return const Center(child: LoadingWidget());
              }
            },
          );
        } else {
          return const Center(child: LoadingWidget());
        }
      },
    );
  }

  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    final position = await determinePosition();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 12)));
  }

  Future<Map<MarkerId, Marker>> createMarker() async {
    Map<MarkerId, Marker> markers = {};

    var pinIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/images/pin.png");

    var markerID = const MarkerId("11");

    var item = widget.order;
    double latitude = double.parse(item.address?.latitude ?? "0");
    double longitude = double.parse(item.address?.longitude ?? "0");
    var marker = Marker(
      markerId: markerID,
      icon: pinIcon,
      position: LatLng(latitude, longitude),
    );
    markers[markerID] = marker;

    var lngs = markers.values.map((e) => e.position.longitude);
    var lats = markers.values.map((e) => e.position.latitude);

    double topMost = lngs.reduce(max);
    double leftMost = lats.reduce(min);
    double rightMost = lats.reduce(max);
    double bottomMost = lngs.reduce(min);

    bounds = LatLngBounds(
      northeast: LatLng(rightMost, topMost),
      southwest: LatLng(leftMost, bottomMost),
    );

    return markers;
  }

  Future<Polyline> getPolyline(double endLat, double endLng) async {
    // Initialize the openrouteservice with your API key.
    final OpenRouteService client = OpenRouteService(
        apiKey: '5b3ce3597851110001cf624852fa353744464ff0b50de2c992d27769');

    var currentPosition = await determinePosition();

    // Example coordinates to test between
    // const double startLat = 38.0727479;
    // const double startLng = 46.3046781;

    // const double endLat = 38.063382;
    // const double endLng = 46.376152;

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
    final Polyline routePolyline = Polyline(
      polylineId: const PolylineId('route'),
      visible: true,
      points: routePoints,
      color: natural2,
      width: 3,
    );
    return routePolyline;
    // Use Polyline to draw route on map or do anything else with the data :)
  }
}
