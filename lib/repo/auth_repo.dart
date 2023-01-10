import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../res/app_url.dart';

class AuthRepo {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<dynamic> login(data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUp(data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.registerUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
