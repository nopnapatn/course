import 'dart:convert';

import 'package:course/core/utils/typedef.dart';
import 'package:course/src/auth/data/models/user_model.dart';
import 'package:course/src/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  test('should be a subclass of [User] entity', () {
    // Assert
    expect(tModel, isA<User>());
  });

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      // Act
      final result = tModel.toMap();

      // Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [JSON] with the right data', () {
      // Act
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name",
        "avatar": "_empty.avatar",
      });

      // Assert
      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with different data', () {
      // Act
      final result = tModel.copyWith(name: 'Neuw');
      expect(result.name, equals('Neuw'));
    });
  });
}
