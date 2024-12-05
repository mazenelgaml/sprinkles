import 'package:untitled/Utils/api_service.dart';
import 'package:untitled/Utils/services.dart';
import 'package:untitled/models/response_model.dart';
import 'package:untitled/models/user_auth_model.dart';
import 'package:untitled/models/user_data_model.dart';

class AuthServices {
  static ApiService api = ApiService();
  static Future<UserAuthModel?>signingUp(String name,String email,String phone,String password,String passwordConformation) async {
    var data = await api.request(Services.signingUpEndPoint, "POST",queryParamters: {
    "name":name,
      "email":email,
      "phone":phone,
      "password":password,
      "password2":passwordConformation,
    });
    if (data != null) {
      return UserAuthModel.fromJson(data);
    }
    return null;
  }
  static Future<UserAuthModel?>signingIn(String email,String password) async {
    var data = await api.request(Services.signingInEndPoint, "POST",queryParamters: {
      "email":email,
      "password":password,
    });
    if (data != null) {
      return UserAuthModel.fromJson(data);
    }
    return null;
  }
  static Future<UserAuthModel?>editingUserData(String email,String name,String memberId,String phone) async {
    var data = await api.request(Services.editingMemberDataEndPoint, "POST",queryParamters: {
      "name":name,
      "email":email,
      "phone":phone,
      "member_id":memberId,
    });
    if (data != null) {
      return UserAuthModel.fromJson(data);
    }
    return null;
  }
  static Future<UserAuthModel?> editingMemberPassword(String memberId,String password) async {
    var data = await api.request(Services.editingMemberPasswordEndPoint, "POST",queryParamters: {
      "member_id":memberId,
      "password":password,
    });
    if (data != null) {
      return UserAuthModel.fromJson(data);
    }
    return null;
  }
  static Future<UserDataModel?> getUserData(String memberId) async {
    var data = await api.request(Services.getUserDataEndPoint, "POST",queryParamters: {
      "member_id":memberId,
    });
    if (data != null) {
      return UserDataModel.fromJson(data[0]);
    }
    return null;
  }
  static Future<ResponseModel?> deleteUserAccount(String memberId) async {
    var data = await api.request(Services.deleteUserAccountEndPoint, "POST",queryParamters: {
      "member_id":memberId,
    });
    if (data != null) {
      return ResponseModel.fromJson(data);
    }
    return null;
  }

  static Future<ResponseModel?> forgetPassword (String email) async {
    var data = await api.request(Services.forgetPasswordEndPoint, "POST",queryParamters: {
      "email":email,
    });
    if (data != null) {
      return ResponseModel.fromJson(data);
    }
    return null;
  }
}