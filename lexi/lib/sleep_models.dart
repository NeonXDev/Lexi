class SleepEvent {
  final DateTime time;
  final String kind;
  final String detail;
  final double decibels;
  final bool isSnore;

  SleepEvent({
    required this.time,
    required this.kind,
    required this.detail,
    required this.decibels,
    required this.isSnore,
  });

  Map<String, dynamic> toJson() {
    return {
      'time': time.toIso8601String(),
      'kind': kind,
      'detail': detail,
      'decibels': decibels,
      'isSnore': isSnore,
    };
  }

  factory SleepEvent.fromJson(Map<String, dynamic> json) {
    return SleepEvent(
      time: DateTime.parse(json['time'] as String),
      kind: json['kind'] as String,
      detail: json['detail'] as String,
      decibels: (json['decibels'] as num).toDouble(),
      isSnore: json['isSnore'] as bool,
    );
  }
}

class SleepSession {
  final DateTime startedAt;
  final DateTime endedAt;
  final String? audioPath;

  SleepSession({
    required this.startedAt,
    required this.endedAt,
    this.audioPath,
  });

  Duration get duration => endedAt.difference(startedAt);

  Map<String, dynamic> toJson() {
    return {
      'startedAt': startedAt.toIso8601String(),
      'endedAt': endedAt.toIso8601String(),
      if (audioPath != null) 'audioPath': audioPath,
    };
  }

  factory SleepSession.fromJson(Map<String, dynamic> json) {
    return SleepSession(
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: DateTime.parse(json['endedAt'] as String),
      audioPath: json['audioPath'] as String?,
    );
  }
}
