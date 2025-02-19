import '../models/campaign_model.dart';


class CampaignService {
  Future<List<Campaign>> getMyCampaigns(String userId) async {
    List<Campaign> allCampaigns = await getCampaigns();

    // ✅ 사용자가 참여한 캠페인만 필터링
    return allCampaigns.where((campaign) {
      return campaign.participants.contains(userId);
    }).toList();
  }

  Future<List<Campaign>> getCompletedCampaigns(String userId) async {
    List<Campaign> myCampaigns = await getMyCampaigns(userId);
    DateTime now = DateTime.now(); // 현재 날짜

    // ✅ 마감일이 지났다면 완료된 캠페인으로 간주
    return myCampaigns.where((campaign) {
      return campaign.deadline.isBefore(now);
    }).toList();
  }
  Future<List<Campaign>> getCampaigns() async {
    await Future.delayed(Duration(seconds: 0)); // 🔹 데이터 로딩 시뮬레이션

    return [
      Campaign(
        title: "신제품 체험단",
        companyName: "ABC 마케팅",
        reward: "무료 제품 제공",
        imageUrl: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&auto=format&fit=crop&q=60",
        currentParticipants: 0,
        maxParticipants: 10,
        advertiserId: "2",
        deadline: DateTime(2024,05,31),
      ),
      Campaign(
        title: "SNS 홍보단",
        companyName: "XYZ 기업",
        reward: "10,000원",
        imageUrl: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&auto=format&fit=crop&q=60",
        currentParticipants: 18,
        maxParticipants: 15,
        advertiserId: "1",
        deadline: DateTime(2024,05,31),
      ),
      Campaign(
        title: "레스토랑 방문 리뷰",
        companyName: "맛집 서포터즈",
        reward: "식사권 제공",
        imageUrl: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&auto=format&fit=crop&q=60",
        currentParticipants: 10,
        maxParticipants: 20,
        advertiserId: "1",
        deadline: DateTime(2024,05,31),
      ),
      Campaign(
        title: "뷰티 체험단",
        companyName: "코스메틱 브랜드 A",
        reward: "화장품 샘플 제공",
        imageUrl: "https://plus.unsplash.com/premium_photo-1674739375749-7efe56fc8bbb?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c2tpbmNhcmV8ZW58MHx8MHx8fDA%3D",
        currentParticipants: 12,
        maxParticipants: 25,
        advertiserId: "1",
        deadline: DateTime(2024,05,31),
      ),
      Campaign(
        title: "가전제품 리뷰어 모집",
        companyName: "테크 기업 B",
        reward: "전자제품 무상 제공",
        imageUrl: "https://plus.unsplash.com/premium_photo-1674739375749-7efe56fc8bbb?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c2tpbmNhcmV8ZW58MHx8MHx8fDA%3D",
        currentParticipants: 2,
        maxParticipants: 5,
        advertiserId: "2",
        deadline: DateTime(2025,05,31),
      ),
      Campaign(
        title: "여행 체험단 모집",
        companyName: "트래블 에이전시 C",
        reward: "해외 여행 지원",
        imageUrl: "https://plus.unsplash.com/premium_photo-1674739375749-7efe56fc8bbb?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c2tpbmNhcmV8ZW58MHx8MHx8fDA%3D",
        currentParticipants: 3,
        maxParticipants: 8,
        advertiserId: "1",
        deadline: DateTime(2024,05,31),
      ),
      Campaign(
        title: "헬스 & 피트니스 챌린지",
        companyName: "헬스케어 기업 D",
        reward: "운동 장비 제공",
        imageUrl: "https://plus.unsplash.com/premium_photo-1674739375749-7efe56fc8bbb?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c2tpbmNhcmV8ZW58MHx8MHx8fDA%3D",
        currentParticipants: 6,
        maxParticipants: 12,
        advertiserId: "admin",
        deadline: DateTime(2024,05,31),
      ),
      Campaign(
        title: "책 리뷰어 모집",
        companyName: "출판사 E",
        reward: "신간 도서 제공",
        imageUrl: "https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8JUVDJUEwJTlDJUVEJTkyJTg4fGVufDB8fDB8fHww",
        currentParticipants: 15,
        maxParticipants: 30,
        advertiserId: "admin",
        deadline: DateTime(2024,05,31),
      ),
      Campaign(
        title: "홈 인테리어 체험단",
        companyName: "인테리어 브랜드 F",
        reward: "가구 지원",
        imageUrl: "https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8JUVDJUEwJTlDJUVEJTkyJTg4fGVufDB8fDB8fHww",
        currentParticipants: 7,
        maxParticipants: 10,
        advertiserId: "123",
        deadline: DateTime(2025,05,31),
      ),
      Campaign(
        title: "반려동물 제품 체험단",
        companyName: "펫 브랜드 G",
        reward: "반려동물 용품 제공",
        imageUrl: "https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8JUVDJUEwJTlDJUVEJTkyJTg4fGVufDB8fDB8fHww",
        currentParticipants: 10,
        maxParticipants: 20,
        advertiserId: "123",
        deadline: DateTime(2024,05,31), // 📅 2024년 5월 31일로 설정
      ),
      Campaign(
        title: "스포츠 용품 리뷰",
        companyName: "스포츠 브랜드 H",
        reward: "운동 용품 제공",
        imageUrl: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fCVFQyVBMCU5QyVFRCU5MiU4OHxlbnwwfHwwfHx8MA%3D%3D",
        currentParticipants: 5,
        maxParticipants: 12,
        advertiserId: "1",
        deadline: DateTime(2025,05,31),
      ),
      Campaign(
        title: "음식 체험단 모집",
        companyName: "푸드 브랜드 I",
        reward: "무료 식사 제공",
        imageUrl: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fCVFQyVBMCU5QyVFRCU5MiU4OHxlbnwwfHwwfHx8MA%3D%3D",
        currentParticipants: 30,
        maxParticipants: 50,
        advertiserId: "123",
        deadline: DateTime(2024,05,31),
      ),
      Campaign(
        title: "스마트폰 액세서리 체험단",
        companyName: "모바일 브랜드 J",
        reward: "스마트폰 액세서리 제공",
        imageUrl: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fCVFQyVBMCU5QyVFRCU5MiU4OHxlbnwwfHwwfHx8MA%3D%3D",
        currentParticipants: 8,
        maxParticipants: 15,
        advertiserId: "1",
        deadline: DateTime(2024,05,31),
      ),
      Campaign(
        title: "에코 친환경 제품 체험",
        companyName: "지속 가능 브랜드 K",
        reward: "친환경 제품 제공",
        imageUrl: "https://images.unsplash.com/photo-1586495777744-4413f21062fa?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fCVFQyVBMCU5QyVFRCU5MiU4OHxlbnwwfHwwfHx8MA%3D%3D",
        currentParticipants: 9,
        maxParticipants: 18,
        advertiserId: "1",
        deadline: DateTime(2025,05,31),
      ),
    ];
  }
  }
  
