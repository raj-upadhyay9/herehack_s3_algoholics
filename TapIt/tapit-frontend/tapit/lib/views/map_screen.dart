import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.engine.dart';
import 'package:here_sdk/mapview.dart';
import 'package:tapit/controller/LocationController.dart';
import 'package:url_launcher/url_launcher.dart';

import '../images.dart';

import '../widgets/Map_Screen/search.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  SearchExample? _searchExample;
  final LocationController controller = Get.put(LocationController());

  // Position? _currentAddress;
  // CustomRasterLayersExample? _customRasterLayersExample;
  double height = 0.4;
  int count = 0;
  bool ActiveConnection = false;
  String T = "";
  late bool drawerClicked;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    drawerClicked = false;
    CheckUserConnection();
    super.initState();
  }

  Widget drawer() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Drawer(
        backgroundColor: Theme.of(context).backgroundColor,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).primaryColorDark),
                  ),
                  Text(
                    "Pranay",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.w900, fontSize: 40.sp, color: Theme.of(context).primaryColorDark),
                  ),
                  const Divider(),
                  Text(
                    "+91 8851055155",
                    style: Theme.of(context).textTheme.headline5!.copyWith(color: Theme.of(context).primaryColorDark),
                  ),
                  Text(
                    "bhupesh1618@gmail.com",
                    style: Theme.of(context).textTheme.headline5!.copyWith(color: Theme.of(context).primaryColorDark),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  drawerWidget(
                      "Account Details", Icons.supervised_user_circle, Theme.of(context).backgroundColor, Colors.black),
                  SizedBox(
                    height: 10.h,
                  ),
                  drawerWidget("Diaster News", Icons.newspaper, Theme.of(context).backgroundColor, Colors.black),
                  SizedBox(
                    height: 10.h,
                  ),
                  drawerWidget(
                      "Alert Nearby", Icons.supervised_user_circle, Theme.of(context).backgroundColor, Colors.black),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("About Us",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Theme.of(context).primaryColorDark)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("Contact Us",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Theme.of(context).primaryColorDark)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("FAQs",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Theme.of(context).primaryColorDark)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("Contact Us",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Theme.of(context).primaryColorDark)),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text("Terms of service\n   Privacy Policy",
                      style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.blue)),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              drawerWidget("Logout", null, Colors.black, Colors.white),
            ],
          ),
        )),
      ),
    );
  }

  Widget drawerWidget(String Name, IconData? icon, Color color, Color textColor) {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 1, color: Colors.black.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(
            width: 10.h,
          ),
          Text(Name,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: textColor,
                  ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: drawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        leadingWidth: 70.w,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            // color: Colors.black,
            height: 52.h,
            width: 52.w,
            decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(40))),
            child: GestureDetector(
                onTap: (() {
                  _scaffoldKey.currentState?.openDrawer();
                }),
                child: Icon(
                  Icons.navigate_before,
                  color: Colors.white,
                  size: 40.sp,
                )),
          ),
        ),
      ),
      body: Stack(
        // alignment: AlignmentDirectional.bottomCenter,
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                  height: constraints.maxHeight / 1.5,
                  child: HereMap(
                    onMapCreated: _onMapCreated,
                  ));
            },
          ),

          //
          count % 2 == 0
              ? DraggableScrollableSheet(
                  // snap: true,
                  initialChildSize: 0.4,
                  // minChildSize: .1,
                  maxChildSize: 1,
                  builder: (BuildContext context, ScrollController scrollController) {
                    return ActiveConnection ? bottomSheet() : bottomSheetOffline();
                  },
                )
              : DraggableScrollableSheet(
                  // snap: true,
                  initialChildSize: 0.56,
                  // minChildSize: .1,
                  maxChildSize: 1,
                  builder: (BuildContext context, ScrollController scrollController) {
                    return bottomSheet2();
                  },
                )
        ],
      ),
    );
  }

  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        T = "Turn On the data and repress again";
      });
    }
  }

  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunch(phoneUri.toString())) await launch(phoneUri.toString());
    } catch (error) {
      throw ("Cannot dial");
    }
  }

  Widget emergency_button(String image, String Name) {
    return GestureDetector(
      onTap: () async {
        if (Name == "Ambulance") {
          // final call = Uri.parse('tel:+91 9830268966');
          launch('sms:112?body=Hi Welcome to our city');
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5)]),
        child: Container(
          height: 106.h,
          width: 97.w,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 70.h,
              ),
              Text(
                Name,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheetOffline() {
    return Container(
      height: 287.h,
      width: double.infinity,
      // color: Colors.black,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50.sp), topRight: Radius.circular(50.sp))),
      child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  logoUnderheadDark,
                  height: 52.48.h,
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                emergency_button(ambulanceLogo, "Ambulance"),
                emergency_button(fireLogo, "Fire"),
                emergency_button(policeLogo, "Police"),
              ],
              // emergency_button(ambulanceLogo,"Ambulance");
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.green;
                  }
                  return Theme.of(context).primaryColor;
                })),
                onPressed: () async {
                  setState(() {
                    if (count % 2 == 0) {
                      height = 0.4;
                    } else {
                      height = 0.6;
                    }

                    count++;
                  });
                },
                child: const Text("Other Emergency"))
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 287.h,
      width: double.infinity,
      // color: Colors.black,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50.sp), topRight: Radius.circular(50.sp))),
      child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  logoUnderheadDark,
                  height: 52.48.h,
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                emergency_button(ambulanceLogo, "Ambulance"),
                emergency_button(fireLogo, "Fire"),
                emergency_button(policeLogo, "Police"),
              ],
              // emergency_button(ambulanceLogo,"Ambulance");
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.green;
                  }
                  return Theme.of(context).primaryColor;
                })),
                onPressed: () async {
                  setState(() {
                    if (count % 2 == 0) {
                      height = 0.4;
                    } else {
                      height = 0.6;
                    }

                    count++;
                  });
                },
                child: const Text("Other Emergency"))
          ],
        ),
      ),
    );
  }

  Widget bottomSheet2() {
    return Container(
      height: 287.h,
      width: double.infinity,
      // color: Colors.black,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50.sp), topRight: Radius.circular(50.sp))),
      child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  logoUnderheadDark,
                  height: 52.48.h,
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 20,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                emergency_button(ambulanceLogo, "Ambulance"),
                emergency_button(fireLogo, "Fire"),
                emergency_button(policeLogo, "Police"),
                emergency_button(mechanicLogo, "Mechanics"),
                emergency_button(unsafeLogo, "Unsafe"),
                emergency_button(earthQuakeLogo, "EarthQuake"),
              ],
              // emergency_button(ambulanceLogo,"Ambulance");
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.green;
                  }
                  return Theme.of(context).primaryColor;
                })),
                onPressed: () async {
                  setState(() {
                    if (count % 2 == 0) {
                      height = 0.4;
                    } else {
                      height = 0.6;
                    }

                    count++;
                  });
                },
                child: const Text("Go back"))
          ],
        ),
      ),
    );
  }

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay, (MapError? error) {
      if (error == null) {
        _searchExample = SearchExample(_showDialog, hereMapController);
        _searchExample?.searchHospitalButton();

        _addLocationIndicator(GeoCoordinates(controller.lat.value, controller.long.value),
            LocationIndicatorIndicatorStyle.navigation, hereMapController);
        hereMapController.mapScene.enableFeatures({MapFeatures.trafficFlow: MapFeatureModes.trafficFlowWithFreeFlow});
        hereMapController.mapScene.enableFeatures({MapFeatures.extrudedBuildings: MapFeatureModes.defaultMode});
        hereMapController.mapScene.enableFeatures({MapFeatures.buildingFootprints: MapFeatureModes.defaultMode});
      } else {
        print("Map scene not loaded. MapError: $error");
      }
    });
  }

  void _addLocationIndicator(GeoCoordinates geoCoordinates, LocationIndicatorIndicatorStyle indicatorStyle,
      HereMapController hereMapController) {
    LocationIndicator locationIndicator = LocationIndicator();
    locationIndicator.locationIndicatorStyle = indicatorStyle;
    Location location = Location.withCoordinates(geoCoordinates);
    location.time = DateTime.now();
    location.bearingInDegrees = 90;

    locationIndicator.updateLocation(location);

    hereMapController.addLifecycleListener(locationIndicator);
  }

  // void _searchPoliceButtonClicked() {
  //   _searchExample?.searchPoliceButton();
  // }

  void _searchHospitalButtonClicked() {
    _searchExample?.searchHospitalButton();
  }

  // void _searchFireButtonClicked() {
  //   _searchExample?.searchFireButton();
  // }

  // void _enableButtonClicked() {
  //   _customRasterLayersExample?.enableButtonClicked();
  // }

  // void _disableButtonClicked() {
  //   _customRasterLayersExample?.disableButtonClicked();
  // }

  @override
  void dispose() {
    // Free HERE SDK resources before the application shuts down.
    SDKNativeEngine.sharedInstance?.dispose();
    SdkContext.release();
    super.dispose();
  }

  Future<void> _showDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Align button(String buttonLabel, Function callbackFunction) {
    return Align(
      alignment: Alignment.topCenter,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.lightBlueAccent,
        ),
        onPressed: () => callbackFunction(),
        child: Text(buttonLabel, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
