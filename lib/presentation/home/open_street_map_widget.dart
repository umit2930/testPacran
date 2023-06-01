import 'dart:async';
import 'dart:math';

import 'package:dobareh_bloc/business_logic/home/home_cubit.dart';
import 'package:dobareh_bloc/presentation/components/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

import '../../data/model/home/home_response.dart';
import '../../utils/colors.dart';
import '../../utils/location_geolocator.dart';

class OpenStreetMapWidget extends StatelessWidget {
  OpenStreetMapWidget({Key? key}) : super(key: key);

  LatLngBounds? bounds;
  List<Marker> markers = [];
  late Position currentLocations;

  List<Orders>? orders;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        Logger().w("bloc builder");
        bounds = null;
        markers = [];

        orders = null;

        if (state.homeStatus == HomeStatus.success) {
          var selectedTimePack = state.selectedTimePackID;

          var delivery = state.timePacks!.keys.elementAt(selectedTimePack);

          //TODO why null opration give us error?
          orders = state.timePacks!.values.elementAt(selectedTimePack);

          var textTheme = Theme.of(context).textTheme;

          //TODO find a way to don't use ! operator.
          // if we want to show this ui in error state,
          // we must consider null values and build ui based on it
          var localOrders = orders;

          ///map
          return RepaintBoundary(
            child: Container(
              decoration: boxDecoration,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                          alignment: Alignment.center,
                          height: 122.h,
                          child: (localOrders == null || localOrders.isEmpty)
                              ? const Text(
                                  "برای این بازه زمانی جمع اوری وجود ندارد.")
                              : FutureBuilder(
                                  future: initValues(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    if (snapshot.hasData) {
                                      return FlutterMap(
                                        options: MapOptions(
                                          center: LatLng(
                                              currentLocations.latitude,
                                              currentLocations.longitude),
                                          zoom: 12.5,
                                          bounds: bounds,
                                        ),
                                        children: [
                                          TileLayer(
                                            urlTemplate:
                                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                            userAgentPackageName:
                                                'com.example.app',
                                          ),
                                          MarkerLayer(
                                            markers: markers,
                                          )
                                        ],
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ))),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // homeViewModel.homeStream
                        /* Get.to(LargeMapPage(
                                          selectedTimeID: selectedTimePack,
                                        ));*/
                        // homeViewModel.getProfile();
                      },
                      child: Row(
                        children: [
                          Text(" منطقه شما ",
                              style: textTheme.titleSmall
                                  ?.copyWith(color: natural1)),
                          Text("(بازه ${delivery.from} الی ${delivery.to})"),
                          IconButton(
                            onPressed: null,
                            icon: SvgPicture.asset(
                              "assets/icons/arrow_left.svg",
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const LoadingWidget();
        }
        // var selectedTimePack = state.selectedTimePackID;
      },
    );
  }

  Future<bool> initValues() async {
    await createMarkers();
    await createBounds(markers);
    return true;
  }

  Future<void> createMarkers() async {
    // var myLocation = await LocationService().getLocation();
    currentLocations = await determinePosition();
    markers.add(Marker(
        rotate: true,
        width: 32.w,
        height: 32.h,
        // point: LatLng(myLocation.latitude ??0, myLocation.longitude ??0),
        point: LatLng(
            currentLocations.latitude ?? 0, currentLocations.longitude ?? 0),
        builder: (context) {
          return SvgPicture.asset("assets/icons/my_location.svg");
        }));

    for (int i = 0; i < (orders?.length ?? 0); i++) {
      var item = orders?.elementAt(i) ?? Orders();
      double latitude = double.parse(item.address?.latitude ?? "0");
      double longitude = double.parse(item.address?.longitude ?? "0");
      markers.add(Marker(
          rotate: true,
          width: 48.w,
          height: 48.h,
          point: LatLng(latitude, longitude),
          builder: (context) {
            return SvgPicture.asset("assets/images/marker.svg");
          }));
    }
  }

  Future<void> createBounds(List<Marker> markers) async {
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
}
