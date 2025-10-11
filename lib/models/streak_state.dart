import 'dart:convert';

class StreakState {
  final String streakId;
  final String type; // 'daily' | 'weekly' | 'habit'
  final int length;
  final String? lastUpdated; // ISO
  final int best;
  final bool active;

  StreakState({required this.streakId, required this.type, required this.length, this.lastUpdated, required this.best, required this.active});

  StreakState copyWith({String? streakId, String? type, int? length, String? lastUpdated, int? best, bool? active}){
    return StreakState(
      streakId: streakId ?? this.streakId,
      type: type ?? this.type,
      length: length ?? this.length,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      best: best ?? this.best,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'streakId': streakId,
      'type': type,
      'length': length,
      'lastUpdated': lastUpdated,
      'best': best,
      'active': active,
    };
  }

  static StreakState fromJson(Map<String,dynamic> j){
    return StreakState(
      streakId: j['streakId'],
      type: j['type'],
      length: j['length'],
      lastUpdated: j['lastUpdated'],
      best: j['best'],
      active: j['active'],
    );
  }

  String toRawJson(){
    return jsonEncode(toJson());
  }

  static StreakState? fromRawJson(String? str){
    if(str==null) return null;
    return fromJson(jsonDecode(str));
  }
}
