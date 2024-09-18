import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionChecker {
  static Future<bool> connectionChecker() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
