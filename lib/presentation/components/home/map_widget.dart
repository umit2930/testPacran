import 'dart:async';

import 'package:dobareh_bloc/business_logic/home/home_cubit.dart';
import 'package:dobareh_bloc/utils/icon_assistant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/model/home/home_response.dart';
import '../../../utils/colors.dart';
import '../../../utils/location_geolocator.dart';
import '../general/loading_widget.dart';

class OpenStreetMapWidget extends StatelessWidget {
  const OpenStreetMapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        var selectedTimePack = state.selectedTimePackID;
        var delivery = state.timePacks!.keys.elementAt(selectedTimePack);
        var orders = state.timePacks!.values.elementAt(selectedTimePack);
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
                        height: 122.h,
                        alignment: Alignment.center,
                        child: (localOrders.isEmpty)
                            ? FittedBox(
                              child: Text("برای این بازه زمانی جمع اوری وجود ندارد.",
                                  style: textTheme.bodyLarge
                                      ?.copyWith(color: natural6)),
                            )
                            : FutureBuilder(
                                future: determinePosition(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Position> snapshot) {
                                  if (snapshot.hasData) {
                                    var currentLocations = snapshot.data!;
                                    return FutureBuilder(
                                      future: createMarkers(
                                          orders, currentLocations),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<Marker>>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          var markers = snapshot.data!;
                                          return FlutterMap(
                                            options: MapOptions(
                                              center: LatLng(
                                                  currentLocations.latitude,
                                                  currentLocations.longitude),
                                              zoom: 12.5,
                                              // bounds: bounds
                                            ),
                                            children: [
                                              TileLayer(
                                                  urlTemplate:
                                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                  userAgentPackageName:
                                                      'com.example.app'),
                                              MarkerLayer(markers: markers)
                                            ],
                                          );
                                        } else {
                                          return const LoadingWidget();
                                        }
                                      },
                                    );
                                  } else {
                                    return const LoadingWidget();
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
                        IconAssistant.forwardIconButton(null),
                      ],
                    ),
                  ),
                ),
                ],
              ),
            ),
          );
        // var selectedTimePack = state.selectedTimePackID;
      },
    );
  }

  Future<List<Marker>> createMarkers(
      List<Orders> orders, Position currentLocations) async {
    List<Marker> markers = [];
    markers.add(Marker(
        rotate: true,
        width: 32.w,
        height: 32.h,
        point: LatLng(currentLocations.latitude, currentLocations.longitude),
        builder: (context) {
          return SvgPicture.asset("assets/icons/my_location.svg");
        }));

    for (int i = 0; i < (orders.length); i++) {
      var item = orders.elementAt(i);
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

    return markers;
  }

/*  Future<void> createBounds(List<Marker> markers) async {
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
  }*/
}
