import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../utils/constant/constant.dart';
import '../../../../../utils/widgets/textfields/input_primary.dart';

class EditUsernameDialog extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController surNameController;
  final Function() onSave;
  const EditUsernameDialog({
    super.key,
    required this.firstNameController,
    required this.surNameController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: GColors.background,
      title: Text('Edit Username',
          style: Nove.regular.copyWith(fontSize: 20, color: GColors.primary)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InputPrimary(
            controller: firstNameController,
            label: 'First Name',
            textStyle: Poppins.regular.copyWith(fontSize: 14),
            labelTextStyle: Poppins.semiBold.copyWith(fontSize: 16),
          ),
          Gap(10),
          InputPrimary(
            controller: surNameController,
            label: 'Surname',
            textStyle: Poppins.regular.copyWith(fontSize: 14),
            labelTextStyle: Poppins.semiBold.copyWith(fontSize: 16),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel',
              style:
                  Poppins.bold.copyWith(fontSize: 14, color: GColors.primary)),
        ),
        TextButton(
          onPressed: () => onSave(),
          child: Text('Save',
              style:
                  Poppins.bold.copyWith(fontSize: 14, color: GColors.primary)),
        ),
      ],
    );
  }
}
