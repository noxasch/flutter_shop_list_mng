import 'package:marcusng_todo_app/common.dart';
import 'package:marcusng_todo_app/controllers/controllers.dart';
import 'package:marcusng_todo_app/repositories/custom_exception.dart';
import 'package:marcusng_todo_app/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    ref.listen<CustomException?>(itemListExceptionProvider,
        (CustomException? prevException, CustomException? currentException) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(currentException!.message!)));
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
          leading: user != null
              ? IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () =>
                      ref.read(authControllerProvider.notifier).signOut(),
                )
              : null,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => AddItemDialog.show(context, Item.empty()),
          child: const Icon(Icons.add),
        ),
        body: const ItemList());
  }
}
