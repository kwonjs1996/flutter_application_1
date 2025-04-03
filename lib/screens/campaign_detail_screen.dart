import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  const CampaignDetailScreen({
    required this.title,
    required this.description,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.reward,
    required this.company,
    required this.deadline,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  _CampaignDetailScreenState createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  bool isLoggedIn = false; // 로그인 상태 (나중에 실제 로그인 체크 로직 추가)

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    // 🔹 로그인 상태 체크 로직 (나중에 실제 로그인 체크 추가 필요)
    setState(() {
      isLoggedIn = true; // 테스트용 (나중에 실제 로그인 체크)
    });
  }

  // ✅ 참여 진행률 계산 함수
  double _calculateProgress() {
    if (widget.maxParticipants == 0) return 0;
    return (widget.currentParticipants / widget.maxParticipants)
        .clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // 🔹 모집 마감 여부 확인
    bool isRecruitmentClosed = widget.deadline.isBefore(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text("체험단 상세", style: TextStyle(fontSize: screenWidth * 0.05)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ 대표 이미지
              Image.network(
                widget.imageUrl,
                width: screenWidth,
                height: screenHeight * 0.3,
                fit: BoxFit.cover,
              ),

              SizedBox(height: screenHeight * 0.02),

              // ✅ 제목
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: screenHeight * 0.01),

              // ✅ 설명
              Text(
                widget.description,
                style: TextStyle(
                    fontSize: screenWidth * 0.045, color: Colors.grey[700]),
              ),

              SizedBox(height: screenHeight * 0.02),

              // ✅ 참가 인원 & 마감일 정보
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "참여자: ${widget.currentParticipants} / ${widget.maxParticipants}",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "마감일: ${DateFormat('MM.dd').format(widget.deadline)}",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.02),

              // ✅ 참여 진행률 표시 (Progress Bar)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "참여 진행률",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.015,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: _calculateProgress(),
                            minHeight: screenHeight * 0.012,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.orangeAccent),
                          ),
                        ),
                      ),
                      Text(
                        "${(_calculateProgress() * 100).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.03),

              // ✅ 지원하기 버튼
              Center(
                child: SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    onPressed: isRecruitmentClosed
                        ? null
                        : () {
                            if (!isLoggedIn) {
                              // ❌ 로그인 안 했을 때 -> 로그인 화면 이동
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            } else {
                              // ✅ 로그인 되어 있을 때 -> 체험단 지원 처리
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("체험단 지원 완료!")),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isRecruitmentClosed ? Colors.grey : Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      isRecruitmentClosed
                          ? "모집 마감됨"
                          : (isLoggedIn ? "체험단 지원하기" : "로그인 후 지원하기"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045,
                      ),
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
