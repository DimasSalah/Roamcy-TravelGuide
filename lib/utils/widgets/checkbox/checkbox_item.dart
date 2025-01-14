import 'package:flutter/material.dart';

import '../../constant/constant.dart';

class CheckboxItem extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool?> onChanged;
  const CheckboxItem(
      {super.key,
      required this.text,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: GColors.primary,
          checkColor: GColors.white,
          visualDensity: VisualDensity.compact,
          value: value,
          onChanged: onChanged,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        Expanded(
          child: Text(text,
              style:
                  Poppins.regular.copyWith(color: GColors.black, fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 2),
        ),
      ],
    );
  }
}
