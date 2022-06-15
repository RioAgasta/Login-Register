import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:projectrio/services/api_service.dart';
import 'package:projectrio/services/navigation_service.dart';
import 'package:projectrio/services/geolocator_service.dart';
import 'package:projectrio/services/location_service.dart';
import 'package:projectrio/services/alert_service.dart';
import 'package:projectrio/services/storage_service.dart';
import 'package:projectrio/services/rmq_service.dart';
import 'package:projectrio/services/ftp_service.dart';
import 'package:projectrio/services/database_handler.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => GeolocatorService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => AlertService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => RmqService());
  locator.registerLazySingleton(() => FtpService());
  locator.registerLazySingleton(() => DatabaseHandler());
}