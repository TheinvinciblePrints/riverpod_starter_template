/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:lottie/lottie.dart' as _lottie;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/bbc.png
  AssetGenImage get bbc => const AssetGenImage('assets/icons/bbc.png');

  /// File path: assets/icons/buzz_feed.png
  AssetGenImage get buzzFeed =>
      const AssetGenImage('assets/icons/buzz_feed.png');

  /// File path: assets/icons/cnbc.png
  AssetGenImage get cnbc => const AssetGenImage('assets/icons/cnbc.png');

  /// File path: assets/icons/cnet.png
  AssetGenImage get cnet => const AssetGenImage('assets/icons/cnet.png');

  /// File path: assets/icons/cnn.png
  AssetGenImage get cnn => const AssetGenImage('assets/icons/cnn.png');

  /// File path: assets/icons/daily_mail.png
  AssetGenImage get dailyMail =>
      const AssetGenImage('assets/icons/daily_mail.png');

  /// File path: assets/icons/facebook_icon.svg
  SvgGenImage get facebookIcon =>
      const SvgGenImage('assets/icons/facebook_icon.svg');

  /// File path: assets/icons/filter_icon.svg
  SvgGenImage get filterIcon =>
      const SvgGenImage('assets/icons/filter_icon.svg');

  /// File path: assets/icons/google_icon.svg
  SvgGenImage get googleIcon =>
      const SvgGenImage('assets/icons/google_icon.svg');

  /// File path: assets/icons/msn.png
  AssetGenImage get msn => const AssetGenImage('assets/icons/msn.png');

  /// File path: assets/icons/scmp.png
  AssetGenImage get scmp => const AssetGenImage('assets/icons/scmp.png');

  /// File path: assets/icons/search_icon.svg
  SvgGenImage get searchIcon =>
      const SvgGenImage('assets/icons/search_icon.svg');

  /// File path: assets/icons/setting_icon.svg
  SvgGenImage get settingIcon =>
      const SvgGenImage('assets/icons/setting_icon.svg');

  /// File path: assets/icons/time.png
  AssetGenImage get time => const AssetGenImage('assets/icons/time.png');

  /// File path: assets/icons/usa_today.png
  AssetGenImage get usaToday =>
      const AssetGenImage('assets/icons/usa_today.png');

  /// File path: assets/icons/vice.png
  AssetGenImage get vice => const AssetGenImage('assets/icons/vice.png');

  /// File path: assets/icons/vox.png
  AssetGenImage get vox => const AssetGenImage('assets/icons/vox.png');

  /// List of all assets
  List<dynamic> get values => [
    bbc,
    buzzFeed,
    cnbc,
    cnet,
    cnn,
    dailyMail,
    facebookIcon,
    filterIcon,
    googleIcon,
    msn,
    scmp,
    searchIcon,
    settingIcon,
    time,
    usaToday,
    vice,
    vox,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_logo.png
  AssetGenImage get appLogo =>
      const AssetGenImage('assets/images/app_logo.png');

  /// File path: assets/images/ic_launcher.png
  AssetGenImage get icLauncher =>
      const AssetGenImage('assets/images/ic_launcher.png');

  /// File path: assets/images/onboarding_image_1.webp
  AssetGenImage get onboardingImage1 =>
      const AssetGenImage('assets/images/onboarding_image_1.webp');

  /// File path: assets/images/onboarding_image_2.webp
  AssetGenImage get onboardingImage2 =>
      const AssetGenImage('assets/images/onboarding_image_2.webp');

  /// File path: assets/images/onboarding_image_3.webp
  AssetGenImage get onboardingImage3 =>
      const AssetGenImage('assets/images/onboarding_image_3.webp');

  /// List of all assets
  List<AssetGenImage> get values => [
    appLogo,
    icLauncher,
    onboardingImage1,
    onboardingImage2,
    onboardingImage3,
  ];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/error_lottie.json
  LottieGenImage get errorLottie =>
      const LottieGenImage('assets/lottie/error_lottie.json');

  /// List of all assets
  List<LottieGenImage> get values => [errorLottie];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// File path: assets/translations/es.json
  String get es => 'assets/translations/es.json';

  /// List of all assets
  List<String> get values => [en, es];
}

class AppAssets {
  const AppAssets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName, {this.flavors = const {}});

  final String _assetName;
  final Set<String> flavors;

  _lottie.LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    _lottie.FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    _lottie.LottieDelegates? delegates,
    _lottie.LottieOptions? options,
    void Function(_lottie.LottieComposition)? onLoaded,
    _lottie.LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, _lottie.LottieComposition?)?
    frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
    _lottie.LottieDecoder? decoder,
    _lottie.RenderCache? renderCache,
    bool? backgroundLoading,
  }) {
    return _lottie.Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
      decoder: decoder,
      renderCache: renderCache,
      backgroundLoading: backgroundLoading,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
