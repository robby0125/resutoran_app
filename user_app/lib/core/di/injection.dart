import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:resutoran_app/core/data/datasources/auth_datasource.dart';
import 'package:resutoran_app/core/data/datasources/auth_datasource_impl.dart';
import 'package:resutoran_app/core/data/datasources/restaurant_datasource.dart';
import 'package:resutoran_app/core/data/datasources/restaurant_datasource_impl.dart';
import 'package:resutoran_app/core/data/repositories/auth_repository_impl.dart';
import 'package:resutoran_app/core/data/repositories/restaurant_repository_impl.dart';
import 'package:resutoran_app/core/domain/interactors/auth_interactor.dart';
import 'package:resutoran_app/core/domain/interactors/restaurant_interactor.dart';
import 'package:resutoran_app/core/domain/repositories/auth_repository.dart';
import 'package:resutoran_app/core/domain/repositories/restaurant_repository.dart';
import 'package:resutoran_app/core/domain/usecases/auth_usecase.dart';
import 'package:resutoran_app/core/domain/usecases/restaurant_usecase.dart';
import 'package:resutoran_app/core/presentation/providers/auth_provider.dart';
import 'package:resutoran_app/core/presentation/providers/restaurant_provider.dart';

class Injection {
  static Future<void> init() async {
    Get.put<RestaurantDataSource>(
      RestaurantDataSourceImpl(FirebaseFirestore.instance),
    );
    Get.put<RestaurantRepository>(
      RestaurantRepositoryImpl(Get.find()),
    );
    Get.put<RestaurantUseCase>(
      RestaurantInteractor(Get.find()),
    );
    Get.put<AuthDataSource>(
      AuthDataSourceImpl(FirebaseAuth.instance),
    );
    Get.put<AuthRepository>(
      AuthRepositoryImpl(Get.find()),
    );
    Get.put<AuthUseCase>(
      AuthInteractor(Get.find()),
    );

    Get.put<RestaurantProvider>(
      RestaurantProvider(Get.find()),
    );
    Get.put<AuthProvider>(
      AuthProvider(Get.find()),
    );
  }
}
