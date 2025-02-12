import 'package:flutter/material.dart';
import '../services/campaign_service.dart';
import '../models/campaign_model.dart';
import '../widgets/campaign_card.dart';

class CampaignListScreen extends StatefulWidget {
  @override
  _CampaignListScreenState createState() => _CampaignListScreenState();
}

class _CampaignListScreenState extends State<CampaignListScreen> {
  final CampaignService _campaignService = CampaignService();
  List<Campaign> _campaigns = [];

  @override
  void initState() {
    super.initState();
    _loadCampaigns();
  }

  void _loadCampaigns() async {
    List<Campaign> campaigns = await _campaignService.getCampaigns();
    setState(() {
      _campaigns = campaigns;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("체험단 목록")),
      body: ListView.builder(
        itemCount: _campaigns.length,
        itemBuilder: (context, index) {
          Campaign campaign = _campaigns[index];
          return CampaignCard(
            title: campaign.title,
            company: campaign.companyName,
            reward: campaign.reward,
          );
        },
      ),
    );
  }
}
