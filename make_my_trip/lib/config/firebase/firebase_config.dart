import 'dart:convert';

/// To Do : add this file path into .gitignore file
abstract class FirebaseConfig {
  String config(String mode);
}

class FirebaseConfigModel {
  const FirebaseConfigModel({
    required this.apiKey,
    required this.authDomain,
    required this.databaseURL,
    required this.projectId,
    required this.storageBucket,
    required this.messagingSenderId,
    required this.appId,
    required this.measurementId,
  });

  final String apiKey;
  final String authDomain;
  final String databaseURL;
  final String projectId;
  final String storageBucket;
  final String messagingSenderId;
  final String appId;
  final String measurementId;

  String toJson() => jsonEncode({
        'apiKey': apiKey,
        'authDomain': authDomain,
        'databaseURL': databaseURL,
        'projectId': projectId,
        'storageBucket': storageBucket,
        'messagingSenderId': messagingSenderId,
        'appId': appId,
        'measurementId': measurementId
      });
}

class FirebaseConfigImpl extends FirebaseConfig {
  @override
  String config(String mode) {
    switch (mode) {
      case 'production':
        return const FirebaseConfigModel(
                apiKey: '',
                authDomain: '',
                databaseURL: '',
                projectId: '',
                storageBucket: '',
                messagingSenderId: '',
                appId: '',
                measurementId: '')
            .toJson();

      case 'staging':
        return const FirebaseConfigModel(
                apiKey: '',
                authDomain: '',
                databaseURL: '',
                projectId: '',
                storageBucket: '',
                messagingSenderId: '',
                appId: '',
                measurementId: '')
            .toJson();

      default:
        return const FirebaseConfigModel(
                apiKey: '',
                authDomain: '',
                databaseURL: '',
                projectId: '',
                storageBucket: '',
                messagingSenderId: '',
                appId: '',
                measurementId: '')
            .toJson();
    }
  }
}
