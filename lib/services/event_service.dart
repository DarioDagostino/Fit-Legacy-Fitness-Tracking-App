import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/event_model.dart';

class EventService {
  static const _queueKey = 'event_queue_v1';
  static const _maxQueueSize = 1000; // Límite para evitar problemas de memoria

  // Cache para optimizar rendimiento
  List<EventModel>? _eventsCache;
  DateTime? _lastCacheUpdate;

  Future<void> enqueueEvent(EventModel event) async {
    try {
      final events = await readAll();
      
      // Verificar límite de cola
      if (events.length >= _maxQueueSize) {
        // Remover eventos más antiguos (mantener los últimos 800)
        events.removeRange(0, events.length - 800);
      }
      
      events.add(event);
      
      final prefs = await SharedPreferences.getInstance();
      final list = events.map((e) => jsonEncode(e.toJson())).toList();
      await prefs.setStringList(_queueKey, list);
      
      // Actualizar cache
      _eventsCache = List.from(events);
      _lastCacheUpdate = DateTime.now();
    } catch (e) {
      print('Error enqueuing event: $e');
      rethrow;
    }
  }

  Future<List<EventModel>> readAll() async {
    try {
      // Usar cache si está disponible y es reciente (menos de 2 minutos)
      if (_eventsCache != null && 
          _lastCacheUpdate != null && 
          DateTime.now().difference(_lastCacheUpdate!).inMinutes < 2) {
        return _eventsCache!;
      }

      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_queueKey) ?? [];
      
      final events = <EventModel>[];
      for (final item in list) {
        try {
          final json = jsonDecode(item) as Map<String, dynamic>;
          events.add(EventModel.fromJson(json));
        } catch (e) {
          print('Error parsing event: $e');
        }
      }

      _eventsCache = events;
      _lastCacheUpdate = DateTime.now();
      return events;
    } catch (e) {
      print('Error reading events: $e');
      return [];
    }
  }

  Future<List<EventModel>> readByType(String type) async {
    try {
      final allEvents = await readAll();
      return allEvents.where((event) => event.type == type).toList();
    } catch (e) {
      print('Error reading events by type: $e');
      return [];
    }
  }

  Future<List<EventModel>> readRecent({int hours = 24}) async {
    try {
      final allEvents = await readAll();
      final cutoff = DateTime.now().subtract(Duration(hours: hours));
      return allEvents.where((event) => event.timestamp.isAfter(cutoff)).toList();
    } catch (e) {
      print('Error reading recent events: $e');
      return [];
    }
  }

  Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_queueKey);
      
      // Limpiar cache
      _eventsCache = null;
      _lastCacheUpdate = null;
    } catch (e) {
      print('Error clearing events: $e');
      rethrow;
    }
  }

  Future<void> clearOldEvents({int daysOld = 30}) async {
    try {
      final allEvents = await readAll();
      final cutoff = DateTime.now().subtract(Duration(days: daysOld));
      final recentEvents = allEvents.where((event) => event.timestamp.isAfter(cutoff)).toList();
      
      final prefs = await SharedPreferences.getInstance();
      final list = recentEvents.map((e) => jsonEncode(e.toJson())).toList();
      await prefs.setStringList(_queueKey, list);
      
      // Actualizar cache
      _eventsCache = recentEvents;
      _lastCacheUpdate = DateTime.now();
    } catch (e) {
      print('Error clearing old events: $e');
      rethrow;
    }
  }

  // Método para procesar eventos en lote
  Future<void> processBatch(List<EventModel> events) async {
    try {
      for (final event in events) {
        await enqueueEvent(event);
      }
    } catch (e) {
      print('Error processing batch: $e');
      rethrow;
    }
  }

  // Método para obtener estadísticas
  Future<Map<String, int>> getEventStats() async {
    try {
      final events = await readAll();
      final stats = <String, int>{};
      
      for (final event in events) {
        stats[event.type] = (stats[event.type] ?? 0) + 1;
      }
      
      return stats;
    } catch (e) {
      print('Error getting event stats: $e');
      return {};
    }
  }
}
