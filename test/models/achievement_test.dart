
import 'package:flutter_test/flutter_test.dart';
import 'package:fit_legacy_app/models/achievement.dart';

void main() {
  group('Achievement', () {
    test('Achievement can be created', () {
      final achievement = Achievement(
        id: '1',
        title: 'Test Achievement',
        description: 'This is a test achievement.',
        date: '2024-07-24',
        reward: 100,
      );

      expect(achievement.id, '1');
      expect(achievement.title, 'Test Achievement');
      expect(achievement.description, 'This is a test achievement.');
      expect(achievement.date, '2024-07-24');
      expect(achievement.reward, 100);
    });

    test('Achievement can be serialized to and deserialized from JSON', () {
      final achievement = Achievement(
        id: '1',
        title: 'Test Achievement',
        description: 'This is a test achievement.',
        date: '2024-07-24',
        reward: 100,
      );

      final json = achievement.toJson();
      final newAchievement = Achievement.fromJson(json);

      expect(newAchievement, achievement);
    });
  });
}
