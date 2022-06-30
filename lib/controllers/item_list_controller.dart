import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marcusng_todo_app/controllers/auth_controller.dart';
import 'package:marcusng_todo_app/models/item.dart';
import 'package:marcusng_todo_app/repositories/custom_exception.dart';
import 'package:marcusng_todo_app/repositories/item_repository/item_repository.dart';

// to show the error in snackbar instead of full screen error message
final itemListExceptionProvider = StateProvider<CustomException?>((_) => null);

final itemListControllerProvider =
    StateNotifierProvider<ItemListController, AsyncValue<List<Item>>>((ref) {
  final user = ref.watch(authControllerProvider);
  return ItemListController(ref.read, user?.uid);
});

/// maintain the state of items
/// loading, data, error
/// AsyncValue is an alternative to FutureBuilder and StreamBuilder
/// from riverpod
class ItemListController extends StateNotifier<AsyncValue<List<Item>>> {
  final Reader _read;
  final String? _userId;

  ItemListController(this._read, this._userId)
      : super(const AsyncValue.loading()) {
    if (_userId != null) {
      retrieveItems();
    }
  }

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncValue.loading();

    try {
      final items =
          await _read(itemRepositoryProvider).retrieveItems(userId: _userId!);
      state = AsyncValue.data(items);
    } on CustomException catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace: stackTrace);
    }
  }

  Future<void> addItem({required String name, bool obtained = false}) async {
    try {
      final item = Item(name: name, obtained: obtained);
      final itemId = await _read(itemRepositoryProvider)
          .createItem(userId: _userId!, item: item);
      state.whenData((items) =>
          state = AsyncValue.data(items..add(item.copyWith(id: itemId))));
    } on CustomException catch (error) {
      _read(itemListExceptionProvider.state).state = error;
    }
  }

  Future<void> updateItem({required Item updatedItem}) async {
    try {
      await _read(itemRepositoryProvider)
          .updateItem(userId: _userId!, item: updatedItem);

      state.whenData((items) {
        final index = items.indexWhere((item) => item.id == updatedItem.id);
        items[index] = updatedItem;
        state = AsyncValue.data(items);

        // state = AsyncValue.data([
        //    for (final item in items)
        //       if (item.id == updatedItem.id) updatedItem else item
        // ]);
      });
    } on CustomException catch (error) {
      _read(itemListExceptionProvider.state).state = error;
    }
  }

  Future<void> deleteItem({required String itemId}) async {
    try {
      await _read(itemRepositoryProvider)
          .deleteItem(userId: _userId!, itemId: itemId);
      state.whenData((items) {
        state =
            AsyncValue.data(items..removeWhere((item) => item.id == itemId));
      });
    } on CustomException catch (error) {
      _read(itemListExceptionProvider.state).state = error;
    }
  }
}
