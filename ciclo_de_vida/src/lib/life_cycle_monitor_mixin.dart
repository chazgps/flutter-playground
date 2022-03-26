import 'package:flutter/widgets.dart';

mixin LifeCycleMonitor implements WidgetsBindingObserver {
  
  void initLifeCycleMonitor() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        //print("Inactive");
        break;
      case AppLifecycleState.paused:
        //print("Paused");
        this.onPause();
        break;
      case AppLifecycleState.resumed:
        //print("Resumed");
        this.onResume();
        break;
      case AppLifecycleState.detached:
        //print("Detached");
        break;
    }
  }

  void onResume() {}

  void onPause() {}

  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeLocales(List<Locale> locale) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeTextScaleFactor() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  Future<bool> didPopRoute() {
    return Future<bool>.value(false);
  }

  @override
  Future<bool> didPushRoute(String route) {
    return Future<bool>.value(false);
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    return didPushRoute(routeInformation.location);
  }
}
