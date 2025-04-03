import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/campaign_model.dart';
import '../services/campaign_service.dart';
import '../widgets/campaign_card.dart';
import 'campaign_detail_screen.dart';
import 'login_screen.dart';
import 'advertiser_screen.dart';
import 'campaign_create_screen.dart';
import 'customer_mypage_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CampaignService _campaignService = CampaignService();
  final AuthService _authService = AuthService();
  List<Campaign> campaigns = [];
  bool isLoggedIn = false;
  bool isAdvertiser = false;
  bool isCustomer = false;

  @override
  void initState() {
    super.initState();
    _loadCampaigns();
    _checkLoginStatus();
  }

  // 🔹 캠페인 데이터 불러오기
  void _loadCampaigns() async {
    List<Campaign> loadedCampaigns = await _campaignService.getCampaigns();
    setState(() {
      campaigns = loadedCampaigns;
    });
  }

  // 🔹 로그인 상태 확인
  void _checkLoginStatus() async {
    Map<String, String> userInfo = await _authService.getUserInfo();

    setState(() {
      isLoggedIn = userInfo["userId"] != null && userInfo["userId"]!.isNotEmpty;
      isAdvertiser = (userInfo["userType"] == "advertiser");
      isCustomer = (userInfo["userType"] == "customer");
    });
  }

  // 🔹 마이페이지 이동
  void _navigateToMyPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerMyPageScreen()),
    );
  }

  // 🔹 모집하기 버튼 클릭 시 처리
  void _handleRecruitment(BuildContext context) {
    if (!isLoggedIn) {
      // ❌ 로그인하지 않은 경우 -> 로그인 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else if (isAdvertiser) {
      // ✅ 광고주라면 캠페인 모집 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CampaignCreateScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "숏폼창고",
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          // ✅ 비로그인 상태에서는 "모집하기" + "로그인" 버튼 둘 다 표시
          if (!isLoggedIn) ...[
            TextButton(
              onPressed: () => _handleRecruitment(context),
              child: Text("모집하기", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text("로그인", style: TextStyle(color: Colors.white)),
            ),
          ],

          // ✅ 광고주 로그인 시 "모집하기" 버튼 표시
          if (isAdvertiser)
            TextButton(
              onPressed: () => _handleRecruitment(context),
              child: Text("모집하기", style: TextStyle(color: Colors.white)),
            ),

          // ✅ 소비자 로그인 시 "마이페이지" 버튼 표시
          if (isCustomer)
            TextButton(
              onPressed: () => _navigateToMyPage(context),
              child: Text("마이페이지", style: TextStyle(color: Colors.white)),
            ),

          // ✅ 광고주만 "광고주용 채널" 버튼 표시
          if (isAdvertiser)
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdvertiserScreen()),
                );
              },
              child: Text("광고주용 채널", style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: Column(
        children: [
          // 🔹 배너 슬라이드
          Container(
            height: 180,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: PageView(
              children: [
                Image.network(
                    "https://images.unsplash.com/photo-1726137569820-bff1c68311a1?w=400&auto=format&fit=crop&q=60",
                    fit: BoxFit.cover),
                Image.network(
                    "https://images.unsplash.com/photo-1726137569820-bff1c68311a1?w=400&auto=format&fit=crop&q=60",
                    fit: BoxFit.cover),
              ],
            ),
          ),

          // 🔹 체험단 목록 (GridView 사용하여 2열 배치)
          Expanded(
            child: campaigns.isEmpty
                ? Center(child: CircularProgressIndicator()) // ✅ 로딩 중 표시
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // ✅ 2열 배치
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: campaigns.length,
                      itemBuilder: (context, index) {
                        final campaign = campaigns[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CampaignDetailScreen(
                                  title: campaign.title,
                                  description: "설명 없음",
                                  maxParticipants: campaign.maxParticipants,
                                  currentParticipants:
                                      campaign.currentParticipants,
                                  reward: campaign.reward,
                                  company: campaign.companyName,
                                  deadline: campaign.deadline,
                                  imageUrl: campaign.imageUrl,
                                ),
                              ),
                            );
                          },
                          child: CampaignCard(campaign: campaign),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
