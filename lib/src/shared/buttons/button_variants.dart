import 'package:flutter/material.dart';

import 'base_button.dart';

// Example icon for demonstration
const Widget _plusIcon = Icon(Icons.add, size: 20);
const Widget _dropdownIcon = Icon(Icons.arrow_drop_down, size: 20);

// Primary Icon Right
class PrimaryIconRightButton extends BaseButton {
  const PrimaryIconRightButton({
    required super.label,
    required super.onPressed,
    super.key,
  });
  @override
  Widget buildButton(BuildContext context) => ElevatedButton(
    onPressed: onPressed,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Text(label), const SizedBox(width: 8), _plusIcon],
    ),
  );
}

// Secondary Icon Right
class SecondaryIconRightButton extends BaseButton {
  const SecondaryIconRightButton({
    required super.label,
    required super.onPressed,
    super.key,
  });
  @override
  Widget buildButton(BuildContext context) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[300],
      foregroundColor: Colors.black,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Text(label), const SizedBox(width: 8), _plusIcon],
    ),
  );
}

// Outline Icon Right
class OutlineIconRightButton extends BaseButton {
  const OutlineIconRightButton({
    required super.label,
    required super.onPressed,
    super.key,
  });
  @override
  Widget buildButton(BuildContext context) => OutlinedButton(
    onPressed: onPressed,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Text(label), const SizedBox(width: 8), _plusIcon],
    ),
  );
}

// Primary Icon Left
class PrimaryIconLeftButton extends BaseButton {
  const PrimaryIconLeftButton({
    required super.label,
    required super.onPressed,
    super.key,
  });
  @override
  Widget buildButton(BuildContext context) => ElevatedButton.icon(
    onPressed: onPressed,
    icon: _plusIcon,
    label: Text(label),
  );
}

// Secondary Icon Left
class SecondaryIconLeftButton extends BaseButton {
  const SecondaryIconLeftButton({
    required super.label,
    required super.onPressed,
    super.key,
  });
  @override
  Widget buildButton(BuildContext context) => ElevatedButton.icon(
    onPressed: onPressed,
    icon: _plusIcon,
    label: Text(label),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[300],
      foregroundColor: Colors.black,
    ),
  );
}

// Outline Icon Left
class OutlineIconLeftButton extends BaseButton {
  const OutlineIconLeftButton({
    required super.label,
    required super.onPressed,
    super.key,
  });
  @override
  Widget buildButton(BuildContext context) => OutlinedButton.icon(
    onPressed: onPressed,
    icon: _plusIcon,
    label: Text(label),
  );
}

// Primary Icon Left+Right
class PrimaryIconLeftRightButton extends BaseButton {
  const PrimaryIconLeftRightButton({
    required super.label,
    required super.onPressed,
    super.key,
  });
  @override
  Widget buildButton(BuildContext context) => ElevatedButton(
    onPressed: onPressed,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _plusIcon,
        const SizedBox(width: 8),
        Text(label),
        const SizedBox(width: 8),
        _dropdownIcon,
      ],
    ),
  );
}

// Secondary Icon Left+Right
class SecondaryIconLeftRightButton extends BaseButton {
  const SecondaryIconLeftRightButton({
    required super.label,
    required super.onPressed,
    super.key,
  });
  @override
  Widget buildButton(BuildContext context) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[300],
      foregroundColor: Colors.black,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _plusIcon,
        const SizedBox(width: 8),
        Text(label),
        const SizedBox(width: 8),
        _dropdownIcon,
      ],
    ),
  );
}

// Outline Icon Left+Right
class OutlineIconLeftRightButton extends BaseButton {
  const OutlineIconLeftRightButton({
    required super.label,
    required super.onPressed,
    super.key,
  });
  @override
  Widget buildButton(BuildContext context) => OutlinedButton(
    onPressed: onPressed,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _plusIcon,
        const SizedBox(width: 8),
        Text(label),
        const SizedBox(width: 8),
        _dropdownIcon,
      ],
    ),
  );
}
