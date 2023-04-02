import 'package:connectivity_plus/connectivity_plus.dart';

/// Used to check network connectivity status.
extension ConnectivityHelper on Connectivity {
  Future<bool> get checkConnection async =>
      (await Connectivity().checkConnectivity() == ConnectivityResult.mobile ||
              await Connectivity().checkConnectivity() ==
                  ConnectivityResult.wifi)
          ? true
          : false;
}
