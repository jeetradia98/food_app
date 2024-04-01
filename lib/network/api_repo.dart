import '../database/static_data_json/static_data.dart';

class ApiRepo {
  // final String _loginEndpoint = 'BranchLogin';

  Future<Map<String, dynamic>> loginUser(
      {required String userName, required String password}) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (password == '123456' && userName == 'joe@gmail.com') {
        return StaticData.screenSaverJson;
      } else {
        throw 'Invalid credentials provided';
      }
    } catch (e) {
      rethrow;
    }
  }
}
