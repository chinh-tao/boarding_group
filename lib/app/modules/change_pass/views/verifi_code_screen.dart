import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:boarding_group/app/model/user_model.dart';
import 'package:boarding_group/app/modules/change_pass/controllers/change_pass_controller.dart';
import 'package:boarding_group/app/widget/button/button_loading.dart';
import 'package:boarding_group/app/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerifiCodeScreen extends StatelessWidget {
  const VerifiCodeScreen({Key? key, required this.userModel, this.change})
      : super(key: key);

  final UserModel userModel;
  final String? change;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePassController>(builder: (_) {
      _.user.value = userModel;
      return SizedBox(
        width: Get.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomInput(
                title: '',
                controller: _.inputVerifiCode,
                maxLength: 6,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                hintText: 'Mã xác thực',
                err: ''),
            const SizedBox(height: 5),
            Align(
                alignment: Alignment.centerLeft,
                child: Obx(() {
                  if (_.loadingSendCode.value) {
                    return Row(
                      children: [
                        Text('vui lòng chờ giây lát...',
                            style: PrimaryStyle.medium(16)),
                        const SizedBox(width: 5),
                        const SizedBox(
                          height: 12,
                          width: 12,
                          child: CircularProgressIndicator(
                              color: kBlueColor500, strokeWidth: 2),
                        )
                      ],
                    );
                  }
                  return InkWell(
                    onTap: () async => await _.handleSendVerifiCode(),
                    child: Text(
                      'nhận mã xác thực',
                      style: PrimaryStyle.medium(16, color: kBlueColor500),
                    ),
                  );
                })),
            const SizedBox(height: 35),
            if (_.stringError.value.isNotEmpty) ...[
              Text(_.stringError.value,
                  style: PrimaryStyle.normal(16, color: kRedColor400))
            ],
            const SizedBox(height: 5),
            Obx(() => ButtonLoading(
                height: 50,
                width: 170,
                sizeContent: 16,
                colors: kIndigoBlueColor900,
                isLoading: _.loadingSubmit.value,
                titleButton: 'XÁC NHẬN',
                onPressed: () => _.submitVerifiCode(change: change)))
          ],
        ),
      );
    });
  }
}
