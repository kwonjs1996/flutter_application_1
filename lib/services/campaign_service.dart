import '../models/campaign_model.dart';

class CampaignService {
  List<Campaign> _dummyCampaigns = [
    Campaign(
      id: '1',
      title: '신제품 체험단 모집',
      description: '신제품 사용 후 리뷰 작성!',
      companyName: 'ABC 마케팅',
      maxParticipants: 10,
      reward: '10,000원',
      applicants: [],
      selectedUsers: [],
      status: '모집중',
    ),
    Campaign(
      id: '2',
      title: 'SNS 홍보단 모집',
      description: 'SNS에 후기 작성해 주세요!',
      companyName: 'XYZ 기업',
      maxParticipants: 5,
      reward: '무료 제품 제공',
      applicants: [],
      selectedUsers: [],
      status: '모집중',
    ),
  ];

  // 체험단 목록 가져오기
  Future<List<Campaign>> getCampaigns() async {
    return _dummyCampaigns;
  }
}
