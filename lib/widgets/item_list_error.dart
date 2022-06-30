import 'package:marcusng_todo_app/common.dart';
import 'package:marcusng_todo_app/controllers/item_list_controller.dart';

class ItemListError extends ConsumerWidget {
  final String message;

  const ItemListError({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
              onPressed: () {
                ref
                    .read(itemListControllerProvider.notifier)
                    .retrieveItems(isRefreshing: true);
              },
              child: const Text('Retry')),
        ],
      ),
    );
  }
}
