import 'package:boarding_group/app/common/auth.dart';
import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:boarding_group/app/common/utils.dart';
import 'package:boarding_group/app/modules/home/controllers/home_controller.dart';
import 'package:boarding_group/app/widget/custom_input.dart';
import 'package:boarding_group/app/widget/image/custom_image.dart';
import 'package:boarding_group/app/widget/image/custom_image_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(_controller.notifier).initData(ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 17),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Container(
              width: size.width,
              decoration: BoxDecoration(
                  color: kBlueColor500.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  item('Quản trị viên:', ref.watch(Auth.admin).getName),
                  const SizedBox(height: 5),
                  item('Số điện thoại:', ref.watch(Auth.admin).getPhone),
                  const Divider(color: kBodyText, thickness: 2, height: 30),
                  CustomInput(
                      title: 'Tìm kiếm theo tên',
                      background: kWhiteColor,
                      controller: ref.watch(_controller).inputName,
                      onChanged: (value) => ref
                          .read(_controller.notifier)
                          .handleSearchName(value, ref),
                      err: ''),
                  const SizedBox(height: 13),
                  CustomInput(
                      title: 'Tìm kiếm theo tên phòng',
                      background: kWhiteColor,
                      controller: ref.watch(_controller).inputRoom,
                      onChanged: (value) => ref
                          .read(_controller.notifier)
                          .handleSearchRoom(value, ref),
                      err: '')
                ],
              )),
        ),
        const SizedBox(height: 17),
        Text('Danh sách thành viên', style: PrimaryStyle.normal(20)),
        const SizedBox(height: 17),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => ref
                .read(_controller.notifier)
                .getListMember(ref, isRefresh: true),
            backgroundColor: kIndigoBlueColor900,
            color: kWhiteColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: ref.watch(showListMember),
            ),
          ),
        )
      ],
    );
  }

  Widget item(String title, String content) {
    return Row(
      children: [
        Text(title, style: PrimaryStyle.bold(20, color: kRedColor400)),
        const SizedBox(width: 4),
        Text(content, style: PrimaryStyle.normal(20, color: kRedColor400))
      ],
    );
  }
}

final _controller = ChangeNotifierProvider.autoDispose<HomeController>(
    (ref) => HomeController());

final showListMember = Provider.autoDispose<Widget>((ref) {
  if (ref.watch(_controller).isLoading) {
    return const Center(
      child: CircularProgressIndicator(color: kIndigoBlueColor900),
    );
  } else if (ref.watch(_controller).listMember.isEmpty) {
    return Center(
      child: Text('Không tìm thấy dữ liệu',
          style: PrimaryStyle.bold(20, color: kRedColor400)),
    );
  }
  return ListView.builder(
      shrinkWrap: true,
      itemCount: ref.watch(_controller).listMember.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final listMember = ref.watch(_controller).listMember[index];
        return Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: CustomImage(
                    width: 80,
                    height: 80,
                    url: listMember.getImages,
                    shape: BoxShape.rectangle,
                    errorWidget: CustomImageDefault(
                        sizeText: 40,
                        backgroundColor: kOrangeColor800.withOpacity(0.8),
                        shape: BoxShape.rectangle,
                        content: Utils.getSubStringUserName(
                            listMember.getUserName))),
              ),
              const SizedBox(width: 13),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 7),
                  Text(listMember.getUserName,
                      style: PrimaryStyle.bold(27, color: kIndigoBlueColor900)),
                  Text(listMember.getPhone,
                      style:
                          PrimaryStyle.normal(18, color: kIndigoBlueColor900))
                ],
              ))
            ],
          ),
        );
      });
});
