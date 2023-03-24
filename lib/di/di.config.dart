// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:to_do_app_flutter/bloc/home_viewmodel.dart' as _i5;
import 'package:to_do_app_flutter/database/database_helper.dart' as _i3;
import 'package:to_do_app_flutter/manager/DialogManager.dart' as _i4;
import 'package:to_do_app_flutter/utils/NotificationService.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.DatabaseHelper>(() => _i3.DatabaseHelper());
    gh.factory<_i4.DialogManager>(() => _i4.DialogManager());
    gh.factory<_i5.HomeViewModel>(() => _i5.HomeViewModel());
    gh.factory<_i6.NotificationService>(() => _i6.NotificationService());
    return this;
  }
}
