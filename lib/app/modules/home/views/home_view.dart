import 'package:boarding_group/app/common/auth.dart';
import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:boarding_group/app/common/utils.dart';
import 'package:boarding_group/app/modules/home/controllers/home_controller.dart';
import 'package:boarding_group/app/modules/home/views/components/body/list_member.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          // Card(
          //     margin: EdgeInsets.zero,
          //     elevation: 10,
          //     shape:
          //         const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          //     child: Column(
          //       children: [
          //         const SizedBox(height: 4),
          //         Container(
          //             width: size.width,
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 20, vertical: 20),
          //             child: Column(
          //               children: [
          //                 CustomInput(
          //                     title: 'Tìm kiếm theo tên',
          //                     background: kWhiteColor,
          //                     controller: ref.watch(_controller).inputName,
          //                     onChanged: (value) => ref
          //                         .read(_controller.notifier)
          //                         .handleSearchName(value, ref),
          //                     err: ''),
          //                 const SizedBox(height: 13),
          //                 CustomInput(
          //                     title: 'Tìm kiếm theo tên phòng',
          //                     background: kWhiteColor,
          //                     controller: ref.watch(_controller).inputRoom,
          //                     onChanged: (value) => ref
          //                         .read(_controller.notifier)
          //                         .handleSearchRoom(value, ref),
          //                     err: '')
          //               ],
          //             )),
          //         Text('Danh sách thành viên', style: PrimaryStyle.normal(20)),
          //         const SizedBox(height: 10),
          //       ],
          //     )),
          RefreshIndicator(
            onRefresh: () async => ref
                .read(_controller.notifier)
                .getListMember(ref, isRefresh: true),
            backgroundColor: kIndigoBlueColor900,
            color: kWhiteColor,
            child: ref.watch(showListMember),
          )
        ],
      ),
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
  } else {
    return ListMember(listMember: ref.watch(_controller).listMember);
  }
});
