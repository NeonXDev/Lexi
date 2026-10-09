import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'sleep_models.dart';

class LocalSleepStorage {
  static const String _eventsKey = 'luma_sleep_events';
  static const String _sessionsKey = 'luma_sleep_sessions';

  Future<List<SleepEvent>> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_eventsKey);
    if (jsonString == null || jsonString.isEmpty) return [];
    try {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded
          .map((item) => SleepEvent.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<SleepSession>> loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_sessionsKey);
    if (jsonString == null || jsonString.isEmpty) return [];
    try {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded
          .map((item) => SleepSession.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveEvents(List<SleepEvent> events) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(events.map((e) => e.toJson()).toList());
    await prefs.setString(_eventsKey, encoded);
  }

  Future<void> saveSessions(List<SleepSession> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(sessions.map((s) => s.toJson()).toList());
    await prefs.setString(_sessionsKey, encoded);
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_eventsKey);
    await prefs.remove(_sessionsKey);
  }
}
