import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_app_clone_coding/common/style/color.dart';
import 'package:music_app_clone_coding/common/style/icon.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          MyIconFamily.homeLogo,
          fit: BoxFit.contain,
          height: 30,
          color: Colors.white,
        ),
        Row(
          children: [
            SizedBox(
              width: 75,
              height: 30,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff180007),
                ),
                child: const Text(
                  "멤버십 구독",
                  style: TextStyle(
                    fontSize: 10,
                    color: MyColorFamily.main,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            const Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}
