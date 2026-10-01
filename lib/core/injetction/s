
import 'package:firebase_database/firebase_database.dart' as databaseReference;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:grace_church/core/injection/injection_container.config.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart' as shareData;
//import 'injection.config.dart'; // généré

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() => getIt.init();
Future<void> configureDependenciesTest() async {}

@module
abstract class InjectableModule {
  @lazySingleton
  databaseReference.DatabaseReference get userDb =>
      databaseReference.FirebaseDatabase.instance.ref();
  @preResolve
  @lazySingleton
  Future<shareData.SharedPreferences> locaDataShared() async {
    final sharePreference = await shareData.SharedPreferences.getInstance();
    return sharePreference;
  }

  // final sharedPreferences = await SharedPreferences.getInstance();

  @lazySingleton
  http.Client get httpClient => InterceptedClient.build(
    interceptors: [
      // AuthInterceptor(getIt(), getIt()),
      // LoggingInterceptor(),
    ],
    client: http.Client(),
    // retryPolicy: ExpiredTokenRetryPolicy(getIt(), getIt()),
  );


  @lazySingleton
  FlutterSecureStorage get prefs => const FlutterSecureStorage();

}

// abstract class Env {
//   static const test = 'test';
//   static const dev = 'dev';
//   static const prod = 'prod';
// }
