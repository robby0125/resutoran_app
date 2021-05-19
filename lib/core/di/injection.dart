import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:resutoran_app/core/data/datasources/restaurant_datasource.dart';
import 'package:resutoran_app/core/data/datasources/restaurant_datasource_impl.dart';
import 'package:resutoran_app/core/data/repositories/restaurant_repository_impl.dart';
import 'package:resutoran_app/core/domain/interactors/restaurant_interactor.dart';
import 'package:resutoran_app/core/domain/repositories/restaurant_repository.dart';
import 'package:resutoran_app/core/domain/usecases/restaurant_usecase.dart';
import 'package:resutoran_app/core/presentation/provider/restaurant_provider.dart';

class Injection {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt.registerFactory<RestaurantDataSource>(
      () => RestaurantDataSourceImpl(FirebaseFirestore.instance),
    );
    getIt.registerFactory<RestaurantRepository>(
      () => RestaurantRepositoryImpl(getIt.call()),
    );
    getIt.registerFactory<RestaurantUseCase>(
      () => RestaurantInteractor(getIt.call()),
    );

    getIt.registerLazySingleton<RestaurantProvider>(
      () => RestaurantProvider(getIt.call()),
    );
  }
}
