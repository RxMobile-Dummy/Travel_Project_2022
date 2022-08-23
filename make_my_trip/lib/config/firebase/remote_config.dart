import 'package:firebase_remote_config/firebase_remote_config.dart';

RemoteConfigManager? remoteConfigManager = RemoteConfigManager();

///RemoteConfigManager
///
///This class is used to fetch and refresh remote config data.
class RemoteConfigManager {
  late FirebaseRemoteConfig? _firebaseRemoteConfig;
  RemoteConfigManager() {
    _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    updateData();
  }
  Future<void> remoteConfigSettings() async {
    await _firebaseRemoteConfig?.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 50),
    ));
  }

  Future<void> updateData() async {
    await _firebaseRemoteConfig?.fetchAndActivate();
  }

  String? getStringData(String key) {
    return _firebaseRemoteConfig?.getString(key);
  }

  Future<int?> getIntData(String key) async {
    return _firebaseRemoteConfig?.getInt(key);
  }

  Future<bool?> getBooleanData(String key) async {
    return _firebaseRemoteConfig?.getBool(key);
  }

  Future<RemoteConfigValue?> getJsonData(String key) async {
    return _firebaseRemoteConfig?.getAll()[key];
  }
}
