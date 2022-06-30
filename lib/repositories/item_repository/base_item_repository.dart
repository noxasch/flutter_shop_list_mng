import 'package:marcusng_todo_app/models/item.dart';


abstract class BaseItemRepository {
  Future<List<Item>> retrieveItems({ required String userId});
  Future<String> createItem({ required String userId, required Item item});
  Future<void> updateItem({ required String userId, required Item item});
  Future<void> deleteItem({ required String userId, required String itemId});
}
