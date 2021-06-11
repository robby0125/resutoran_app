import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:resutoran_app/core/data/datasources/auth_datasource.dart';
import 'package:resutoran_app/core/data/datasources/auth_datasource_impl.dart';
import 'package:resutoran_app/core/data/datasources/firestore_datasource.dart';
import 'package:resutoran_app/core/data/datasources/firestore_datasource_impl.dart';
import 'package:resutoran_app/core/data/repositories/auth_repository_impl.dart';
import 'package:resutoran_app/core/data/repositories/firestore_repository_impl.dart';
import 'package:resutoran_app/core/domain/interactors/auth_interactor.dart';
import 'package:resutoran_app/core/domain/interactors/firestore_interactor.dart';
import 'package:resutoran_app/core/domain/repositories/auth_repository.dart';
import 'package:resutoran_app/core/domain/repositories/firestore_repository.dart';
import 'package:resutoran_app/core/domain/usecases/auth_usecase.dart';
import 'package:resutoran_app/core/domain/usecases/firestore_usecase.dart';
import 'package:resutoran_app/core/presentation/providers/auth_provider.dart';
import 'package:resutoran_app/core/presentation/providers/firestore_provider.dart';

class Injection {
  static Future<void> init() async {
    Get.put<FirestoreDataSource>(
      FirestoreDataSourceImpl(FirebaseFirestore.instance),
    );
    Get.put<FirestoreRepository>(
      FirestoreRepositoryImpl(Get.find()),
    );
    Get.put<FirestoreUseCase>(
      FirestoreInteractor(Get.find()),
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

    Get.put<FirestoreProvider>(
      FirestoreProvider(Get.find()),
    );
    Get.put<AuthProvider>(
      AuthProvider(Get.find(), Get.find()),
    );
  }
}
