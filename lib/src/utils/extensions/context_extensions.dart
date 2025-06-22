import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../localization/locale_keys.g.dart';
import '../../themes/themes.dart';

extension DesignSystemContextExtension on BuildContext {
  DesignSystemExtension get ds =>
      Theme.of(this).extension<DesignSystemExtension>()!;
}

extension AppTextThemeX on BuildContext {
  AppTextThemeExtension get textTheme =>
      Theme.of(this).extension<AppTextThemeExtension>()!;

  AppColorThemeExtension get colorTheme =>
      Theme.of(this).extension<AppColorThemeExtension>()!;
}

/// Extension providing direct access to LocaleKeys through context
/// Usage: context.l.error instead of context.tr(LocaleKeys.error)
extension LocaleKeysExtension on BuildContext {
  /// Direct access to LocaleKeys with automatic translation
  /// Example usage: context.l.error
   get l => _LocaleKeys(this);
}

/// Simple class to provide direct access to translations through LocaleKeys
class _LocaleKeys {
  final BuildContext _context;

  const _LocaleKeys(this._context);

  // Common translations
  String get error => _context.tr(LocaleKeys.error);
  String get retry => _context.tr(LocaleKeys.retry);
  String get noInternetConnection =>
      _context.tr(LocaleKeys.noInternetConnection);
  String get noInternetConnectionTitle =>
      _context.tr(LocaleKeys.noInternetConnectionTitle);
  String get defaultError => _context.tr(LocaleKeys.defaultError);

  // Auth translations
  String get login => _context.tr(LocaleKeys.auth_login);
  String get hello => _context.tr(LocaleKeys.auth_hello);
  String get again => _context.tr(LocaleKeys.auth_again);
  String get username => _context.tr(LocaleKeys.auth_username);
  String get password => _context.tr(LocaleKeys.auth_password);
  String get forgotPassword => _context.tr(LocaleKeys.auth_forgotPassword);
  String get dontHaveAnAccount =>
      _context.tr(LocaleKeys.auth_dontHaveAnAccount);
  String get signUp => _context.tr(LocaleKeys.auth_signUp);
  String get continueWith => _context.tr(LocaleKeys.auth_continueWith);
  String get facebook => _context.tr(LocaleKeys.auth_facebook);
  String get google => _context.tr(LocaleKeys.auth_google);
  String get welcomeBack => _context.tr(LocaleKeys.auth_welcomeBack);
  String get invalideUsername => _context.tr(LocaleKeys.auth_invalideUsername);
  String get pleaseEnterValidUsername =>
      _context.tr(LocaleKeys.auth_pleaseEnterValidUsername);
  String get invalidPassword => _context.tr(LocaleKeys.auth_invalidPassword);

  // Onboarding translations
  String get getStarted => _context.tr(LocaleKeys.onboarding_getStarted);
  String get next => _context.tr(LocaleKeys.onboarding_next);
  String get back => _context.tr(LocaleKeys.onboarding_back);
  String get pageOneTitle => _context.tr(LocaleKeys.onboarding_pageOneTitle);
  String get pageOneSubTitle =>
      _context.tr(LocaleKeys.onboarding_pageOneSubTitle);
  String get pageTwoTitle => _context.tr(LocaleKeys.onboarding_pageTwoTitle);
  String get pageTwoSubTitle =>
      _context.tr(LocaleKeys.onboarding_pageTwoSubTitle);
  String get pageThreeTitle =>
      _context.tr(LocaleKeys.onboarding_pageThreeTitle);
  String get pageThreeSubTitle =>
      _context.tr(LocaleKeys.onboarding_pageThreeSubTitle);
}
