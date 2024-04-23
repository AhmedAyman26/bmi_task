import 'package:bmi_task/core/di/app_injector.dart';
import 'package:bmi_task/core/utils/network_info.dart';
import 'package:bmi_task/features/bmi/data/repository/bmi_repository_impl.dart';
import 'package:bmi_task/features/bmi/domain/repository/bmi_repository.dart';
import 'package:bmi_task/features/bmi/domain/use_cases/add_bmi_entries_to_firebase_use_case.dart';
import 'package:bmi_task/features/bmi/domain/use_cases/delete_bmi_entry_use_case.dart';
import 'package:bmi_task/features/bmi/domain/use_cases/get_bmi_entries_use_case.dart';
import 'package:bmi_task/features/bmi/domain/use_cases/update_bmi_entry_use_case.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class BmiDi
{
  BmiDi._();

  static void initialize()
  {
    injector.registerLazySingleton<BMIRepository>(() => BMIRepositoryImpl(NetworkInfoImpl(InternetConnectionChecker())));

    injector.registerFactory(() => AddBmiEntriesToFirebaseUseCase(injector()));
    injector.registerFactory(() => GetBmiEntriesUseCase(injector()));
    injector.registerFactory(() => UpdateBmiEntryUseCase(injector()));
    injector.registerFactory(() => DeleteBmiEntryUseCase(injector()));
  }
}