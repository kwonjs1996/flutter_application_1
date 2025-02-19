import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'advertiser_register_screen.dart'; // ✅ 광고주 회원가입 화면
import 'login_screen.dart'; // ✅ 로그아웃 후 이동할 로그인 화면

class AdvertiserScreen extends StatefulWidget {
  @override
  _AdvertiserScreenState createState() => _AdvertiserScreenState();
}

class _AdvertiserScreenState extends State<AdvertiserScreen> {
  final AuthService _authService = AuthService();
  String advertiserId = "";
  String advertiserName = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    bool loggedIn = await _authService.isLoggedIn();
    if (!loggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdvertiserRegisterScreen()),
      );
      return;
    }

    Map<String, String> advertiserInfo = await _authService.getUserInfo(); // ✅ getUserInfo()로 변경
    if (advertiserInfo.isEmpty || advertiserInfo["userType"] != "advertiser") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdvertiserRegisterScreen()),
      );
      return;
    }

    setState(() {
      advertiserId = advertiserInfo["userId"] ?? "알 수 없음";
      advertiserName = advertiserInfo["userName"] ?? "광고주";
      isLoading = false;
    });
  }

  // 🔹 로그아웃 기능 추가
  void _logout() async {
    await _authService.logout(); // ✅ 로그인 정보 삭제
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // ✅ 로그인 화면으로 이동
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator()) // ✅ 로딩 중
        : Scaffold(
            appBar: AppBar(
              title: Text("광고주 대시보드"),
              backgroundColor: Theme.of(context).primaryColor,
              actions: [
                // 🔹 광고주 계정 정보 표시
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      Icon(Icons.account_circle, size: 24),
                      SizedBox(width: 5),
                      Text(advertiserName, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                // 🔹 로그아웃 버튼 추가
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: _logout, // ✅ 로그아웃 기능 연결
                  tooltip: "로그아웃",
                ),
              ],
            ),
            body: Center(child: Text("광고주 대시보드 화면")),
          );
  }
}
