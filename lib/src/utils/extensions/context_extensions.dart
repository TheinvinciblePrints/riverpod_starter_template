import 'package:flutter/material.dart';

import '../../themes/themes.dart';

extension DesignSystemContextExtension on BuildContext {
  DesignSystemExtension get ds =>
      Theme.of(this).extension<DesignSystemExtension>()!;
}
