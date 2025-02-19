import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'advertiser_screen.dart';
import 'home_screen.dart';
import 'advertiser_register_screen.dart'; // ✅ 광고주 회원가입
import 'customer_register_screen.dart'; // ✅ 일반 고객 회원가입

class LoginScreen extends StatefulWidget {
  final String userType; // ✅ 기본 로그인 타입 추가

  LoginScreen({this.userType = "customer"}); // 기본값: 일반 사용자

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isAdvertiser = false; // ✅ 기본값: 일반 사용자

  @override
  void initState() {
    super.initState();
    isAdvertiser = (widget.userType == "advertiser"); // ✅ 전달된 userType 기반 초기 설정
  }

  void _login() async {
    String userId = _emailController.text.trim();
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("아이디를 입력하세요")));
      return;
    }

    // 🔹 사용자 정보 가져오기
    Map<String, String> userInfo = await _authService.getUserInfo();

    if (userInfo["userId"] == userId) {
      String userType = userInfo["userType"] ?? "";

      if (userType == "advertiser") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdvertiserScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("사용자 정보를 찾을 수 없습니다.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("로그인")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔹 사용자 유형 선택 스위치 (광고주 / 소비자)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("일반 사용자"),
                Switch(
                  value: isAdvertiser,
                  activeColor: Colors.blue, // 활성화(광고주 선택) 시 색상
                  inactiveThumbColor: Colors.deepOrange, // 비활성화(일반 사용자 선택) 시 색상
                  onChanged: (value) {
                    setState(() {
                      isAdvertiser = value;
                    });
                  },
                ),
                Text("광고주"),
              ],
            ),
            SizedBox(height: 20),

            // 🔹 아이디 입력
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "아이디", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),

            // 🔹 패스워드 입력 (현재는 저장하지 않으므로 실제 검증은 없음)
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "패스워드", border: OutlineInputBorder()),
              obscureText: true,
            ),
            SizedBox(height: 10),

            // 🔹 로그인 버튼
            ElevatedButton(
              onPressed: _login,
              child: Text("로그인"),
            ),

            SizedBox(height: 20),

            // 🔹 회원가입 버튼 (선택된 유형에 따라 다르게 표시)
            Center(
              child: TextButton(
                onPressed: () {
                  if (isAdvertiser) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AdvertiserRegisterScreen()));
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerRegisterScreen()));
                  }
                },
                child: Text(isAdvertiser ? "광고주 회원가입" : "일반 회원가입", style: TextStyle(color: Colors.blue, fontSize: 16)),
              ),
            ),

            SizedBox(height: 20),

            // 🔹 소셜 로그인 버튼들
            _buildSocialLoginButton("assets/icons/kakao_logo.png"),
            _buildSocialLoginButton("assets/icons/google_logo.png"),
            _buildSocialLoginButton("assets/icons/naver_logo.png"),
          ],
        ),
      ),
    );
  }

  // 🔹 소셜 로그인 버튼 생성 함수
  Widget _buildSocialLoginButton(String assetPath) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          print("소셜 로그인 클릭");
        },
        child: Image.asset(assetPath, width: 300, height: 45, fit: BoxFit.fill),
      ),
    );
  }
}
