import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferencesWithCache> getSharedPreferences() async {
  return await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
    allowList: {"username", "password"},
  ));
}
