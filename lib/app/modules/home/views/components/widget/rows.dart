import 'package:boarding_group/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class Rows extends StatelessWidget {
  const Rows({Key? key, required this.controller, required this.position})
      : super(key: key);

  final HomeController controller;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            controller.listData[position].length,
            (index) => GestureDetector(
                  onTap: () => controller.showData(position, index),
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    margin: const EdgeInsets.all(3),
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: controller.listColor[position][index],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: Text(controller.listData[position][index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                )));
  }
}
