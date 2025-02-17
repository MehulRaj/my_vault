import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_vault/features/savings/core/hive/hive_boxes.dart';
import 'package:path_provider/path_provider.dart';

import 'app_routes.dart';
import 'features/savings/core/constants.dart';
import 'features/savings/core/helpers/local_storage_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageHelper.init();
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  await HiveBoxes.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: "KK",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: Constant.mainScreenPath,
      ),
    );
  }
}
