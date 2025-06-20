import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter_template/src/utils/extensions/context_extensions.dart';

class TextFieldTitleText extends StatelessWidget {
  const TextFieldTitleText({
    super.key,
    required this.title,
    this.isRequired = false,
  });
  final String title;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Text.rich(
        TextSpan(
          text: context.tr(title),
          style: context.textTheme.textSmall,
          children: [
            if (isRequired ?? false)
              TextSpan(text: ' *', style: context.textTheme.errorText),
          ],
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        textAlign: TextAlign.start,
      ),
    );
  }
}
