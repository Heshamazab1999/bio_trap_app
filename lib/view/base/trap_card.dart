import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:flutter/material.dart';

class TrapCard extends StatelessWidget {
  const TrapCard({Key? key, this.name, this.onTap}) : super(key: key);
  final String? name;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shadowColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            side: BorderSide(color: Theme.of(context).primaryColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: Dimensions.width * 0.3,
              height: Dimensions.height * 0.12,
              decoration: BoxDecoration(
                  color: const Color(0xFFF9FEFE),
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  border: Border.all(color: Theme.of(context).primaryColor)),
              child: Center(
                child: SizedBox(
                  height: Dimensions.width * 0.15,
                  width: Dimensions.width * 0.15,
                  child: Image.asset(Images.trapIcon),
                ),
              ),
            ),
            Text(name!,
                style: robotoMedium.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: Dimensions.fontSizeLarge,
                )),
          ],
        ),
      ),
    );
  }
}
