import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marcusng_todo_app/extensions/firestore_extension.dart';
import 'package:marcusng_todo_app/models/item.dart';

import './base_item_repository.dart';
import '../custom_exception.dart';
import '../firebase_providers.dart';

final itemRepositoryProvider =
    Provider<ItemRepository>((ref) => ItemRepository(ref.read));

class ItemRepository implements BaseItemRepository {
  final Reader _read;

  const ItemRepository(this._read);

  @override
  Future<List<Item>> retrieveItems({required String userId}) async {
    try {
      final snapshot = await _read(firestoreProvider).userListRef(userId).get();
      return snapshot.docs.map((doc) => Item.fromDocument(doc)).toList();
    } on FirebaseException catch (error) {
      throw CustomException(message: error.message);
    }
  }

  @override
  Future<String> createItem(
      {required String userId, required Item item}) async {
    try {
      final docRef = await _read(firestoreProvider)
          .userListRef(userId)
          .add(item.toDocument());
      return docRef.id;
    } on FirebaseException catch (error) {
      throw CustomException(message: error.message);
    }
  }

  @override
  Future<void> updateItem({required String userId, required Item item}) async {
    try {
      await _read(firestoreProvider)
          .userListRef(userId)
          .doc(item.id)
          .update(item.toDocument());
    } on FirebaseException catch (error) {
      throw CustomException(message: error.message);
    }
  }

  @override
  Future<void> deleteItem(
      {required String userId, required String itemId}) async {
    try {
      await _read(firestoreProvider)
          .collection('lists')
          .doc(userId)
          .collection('userList')
          .doc(itemId)
          .delete();
    } on FirebaseException catch (error) {
      throw CustomException(message: error.message);
    }
  }
}
