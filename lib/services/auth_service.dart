import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isLoggedInKey = "isLoggedIn";
  static const String _userTypeKey = "userType"; // ✅ 유저 타입 저장 (advertiser / customer)
  static const String _userIdKey = "userId";
  static const String _userNameKey = "userName";

  // ✅ 광고주 정보 가져오기 추가
Future<Map<String, String>> getAdvertiserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // ✅ 광고주인지 확인
  String userType = prefs.getString(_userTypeKey) ?? "";
  if (userType != "advertiser") {
    return {}; // ❌ 광고주가 아니면 빈 값 반환
  }

  return {
    "advertiserId": prefs.getString(_userIdKey) ?? "",
    "advertiserName": prefs.getString(_userNameKey) ?? "",
  };
}
  // ✅ 회원가입 및 로그인 처리 (광고주 또는 일반 고객 구분)
  Future<void> registerAndLogin(String userId, String userName, String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_userTypeKey, userType); // ✅ 사용자 유형 저장
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_userNameKey, userName);
  }

  // ✅ 로그인 상태 확인
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // ✅ 사용자 정보 가져오기
  Future<Map<String, String>> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      "userId": prefs.getString(_userIdKey) ?? "",
      "userName": prefs.getString(_userNameKey) ?? "",
      "userType": prefs.getString(_userTypeKey) ?? "", // ✅ 사용자 유형 추가
    };
  }

  // ✅ 로그아웃
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
