import 'dart:convert';

class Achievement {
  final String id;
  final String title;
  final String description;
  final String date; // ISO
  final int reward;
  final Map<String, dynamic>? metadata;

  Achievement({required this.id, required this.title, required this.description, required this.date, required this.reward, this.metadata});

  Map<String,dynamic> toJson(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'reward': reward,
      'metadata': metadata,
    };
  }

  static Achievement fromJson(Map<String,dynamic> j){
    return Achievement(
      id: j['id'],
      title: j['title'],
      description: j['description'],
      date: j['date'],
      reward: j['reward'],
      metadata: j['metadata'] == null ? null : Map<String,dynamic>.from(j['metadata']),
    );
  }

  String toRawJson(){
    return jsonEncode(toJson());
  }

  static Achievement? fromRawJson(String? s){
    if(s==null) return null;
    return fromJson(jsonDecode(s));
  }
}
