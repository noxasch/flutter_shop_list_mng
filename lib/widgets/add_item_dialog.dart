import 'package:marcusng_todo_app/common.dart';
import 'package:marcusng_todo_app/controllers/item_list_controller.dart';

class AddItemDialog extends HookConsumerWidget {
  final Item item;

  const AddItemDialog({Key? key, required this.item}) : super(key: key);

  bool get isUpdating => item.id == null;

  static void show(BuildContext context, Item item) {
    showDialog(
        context: context, builder: (context) => AddItemDialog(item: item));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = TextEditingController(text: item.name);

    void addItem() {
      ref
          .read(itemListControllerProvider.notifier)
          .addItem(name: textEditingController.text.trim());
    }

    void updateItem() {
      ref.read(itemListControllerProvider.notifier).updateItem(
          updatedItem: item.copyWith(name: textEditingController.text.trim()));
    }

    void onAddItem() {
      isUpdating ? addItem() : updateItem();
      Navigator.of(context).pop();
    }

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // take minimum size only as required
          children: [
            TextField(
              controller: textEditingController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Item name'),
            ),
            const SizedBox(
              height: 12.0,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: isUpdating
                          ? Colors.orange
                          : Theme.of(context).primaryColor),
                  onPressed: onAddItem,
                  child: Text(isUpdating ? 'Update' : 'Add')),
            )
          ],
        ),
      ),
    );
  }
}
