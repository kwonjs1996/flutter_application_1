import 'package:flutter/material.dart';
import '../widgets/campaign_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> campaigns = [
    {"title": "신제품 체험단", "company": "ABC 마케팅", "reward": "무료 제품 제공", "image": "https://source.unsplash.com/200x100/?beauty"},
    {"title": "SNS 홍보단", "company": "XYZ 기업", "reward": "10,000원", "image": "https://source.unsplash.com/200x100/?food"},
    {"title": "레스토랑 방문 리뷰", "company": "맛집 서포터즈", "reward": "식사권 제공", "image": "https://source.unsplash.com/200x100/?restaurant"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("체험단 모집"),
        backgroundColor: Theme.of(context).primaryColor, // 🔹 테마 컬러 적용
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
          IconButton(icon: Icon(Icons.notifications, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // 🔹 배너
          Container(
            height: 180,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: PageView(
              children: [
                Image.network("https://cdn.discordapp.com/attachments/1180835740884684813/1339132664288120853/kkamdaeng9260_Create_an_eye-catching_logo_for_TikTok_with_the_t_66debb65-db0e-4fff-bd3f-ea3ebbf0e917.png?ex=67ad9bfb&is=67ac4a7b&hm=f9fbd03904cc737b6453c9200449b4dbd81e061cbd30a0bb512fbbd04327f699&", fit: BoxFit.cover),
                Image.network("https://cdn.discordapp.com/attachments/1180835740884684813/1338787112065175593/kkamdaeng9260_Create_an_illustration_of_the_TikTok_logo_with_ne_0aad4b16-125a-4813-9929-2ea41e34a662.png?ex=67ad02e8&is=67abb168&hm=a3828393c012b833f767f89ab563565c81726343d6e2892e1a9c8e850fa267a2&", fit: BoxFit.cover),
              ],
            ),
          ),

          // 🔹 카테고리 필터 버튼 (Flutter 블루 적용)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ["전체", "뷰티", "음식", "여행", "패션"]
                  .map((category) => ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[50],
                          foregroundColor: Color(0xFF0175C2),
                        ),
                        child: Text(category),
                      ))
                  .toList(),
            ),
          ),

          // 🔹 체험단 목록
          Expanded(
            child: ListView.builder(
              itemCount: campaigns.length,
              itemBuilder: (context, index) {
                final campaign = campaigns[index];
                return CampaignCard(
                  title: campaign["title"]!,
                  company: campaign["company"]!,
                  reward: campaign["reward"]!,
                  imageUrl: campaign["image"]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
