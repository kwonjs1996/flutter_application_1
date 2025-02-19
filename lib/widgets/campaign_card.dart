import 'package:flutter/material.dart';
import '../models/campaign_model.dart';
import 'package:intl/intl.dart';

// 🔹 M월 d일 형식으로 변환
String formatDateToKoreanStyle(DateTime date) {
  return DateFormat('M월 d일').format(date);
}

// 🔹 현재 날짜와 캠페인 마감일 비교 후 D-Day 계산
String getDDay(DateTime deadline) {
  final now = DateTime.now(); // 현재 날짜
  final difference = deadline.difference(now).inDays; // 🔹 D-Day 계산

  if (difference > 0) {
    return "D-$difference"; // 🔹 마감일까지 남은 날
  } else if (difference == 0) {
    return "D-Day"; // 🔹 오늘이 마감일
  } else {
    return "D+${difference.abs()}"; // 🔹 마감일이 지난 경우
  }
}

class CampaignCard extends StatelessWidget {
  final Campaign campaign; // ✅ `Campaign` 객체를 직접 받음

  CampaignCard({required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 캠페인 이미지 (배경)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  campaign.imageUrl, // ✅ `Campaign` 객체에서 이미지 가져오기
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),

              // 🔹 캠페인 정보
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(campaign.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text("${campaign.companyName}", style: TextStyle(color: Colors.grey[600])),
                    SizedBox(height: 6),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "보상: ${campaign.reward}",
                        style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "모집: ${campaign.currentParticipants} / ${campaign.maxParticipants} 명",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    SizedBox(height: 6),
                  ],
                ),
              ),
            ],
          ),

          // 🔹 좌측 상단에 D-Day 배지 표시
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6), // 🔹 반투명 배경
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                getDDay(campaign.deadline), // 🔹 D-Day 형식 적용
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
