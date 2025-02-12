import 'package:flutter/material.dart';

class CampaignCard extends StatelessWidget {
  final String title;
  final String company;
  final String reward;
  final String imageUrl;

  CampaignCard({
    required this.title,
    required this.company,
    required this.reward,
    this.imageUrl = "https://source.unsplash.com/200x100/?product",
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(imageUrl, width: double.infinity, height: 140, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text("주최: $company", style: TextStyle(color: Colors.grey[600])),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("보상: $reward", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("지원하기"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
