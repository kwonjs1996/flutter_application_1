import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/campaign_service.dart';
import '../models/campaign_model.dart';
import '../widgets/campaign_card.dart';
import 'home_screen.dart'; // ✅ 로그아웃 후 홈 화면 이동

class CustomerMyPageScreen extends StatefulWidget {
  @override
  _CustomerMyPageScreenState createState() => _CustomerMyPageScreenState();
}

class _CustomerMyPageScreenState extends State<CustomerMyPageScreen> with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final CampaignService _campaignService = CampaignService();

  String userId = "";
  String userName = "";
  bool isLoading = true;
  List<Campaign> myCampaigns = [];
  List<Campaign> completedCampaigns = [];

  late TabController _tabController; // ✅ 'late' 선언

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // ✅ `initState()`에서 초기화
    _loadUserInfo();
  }

  @override
  void dispose() {
    _tabController.dispose(); // ✅ `dispose()`에서 해제
    super.dispose();
  }

  void _loadUserInfo() async {
    Map<String, String> userInfo = await _authService.getUserInfo();
    userId = userInfo["userId"] ?? "알 수 없음";
    userName = userInfo["userName"] ?? "사용자";

    List<Campaign> ongoing = await _campaignService.getMyCampaigns(userId);
    List<Campaign> completed = await _campaignService.getCompletedCampaigns(userId);

    setState(() {
      myCampaigns = ongoing;
      completedCampaigns = completed;
      isLoading = false;
    });
  }

  // 🔹 로그아웃 기능 추가
  void _logout() async {
    await _authService.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()), // ✅ 로그아웃 후 홈 화면 이동
      (route) => false, // 🔹 기존 모든 페이지 제거
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("마이페이지"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.blue), // 🔹 로그아웃 아이콘 추가
            onPressed: _logout, // ✅ 로그아웃 버튼 기능 연결
          ),
        ],
        bottom: TabBar(
          controller: _tabController, // ✅ `TabController` 올바르게 사용
          tabs: [
            Tab(text: "현재 참여 중"),
            Tab(text: "참여 완료"),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // ✅ 로딩 중 표시
          : TabBarView(
              controller: _tabController,
              children: [
                _buildCampaignList(myCampaigns),
                _buildCampaignList(completedCampaigns),
              ],
            ),
    );
  }

  Widget _buildCampaignList(List<Campaign> campaigns) {
    return campaigns.isEmpty
        ? Center(child: Text("참여한 캠페인이 없습니다."))
        : ListView.builder(
            itemCount: campaigns.length,
            itemBuilder: (context, index) {
              return CampaignCard(campaign: campaigns[index]);
            },
          );
  }
}
