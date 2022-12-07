import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/modules/password/controllers/change_pass_controller.dart';
import 'package:boarding_group/app/widget/button/primary_button.dart';
import 'package:boarding_group/app/widget/custom_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../common/config.dart';

class ChangePassView extends ConsumerWidget {
  const ChangePassView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomInput(
                title: "Mật khẩu cũ",
                controller: ref.watch(changePassController).inputOldPass,
                err: ref.watch(changePassController).listErr[0]),
            const SizedBox(height: 10),
            CustomInput(
                title: "Mật khẩu mới",
                obscureText: ref.watch(changePassController).isHidePassNew,
                icons: IconButton(
                    icon: Icon(
                        ref.watch(icons(
                            ref.watch(changePassController).isHidePassNew)),
                        color: kPrimaryColor),
                    onPressed: () => ref
                        .read(changePassController.notifier)
                        .handleShowPass(0)),
                controller: ref.watch(changePassController).inputNewPass,
                err: ref.watch(changePassController).listErr[1]),
            const SizedBox(height: 10),
            CustomInput(
                title: "Xác nhận mật khẩu",
                obscureText: ref.watch(changePassController).isHidePassConfirm,
                icons: IconButton(
                    icon: Icon(
                        ref.watch(icons(
                            ref.watch(changePassController).isHidePassConfirm)),
                        color: kPrimaryColor),
                    onPressed: () => ref
                        .read(changePassController.notifier)
                        .handleShowPass(1)),
                controller: ref.watch(changePassController).inputConfirm,
                err: ref.watch(changePassController).listErr[2]),
            const SizedBox(height: 25),
            PrimaryButton(
                height: 50,
                width: double.infinity,
                content: 'Cập nhập',
                sizeContent: 20,
                isLoading: ref.watch(changePassController).isLoading,
                onPressed: () async =>
                    ref.read(changePassController.notifier).handleChangePass())
          ],
        ),
      ),
    );
  }
}

final icons = Provider.autoDispose.family<IconData, bool>((ref, hidePass) {
  if (hidePass) {
    return Icons.visibility_off_outlined;
  }
  return Icons.visibility_outlined;
});
