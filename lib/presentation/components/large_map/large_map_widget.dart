import 'dart:async';
import 'dart:math';

import 'package:dobareh_bloc/business_logic/map/map_cubit.dart';
import 'package:dobareh_bloc/presentation/components/general/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_route_service/open_route_service.dart';

import '../../../data/model/home/home_response.dart';
import '../../../utils/colors.dart';
import '../../../utils/location_geolocator.dart';


class LargeMapWidget extends StatelessWidget {
   LargeMapWidget({Key? key,required this.orders,required this.pageController}) : super(key: key);



  List<Orders> orders;
  PageController pageController;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  // HomeLargeMapViewModel homeLargeMapViewModel = HomeLargeMapViewModel();

  GoogleMapController? mapController;

  LatLngBounds? bounds;
  Map<MarkerId, Marker> markers = {};
   Polyline? routePolyline;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      /*  buildWhen: (pState, nState) {
        return pState.selectedOrder != nState.selectedOrder;
      },*/
      builder: (BuildContext context, state) {
        var selectedOrder = orders.elementAt(state.selectedOrder);
        _goToLocation(CameraPosition(
            target: LatLng(double.parse(selectedOrder.address!.latitude!),
                double.parse(selectedOrder.address!.longitude!)),
            zoom: 14));

        ///polyline future
        return FutureBuilder<bool>(
          future: initValues(state.selectedOrder),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if(routePolyline != null){
                var polyline = routePolyline!;
                return GoogleMap(
                  mapType: MapType.normal,
                  cameraTargetBounds: CameraTargetBounds(bounds),
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  // zoomGesturesEnabled: false,
                  myLocationEnabled: true,
                  markers: Set<Marker>.of(markers.values),
                  polylines: {polyline},
                  initialCameraPosition: CameraPosition(
                      target: markers.values.first.position, zoom: 12),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                );
              }
              return const LoadingWidget();

            } else {
              return const LoadingWidget();
            }
          },
        );
      },
    );
  }

  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    final position = await determinePosition();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 12)));
  }

  Future<void> _goToLocation(CameraPosition cameraPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<bool> initValues(int selectedOrder1) async {

    await createMarkers();
    await createBounds(markers.values.toList());
    var selectedOrder = orders.elementAt(selectedOrder1);

    await getPolyline(double.parse(selectedOrder.address!.latitude!),
        double.parse(selectedOrder.address!.longitude!));
    return true;
  }

  Future<void> createMarkers() async {
    var pinIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/images/pin.png");

    for (int i = 0; i < orders.length; i++) {
      var markerID = MarkerId("$i");

      var item = orders.elementAt(i);
      double latitude = double.parse(item.address?.latitude ?? "0");
      double longitude = double.parse(item.address?.longitude ?? "0");
      var marker = Marker(
        markerId: markerID,
        icon: pinIcon,
        onTap: () {
          pageController.animateToPage(i,
              duration: const Duration(milliseconds: 300), curve: Curves.linear);
        },
        position: LatLng(latitude, longitude),
      );
      markers[markerID] = marker;
    }
  }

  Future<void> createBounds(List<Marker> markers) async {
    var lngs = markers.map((e) => e.position.longitude);
    var lats = markers.map((e) => e.position.latitude);

    double topMost = lngs.reduce(max);
    double leftMost = lats.reduce(min);
    double rightMost = lats.reduce(max);
    double bottomMost = lngs.reduce(min);

    bounds = LatLngBounds(
      northeast: LatLng(rightMost, topMost),
      southwest: LatLng(leftMost, bottomMost),
    );
  }

  Future<void> getPolyline(double endLat, double endLng) async {
    final OpenRouteService client = OpenRouteService(
        apiKey: '5b3ce3597851110001cf624852fa353744464ff0b50de2c992d27769');
    Position    currentPosition = await determinePosition();

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
    routePolyline = Polyline(
      polylineId: const PolylineId('route'),
      visible: true,
      points: routePoints,
      color: natural2,
      width: 3,
    );

    // Use Polyline to draw route on map or do anything else with the data :)
  }


}

