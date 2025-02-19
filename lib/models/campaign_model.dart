class Campaign {
  final String title;
  final String companyName;
  final String reward;
  final String imageUrl;
  final int currentParticipants;
  final int maxParticipants;
  final String advertiserId; // ✅ 광고주 ID
  final DateTime deadline;
  final List<String> participants; // ✅ 참여한 사용자 ID 리스트 추가

  Campaign({
    required this.title,
    required this.companyName,
    required this.reward,
    required this.imageUrl,
    required this.currentParticipants,
    required this.maxParticipants,
    required this.advertiserId,
    required this.deadline,
    this.participants = const [], // 기본값 빈 리스트
  });

  // ✅ JSON 데이터를 `Campaign` 객체로 변환하는 메서드 (백엔드 연동 대비)
  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      title: json["title"] ?? "제목 없음",
      companyName: json["companyName"] ?? "주최사 정보 없음",
      reward: json["reward"] ?? "보상 없음",
      imageUrl: json["imageUrl"] ?? "https://images.unsplash.com/photo-1523318140688-03662c0cba35?w=400&auto=format&fit=crop&q=60",
      currentParticipants: json["currentParticipants"] ?? 0,
      maxParticipants: json["maxParticipants"] ?? 0,
      advertiserId: json["advertiserId"] ?? "unknown",
      participants: List<String>.from(json["participants"] ?? []), // ✅ JSON 리스트 변환
      deadline: json["deadline"] != null
      ? DateTime.parse(json["deadline"])  // ✅ `null`이 아닐 경우 파싱
      : DateTime(2100, 01, 01),           // ✅ `null`이면 기본값 설정
    );
  }

  // ✅ `Campaign` 객체를 JSON으로 변환하는 메서드 (백엔드로 전송 시 활용)
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "companyName": companyName,
      "reward": reward,
      "imageUrl": imageUrl,
      "currentParticipants": currentParticipants,
      "maxParticipants": maxParticipants,
      "advertiserId": advertiserId,
      "deadline" : deadline.toIso8601String(), //✅ DateTime -> 문자열 변환
      "participants": participants, // ✅ 참여자 리스트 추가
    };
  }
}
