import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  group('Edit field', () {
    late FakeFirebaseFirestore fakeFirestore;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      fakeFirestore.collection('users').doc('1').set({
        'name': 'John Doe',
        'email': 'john@example.com',
        'phone': '123456789',
      });
    });

    test('Updating Firestore document', () async {
      await fakeFirestore
          .collection('users')
          .doc('1')
          .update({'name': 'Alice'});

      await fakeFirestore.collection('users').doc('1').get().then((snapshot) {
        expect(snapshot.data()?['name'], 'Alice');
      });
    });
  });
}
