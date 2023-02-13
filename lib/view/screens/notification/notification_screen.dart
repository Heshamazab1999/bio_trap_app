import 'package:bio_trap/model/body/notification_model.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key, this.notifications}) : super(key: key);
  final List<NotificationModel>? notifications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.height * 0.1),
          child: AppBar(
            leadingWidth: Dimensions.width * 0.12,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.back(
                    closeOverlays: true,
                  );
                },
                child: Image.asset(Images.arrowIcon,
                    color: Theme.of(context).cardColor),
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            centerTitle: true,
            title: Image.asset(Images.logoNewIcon,
                width: Dimensions.width * 0.3,
                color: Theme.of(context).cardColor),
          )),
      body: notifications!.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Images.noAlarmIcon,
                      width: Dimensions.width * 0.2,
                      color: Theme.of(context).primaryColor),
                  Text(
                    AppConstants.noFoundNotifications,
                    style: robotoMedium.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeLarge),
                  )
                ],
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: notifications!.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_DEFAULT)),
                      elevation: 2,
                      shadowColor: Theme.of(context).primaryColor,
                      child: ListTile(
                        leading: Image.asset(Images.alarmIcon,
                            width: Dimensions.PADDING_SIZE_OVER_LARGE),
                        title: Text(notifications![index].trapName!),
                        subtitle: Text(
                            "This trap is far away ${notifications![index].changedDistance?.round()}"),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                notifications![index]
                                    .dateTime!
                                    .split("/")
                                    .first,
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                )),
                            Text(
                                notifications![index].dateTime!.split("/").last,
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                )),
                          ],
                        ),
                      ),
                    ),
                  )),
    );
  }
}
