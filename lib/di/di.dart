import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app_flutter/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
configureDependencies() async => getIt.init();