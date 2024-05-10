import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test("Add teacher to Firestore", () async {
    final instance = FakeFirebaseFirestore();

    const teacherID = '18932384';
    const name = 'John Doe';
    const email = 'john@example.com';
    const phone = '123456789';
    const password = '123456';
    const userType = 'teacher';

    await instance.collection('users').doc(teacherID).set({
      'id': teacherID,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'createdAt': Timestamp.now(),
      'userType': userType,
    });

    final snapshot = await instance.collection('users').doc(teacherID).get();
    final data = snapshot.data();

    expect(snapshot.exists, true);
    expect(data?['userType'], userType);
    expect(data?['name'], name);
    expect(data?['email'], email);
    expect(data?['phone'], phone);
    expect(data?['password'], password);
  });
}
