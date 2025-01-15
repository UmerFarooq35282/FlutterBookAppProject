import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class Network {
  // for real device
  final String url = "http://localhost/BOOKS_API";

  //final String url = "https://connektteacher.com/PHPAPI";

  postData(values, endpoint) async {
    var fullUrl = url + endpoint;

    return await http.post(Uri.parse(fullUrl), body: values);
  }

  getData(endpoint) async {
    var fullUrl = url + endpoint;

    return await http.get(Uri.parse(fullUrl));
  }

  checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return true;
    }
  }
}
