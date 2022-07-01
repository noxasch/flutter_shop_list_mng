import 'package:marcusng_todo_app/common.dart';
import 'package:marcusng_todo_app/controllers/item_list_controller.dart';
import 'package:marcusng_todo_app/widgets/item_list.dart';

class ItemTile extends ConsumerWidget {
  const ItemTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(currentItem)!;

    return ListTile(
      key: ValueKey(item.id),
      title: Text(item.name),
      trailing: Checkbox(
        value: item.obtained,
        onChanged: (val) => ref
            .read(itemListControllerProvider.notifier)
            .updateItem(updatedItem: item.copyWith(obtained: !item.obtained)),
      ),
    );
  }
}
