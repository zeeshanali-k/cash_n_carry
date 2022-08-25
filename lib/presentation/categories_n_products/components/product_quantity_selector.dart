import 'package:cash_n_carry/presentation/categories_n_products/components/small_round_button.dart';
import 'package:cash_n_carry/utils/theme/text_styles.dart';
import 'package:flutter/material.dart';

class ProductQuantitySelector extends StatefulWidget {
  final Function(int) onQuantitySelected;
  int? defaultQuantity = 1;

  ProductQuantitySelector({
    Key? key,
    required this.onQuantitySelected,
    this.defaultQuantity,
  }) : super(key: key);

  @override
  _ProductQuantitySelectorState createState() =>
      _ProductQuantitySelectorState();
}

class _ProductQuantitySelectorState extends State<ProductQuantitySelector> {
  int quantity = 1;

  @override
  void initState() {
    quantity = widget.defaultQuantity??1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          const Text(
            "Quantity",
            style: TextStyles.textLargeBlackBold,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SmallRoundButton(
                  text: "-",
                  onClicked: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity -= 1;
                        widget.onQuantitySelected(quantity);
                      });
                    }
                  }),
              const SizedBox(
                width: 15,
              ),
              Text(
                quantity.toString(),
                style: TextStyles.textMediumBlackBold,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                width: 15,
              ),
              SmallRoundButton(
                  text: "+",
                  onClicked: () {
                    setState(() {
                      quantity += 1;
                      widget.onQuantitySelected(quantity);
                    });
                  }),
            ],
          )
        ],
      ),
    );
  }
}
