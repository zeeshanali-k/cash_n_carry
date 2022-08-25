import 'package:carousel_slider/carousel_slider.dart';
import 'package:cash_n_carry/domain/models/category.dart';
import 'package:cash_n_carry/utils/constants/app_constants.dart';
import 'package:cash_n_carry/utils/constants/screens.dart';
import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:cash_n_carry/utils/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/category_item.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({Key? key}) : super(key: key);

  @override
  _CategoriesTabState createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  late List<Category> categoriesList;

  @override
  void initState() {
    categoriesList = AppConstants.getCategoriesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.greyBgDark,
      //TODO try SingleChildScroll...
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            /*CarouselSlider(
              options: CarouselOptions(
                height: size.height * 0.18,
                // aspectRatio: 16 / 9,
                viewportFraction: 0.80,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 200),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                // onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
              ),
              items: [1, 2, 3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                        width: size.width,
                        child: Card(
                          elevation: 3.0,
                          color: AppColors.backgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: GestureDetector(
                            onTap: () {
                              launchUrl();
                            },
                            child: Image.asset(
                              "assets/images/logo.png",
                              width: size.width,
                              height: size.height * 0.18,
                            ),
                          ),
                        ));
                  },
                );
              }).toList(),
            ),*/
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.0),
                child: Text(
                  "Categories",
                  style: TextStyles.textLargeBlackBold,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, pos) => CategoryItem(
                  category: categoriesList[pos],
                  onItemClicked: (categoryClicked) {
                    Navigator.of(context).pushNamed(
                      ScreenCategoryProducts().route,
                      arguments: categoryClicked,
                    );
                  },
                ),
                itemCount: categoriesList.length,
                physics: const BouncingScrollPhysics(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void launchUrl() async {
    const url = "https://facebook.com";
    // if (await canLaunch(url)) {
    await launch(url);
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Failed to launch")));
    // }
  }
}
