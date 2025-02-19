import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class CampaignDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final int maxParticipants;
  final int currentParticipants;
  final String reward;
  final String company;
  final DateTime deadline;
  final String imageUrl;

  CampaignDetailScreen({
    required this.title,
    required this.description,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.reward,
    required this.company,
    required this.deadline,
    required this.imageUrl,
  });

  @override
  _CampaignDetailScreenState createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  final AuthService _authService = AuthService();
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // 🔹 로그인 상태 확인
  void _checkLoginStatus() async {
    bool loggedIn = await _authService.isLoggedIn();
    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  double _calculateProgress() {
    if (widget.maxParticipants == 0) return 0;
    return widget.currentParticipants / widget.maxParticipants;
  }

  // ✅ D-Day 계산 함수
  String calculateDDay(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now).inDays;

    if (difference < 0) {
      return "마감"; // 모집 기한이 지난 경우
    } else if (difference == 0) {
      return "D-Day"; // 오늘이 마감일
    } else {
      return "D-$difference"; // 남은 일 수 표시
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ 화면 크기 가져오기 (반응형 적용)
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // 🔹 모집 마감 여부 확인
    bool isRecruitmentClosed = widget.deadline.isBefore(DateTime.now());

    // ✅ 태그 위젯 함수
    Widget _buildTag(String text) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: screenHeight * 0.008,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.035,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("체험단 상세")),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // 반응형 패딩
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 대표 이미지 + D-Day 표시
              Stack(
                children: [
                  Image.network(
                    widget.imageUrl,
                    width: screenWidth, // 화면 너비에 맞게 조정
                    height: screenHeight * 0.3, // 화면 높이의 30%만큼
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: screenHeight * 0.02,
                    left: screenWidth * 0.04,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenHeight * 0.008),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        calculateDDay(widget.deadline),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04, // 반응형 폰트 크기
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: screenHeight * 0.02,
                    left: screenWidth * 0.04,
                    child: Row(
                      children: [
                        _buildTag("📅 예약 필수"),
                        SizedBox(width: screenWidth * 0.02),
                        _buildTag("⚡ 바로 선정"),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.02), // 반응형 간격

              // 🔹 모집 현황 UI
              Text(widget.title,
                  style: TextStyle(
                      fontSize: screenWidth * 0.06, // 반응형 제목 크기
                      fontWeight: FontWeight.bold)),
              SizedBox(height: screenHeight * 0.01),

              Text("주최: ${widget.company}",
                  style: TextStyle(
                      fontSize: screenWidth * 0.045, color: Colors.grey[700])),
              SizedBox(height: screenHeight * 0.02),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.008),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      calculateDDay(widget.deadline),
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text("마감일: ${DateFormat('MM월 dd일').format(widget.deadline)}",
                      style: TextStyle(fontSize: screenWidth * 0.045)),
                ],
              ),

              SizedBox(height: screenHeight * 0.02),

              // 🔹 지원하기 버튼 (반응형 적용)
              Center(
                child: SizedBox(
                  width: screenWidth * 0.8, // 버튼 너비: 화면 너비의 80%
                  height: screenHeight * 0.06, // 버튼 높이: 화면 높이의 6%
                  child: ElevatedButton(
                    onPressed: isRecruitmentClosed
                        ? null
                        : () {
                            if (!isLoggedIn) {
                              // ❌ 로그인 안 했을 때 -> 로그인 화면으로 이동
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            } else {
                              // ✅ 로그인 되어 있을 때 -> 캠페인 지원 로직
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("체험단 지원 완료!")),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isRecruitmentClosed ? Colors.grey : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      isRecruitmentClosed
                          ? "모집 마감됨"
                          : (isLoggedIn ? "체험단 지원하기" : "로그인 후 지원하기"),
                      style: TextStyle(
                          color: Colors.white, fontSize: screenWidth * 0.045),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
