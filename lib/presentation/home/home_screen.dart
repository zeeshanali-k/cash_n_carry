import 'dart:math';

import 'package:cash_n_carry/presentation/categories_n_products/categories_tab.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/hero_title.dart';
import 'package:cash_n_carry/presentation/home/components/hero_cart_icon.dart';
import 'package:cash_n_carry/presentation/profile/profile_tab.dart';
import 'package:cash_n_carry/utils/constants/app_constants.dart';
import 'package:cash_n_carry/utils/constants/screens.dart';
import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:cash_n_carry/utils/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pos = 0;

  final homeTabs = [const CategoriesTab(), const ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.greyBgDark,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: AppColors.greyBgDark,
          elevation: 0,
          leading: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              CupertinoIcons.circle_grid_3x3,
              size: 30.0,
              color: AppColors.pinkColor,
            ),
          ),
          title: Align(
            alignment: Alignment.center,
            child: HeroTitle(
              tag: "title_tv",
              title: AppConstants.appName,
              textStyle: TextStyles.textExtraLargePinkBold,
            ),
          ),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(ScreenCart().route);
                  },
                  child: const HeroCartIcon()),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: AppColors.backgroundColor,
              activeIcon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: AppColors.backgroundColor,
              activeIcon: Icon(
                Icons.person,
                color: Colors.blue,
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
          type: BottomNavigationBarType.shifting,
          onTap: changePosition,
          currentIndex: pos,
        ),
        body: Stack(
          children: [
            Container(
              color: AppColors.greyBgDark,
              padding: const EdgeInsets.only(top: 5.0),
              child: SafeArea(child: homeTabs[pos]),
            ),
          ],
        ));
  }

  void changePosition(int index) {
    setState(() {
      log(index);
      pos = index;
    });
  }
}
