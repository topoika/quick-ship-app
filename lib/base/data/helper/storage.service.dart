part of "../data.dart";

final localStorageBox = Hive.box(AppStrings.localStorageBox);

class Storage {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(AppStrings.localStorageBox);
  }

  static void saveData(String key, dynamic value) {
    localStorageBox.put(key, value);
  }

  static dynamic getData(String key, {dynamic defaultValue}) {
    return localStorageBox.get(key, defaultValue: defaultValue);
  }

  // delete data from local storage
  static void deleteData(String key) {
    localStorageBox.delete(key);
  }
}
