import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:flutter/material.dart';

class CustomDrawerCard extends StatelessWidget {
  const CustomDrawerCard({Key? key,this.onTap,this.labels,this.images}) : super(key: key);
  final Function()? onTap;
final String?images;
final String?labels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: Dimensions.height * 0.05,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).cardColor),
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(Dimensions.RADIUS_SMALL),
                  topRight: Radius.circular(Dimensions.RADIUS_SMALL))),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Image.asset(
                images!,
                color: Theme.of(context).cardColor,
                width: Dimensions.width * 0.06,
              ),
              const SizedBox(width: 10),
              Text(
               labels!,
                style: robotoMedium.copyWith(
                    color: Theme.of(context).cardColor,
                    fontSize: Dimensions.fontSizeDefault),
              )
            ],
          ),
        ),
      ),
    );
  }
}
