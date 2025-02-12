class Campaign {
  final String id;
  final String title;
  final String description;
  final String companyName;
  final int maxParticipants;
  final String reward;
  final List<String> applicants;
  final List<String> selectedUsers;
  final String status;

  Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.companyName,
    required this.maxParticipants,
    required this.reward,
    required this.applicants,
    required this.selectedUsers,
    required this.status,
  });

  factory Campaign.fromMap(Map<String, dynamic> data, String documentId) {
    return Campaign(
      id: documentId,
      title: data['title'],
      description: data['description'],
      companyName: data['companyName'],
      maxParticipants: data['maxParticipants'],
      reward: data['reward'],
      applicants: List<String>.from(data['applicants']),
      selectedUsers: List<String>.from(data['selectedUsers']),
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'companyName': companyName,
      'maxParticipants': maxParticipants,
      'reward': reward,
      'applicants': applicants,
      'selectedUsers': selectedUsers,
      'status': status,
    };
  }
}
