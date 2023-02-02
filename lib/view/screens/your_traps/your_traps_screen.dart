import 'package:bio_trap/enum/view_state.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:bio_trap/view/screens/trap_details/trap_details_screen.dart';
import 'package:bio_trap/view/screens/your_traps/controller/your_trap_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourTrapScreen extends StatelessWidget {
  const YourTrapScreen({Key? key, this.traps}) : super(key: key);
  final List<TrapModel>? traps;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(YourTrapController());
    return Scaffold(
        backgroundColor: const Color(0xFFF9FEFE),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Dimensions.height * 0.08),
            // here the desired height
            child: AppBar(
              leadingWidth: Dimensions.width * 0.12,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Builder(
                  builder: (context) => GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(Images.arrowIcon,
                        color: Theme.of(context).cardColor),
                  ),
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              centerTitle: true,
              title: Image.asset(Images.logoNewIcon,
                  width: Dimensions.width * 0.3,
                  color: Theme.of(context).cardColor),
            )),
        body: Obx(() => controller.state == ViewState.busy
                ? Center(
                    child: Image.asset(
                      Images.logoAnimation,
                      color: Theme.of(context).primaryColor,
                      width: Dimensions.width * 0.5,
                    ),
                  )
                : ListView.builder(
                    itemCount: traps!.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Material(
                            elevation: 1,
                            shadowColor: Theme.of(context).primaryColor,
                            child: ListTile(
                              onTap: () async {
                                await controller.getTrap(
                                    trapId: traps![index].id);
                                Get.to(() => TrapDetailsScreen(
                                      trap: controller.trap,
                                    ));
                              },
                              leading: Image.asset(Images.trapIcon),
                              title: Text(traps![index].name!,
                                  style: robotoMedium.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: Dimensions.fontSizeLarge)),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ))

            ));
  }
}
