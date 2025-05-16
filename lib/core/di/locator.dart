import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:tdd_art_museum/modules/artwork/service/artwork_remote_service.dart';
import 'package:tdd_art_museum/modules/artwork/service/artwork_remote_service_impl.dart';
import 'package:tdd_art_museum/modules/artwork/view_model/artwork_view_model.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  await dotenv.load();
  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: "https://api.pexels.com",
        headers: {"Authorization": dotenv.get("API_KEY")},
      ),
    ),
  );
  locator.registerLazySingleton<ArtworkRemoteService>(
    () => ArtworkRemoteServiceImpl(locator<Dio>()),
  );
  locator.registerFactory<ArtworkViewModel>(
    () => ArtworkViewModel(locator<ArtworkRemoteService>()),
  );
}
