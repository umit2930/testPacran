import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import '../../../utils/colors.dart';
import 'custom_filled_button.dart';
import 'loading_widget.dart';

class LocationCheckerWidget extends StatefulWidget {
  const LocationCheckerWidget({Key? key, required this.mapWidget})
      : super(key: key);
  final Widget mapWidget;

  @override
  State<LocationCheckerWidget> createState() => _LocationCheckerWidgetState();
}

class _LocationCheckerWidgetState extends State<LocationCheckerWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Center(
      child: FutureBuilder(
        future: permissionChecker(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == null) return const LoadingWidget();
          if (snapshot.data == true) {
            return FutureBuilder(
              future: Geolocator.isLocationServiceEnabled(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.data == null) return const LoadingWidget();
                var status = snapshot.data!;
                return StreamBuilder(
                  stream: Geolocator.getServiceStatusStream(),
                  initialData: status == true
                      ? ServiceStatus.enabled
                      : ServiceStatus.disabled,
                  builder: (BuildContext context,
                      AsyncSnapshot<ServiceStatus> snapshot) {
                    var status = snapshot.data!;
                    if (status == ServiceStatus.enabled) {
                      return widget.mapWidget;
                    } else {
                      return Container(
                          height: 122.h,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                      "برای استفاده از نقشه GPS دستگاه را فعال نمایید.",
                                      style: textTheme.bodyLarge
                                          ?.copyWith(color: natural6)),
                                ),
                              ),
                              CustomFilledButton(
                                  onPressed: () {
                                    enableLocation();
                                  },
                                  buttonChild: (const Text("فعال کردن")))
                            ],
                          ));
                    }
                  },
                );
              },
            );
          } else {
            return Container(
                height: 122.h,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                            "برای استفاده از نقشه دسترسی مورد نیاز است.",
                            style:
                                textTheme.bodyLarge?.copyWith(color: natural6)),
                      ),
                    ),
                    CustomFilledButton(
                        onPressed: () {
                          requestPermission();
                        },
                        buttonChild: (const Text("اعطای دسترسی")))
                  ],
                ));
          }
        },
      ),
    );
  }

  Future<bool> permissionChecker() async {
    var locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.whileInUse ||
        locationPermission == LocationPermission.always) {
      return true;
    } else {
      return false;
    }
  }

  void requestPermission() async {
    var locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      var status = await Geolocator.requestPermission();
      if (status == LocationPermission.deniedForever) {
        Geolocator.openAppSettings();
      }
    }
  }

  void enableLocation() {
    Geolocator.openLocationSettings();
  }
}
