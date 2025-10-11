import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EventService {
  static const _queueKey = 'event_queue_v1';

  Future<void> enqueueEvent(Map<String,dynamic> event) async{
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_queueKey) ?? [];
    list.add(jsonEncode(event));
    await prefs.setStringList(_queueKey, list);
  }

  Future<List<Map<String,dynamic>>> readAll() async{
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_queueKey) ?? [];
    return list.map((e) => Map<String,dynamic>.from(jsonDecode(e))).toList();
  }

  Future<void> clear() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_queueKey);
  }
}
