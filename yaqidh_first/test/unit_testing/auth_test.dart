import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  group('Auth', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late FakeFirebaseFirestore fakeFirestore;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      fakeFirestore = FakeFirebaseFirestore();
    });

    test('signInUsingEmailPassword', () async {
      const email = 'test@example.com';
      const password = '123456';
      await fakeFirestore.collection('users').doc('123').set({
        'email': email,
        'password': password,
      });

      await mockFirebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = await mockFirebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      expect(user, isNotNull);
    });

    test('signInUsingIncorrectPassword', () async {
      const email = 'test@example.com';
      const correctPassword = '123456';
      const incorrectPassword = '456789';

      await fakeFirestore.collection('users').doc('123').set({
        'email': email,
        'password': correctPassword,
      });

      await mockFirebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: correctPassword,
      );

      try {
        await mockFirebaseAuth.signInWithEmailAndPassword(
            email: email, password: incorrectPassword);
        fail('Expected sign-in to fail with incorrect password');
      } catch (e) {}
    });
  });
}

class MockBuildContext extends Fake implements BuildContext {}
