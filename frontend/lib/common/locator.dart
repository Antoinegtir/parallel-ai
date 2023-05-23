import 'package:get_it/get_it.dart';
import 'package:parallels/helper/shared_prefrence_helper.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper());
}
