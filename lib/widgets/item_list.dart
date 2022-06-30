import 'package:marcusng_todo_app/common.dart';
import 'package:marcusng_todo_app/controllers/item_list_controller.dart';
import 'package:marcusng_todo_app/repositories/custom_exception.dart';
import 'package:marcusng_todo_app/widgets/item_list_error.dart';
import 'package:marcusng_todo_app/widgets/item_tile.dart';

final currentItem = Provider<Item?>(
  (ref) => null,
);

class ItemList extends ConsumerWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Item>> itemList =
        ref.watch(itemListControllerProvider);
    final filteredItemList = ref.watch(filteredItemListProvider);

    return itemList.when(
        data: (List<Item> items) {
          if (items.isEmpty) {
            return const Center(
              child: Text(
                'Tap + to add an item',
                style: TextStyle(fontSize: 20.0),
              ),
            );
          }

          return ListView.builder(
            itemCount: filteredItemList.length,
            itemBuilder: (BuildContext context, int index) {
              final item = filteredItemList[index];

              return ProviderScope(
                  overrides: [currentItem.overrideWithValue(item)],
                  child: const ItemTile());
              // return ListTile(
              //   key: ValueKey(item.id),
              //   title: Text(item.name),
              //   trailing: Checkbox(
              //     value: item.obtained,
              //     onChanged: (val) => ref
              //         .read(itemListControllerProvider.notifier)
              //         .updateItem(
              //             updatedItem: item.copyWith(obtained: !item.obtained)),
              //   ),
              // );
            },
          );
        },
        error: (error, _) {
          return ItemListError(
              message: error is CustomException
                  ? error.message!
                  : 'Something went wrong!');
        },
        loading: () => const CircularProgressIndicator());
  }
}
