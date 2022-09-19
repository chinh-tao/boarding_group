import 'package:boarding_group/app/modules/home/controllers/home_controller.dart';
import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/rows.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return CrossScroll(
        horizontalBar: const CrossScrollBar(thickness: 0),
        verticalBar: const CrossScrollBar(thickness: 0),
        horizontalScroll:
            CrossScrollDesign(physics: const ClampingScrollPhysics()),
        verticalScroll:
            CrossScrollDesign(physics: const ClampingScrollPhysics()),
        child: Container(
          width: 920,
          color: const Color(0xffffcfd8dc),
          child: Column(
            children: [
              const SizedBox(height: 13),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _.listData.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return SizedBox(
                        child: Rows(controller: _, position: index));
                  }),
              const SizedBox(height: 13),
            ],
          ),
        ),
      );
    });
  }
}
