import 'package:cash_n_carry/domain/models/category.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/category_hero_image.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/hero_title.dart';
import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:cash_n_carry/utils/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatefulWidget {
  final Category category;
  final Function(Category) onItemClicked;

  const CategoryItem(
      {Key? key, required this.category, required this.onItemClicked})
      : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  final imgWidthHeight = 80;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.all(5.0),
      duration: const Duration(milliseconds: 500),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              SizedBox(
                height: imgWidthHeight / 2,
              ),
              SizedBox(
                width: imgWidthHeight + (imgWidthHeight * 0.7),
                child: Card(
                  elevation: 3.0,
                  shadowColor: AppColors.pinkColor.withAlpha(120),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      widget.onItemClicked(widget.category);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: imgWidthHeight / 2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          HeroTitle(title: widget.category.name),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${widget.category.itemsCount} Items",
                            style: TextStyles.textSmallGreyNormal,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          CategoryHeroImage(
            imgWidthHeight: imgWidthHeight,
            categoryIcon: widget.category.icon,
          ),
        ],
      ),
    );
  }
}
