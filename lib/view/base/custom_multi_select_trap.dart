import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CustomMultiSelectTrap extends StatelessWidget {
  const CustomMultiSelectTrap(
      {Key? key, this.label, this.list, this.onConfirm, this.icon})
      : super(key: key);
  final String? label;
  final List<dynamic>? list;
  final Function(List<dynamic>)? onConfirm;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MultiSelectDialogField(
          buttonText: Text(
            label!,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: robotoMedium.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: Theme.of(context).primaryColor),
          ),
          buttonIcon: Icon(
            icon!,
            color: Theme.of(context).primaryColor,
          ),
          chipDisplay: MultiSelectChipDisplay(
            scroll: true,
            scrollBar: HorizontalScrollBar(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              border: Border.all(color: Theme.of(context).primaryColor)),
          items: list!.map((e) => MultiSelectItem(e, e.name!)).toList(),
          listType: MultiSelectListType.CHIP,
          onConfirm: onConfirm!),
    );
  }
}
