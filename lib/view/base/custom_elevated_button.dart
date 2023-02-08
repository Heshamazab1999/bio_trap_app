import 'package:bio_trap/util/dimensions.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({Key? key, this.label, this.onTap, this.image})
      : super(key: key);
  final String? label;
  final Function()? onTap;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.width * 0.45,
      height: Dimensions.height * 0.05,
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Dimensions.RADIUS_SMALL))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label!),
              const SizedBox(width: 5),
              Flexible(
                child: Image.asset(image!,
                    width: Dimensions.width * 0.05,
                    color: Theme.of(context).cardColor),
              ),
            ],
          )),
    );
  }
}
