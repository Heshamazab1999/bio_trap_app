import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:flutter/material.dart';

class CustomGridViewSchedule extends StatelessWidget {
  const CustomGridViewSchedule({Key? key, this.scheduleList}) : super(key: key);
  final List<TrapSchedules>? scheduleList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: scheduleList!.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.7,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4),
      itemBuilder: (_, index) => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.2),
              ),
            ],
            color: scheduleList![index].status!
                ? Theme.of(context).primaryColor
                : Theme.of(context).cardColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(scheduleList![index].scdTime.toString(),
                style: robotoMedium.copyWith(
                    color: scheduleList![index].status!
                        ? Theme.of(context).cardColor
                        : Colors.black,
                    fontSize: Dimensions.fontSizeExtraLarge)),
          )),
    );
  }
}
