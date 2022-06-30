import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreUserList on FirebaseFirestore {
  CollectionReference userListRef(String userId) =>
      collection('list').doc(userId).collection('userList');
}
