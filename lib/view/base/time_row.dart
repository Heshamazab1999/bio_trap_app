import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:flutter/material.dart';

class CustomTimeRow extends StatelessWidget {
  const CustomTimeRow({Key? key, this.label, this.onTap}) : super(key: key);
  final String? label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            label!,
            style: robotoMedium.copyWith(
                fontSize: Dimensions.fontSizeLarge,
                color: Theme.of(context).primaryColor),
          ),
        ),
        ElevatedButton(
            onPressed: onTap,
            child: Row(
              children: [
                Image.asset(Images.timeName,
                    width: 15, color: Theme.of(context).cardColor),
                const SizedBox(
                  width: 5,
                ),
                const Text("Pick Time"),
              ],
            )),
      ],
    );
  }
}
