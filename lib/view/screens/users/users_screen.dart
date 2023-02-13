import 'package:bio_trap/enum/view_state.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:bio_trap/util/utility.dart';
import 'package:bio_trap/view/base/custom_multi_select_trap.dart';
import 'package:bio_trap/view/base/fixed_text_field.dart';
import 'package:bio_trap/view/screens/users/controller/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_constants.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UsersController());
    return Scaffold(
        backgroundColor: const Color(0xFFF9FEFE),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Dimensions.height * 0.1),
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
              actions: [
                GestureDetector(
                  onTap: () {
                    Utility.displayUpdateAlert(
                        context,
                        Column(
                          children: [
                            Obx(() => FixedTextField(
                                  controller:
                                      controller.textEditingControllerEmailUser,
                                  errorLabel: controller.emailUser.error,
                                  function: (name) {
                                    controller.changeEmailUser(name);
                                  },
                                  autoFocus: true,
                                  label: AppConstants.email,
                                )),
                            SizedBox(height: Dimensions.height * 0.02),
                            Obx(() => FixedTextField(
                                  controller:
                                      controller.textEditingControllerUserName,
                                  errorLabel: controller.userName.error,
                                  function: (name) {
                                    controller.changeNameUser(name);
                                  },
                                  autoFocus: true,
                                  label: AppConstants.userName,
                                )),
                            SizedBox(height: Dimensions.height * 0.02),
                            Obx(() => FixedTextField(
                                  controller:
                                      controller.textEditingControllerPassword,
                                  errorLabel: controller.password.error,
                                  function: (name) {
                                    controller.changePasswordUser(name);
                                  },
                                  autoFocus: true,
                                  label: AppConstants.password,
                                )),
                            SizedBox(height: Dimensions.height * 0.02),
                            CustomMultiSelectTrap(
                              label: AppConstants.traps,
                              list: controller.traps,
                              onConfirm: (values) {
                                for (var element in values) {
                                  print(element.id);
                                  controller.trapIds.add(element.id);
                                }
                                print(controller.trapIds.length);
                              },
                              icon: Icons.grid_view_rounded,
                            ),
                          ],
                        ), onConfirm: () {
                      controller.addUser(context);
                      Get.back();
                    });
                  },
                  child: Image.asset(Images.moreIcon,
                      width: 25, color: Theme.of(context).cardColor),
                ),
                const SizedBox(width: 20),
              ],
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
            : controller.users.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.emptyIcon,
                          width: Dimensions.width * 0.3,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          AppConstants.noFoundUsers,
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.users.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Material(
                          elevation: 2,
                          shadowColor: Theme.of(context).primaryColor,
                          child: ListTile(
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Utility.displayUpdateAlert(
                                        context,
                                        Column(
                                          children: [
                                            Obx(() => FixedTextField(
                                                  hint: controller
                                                      .users[index].name,
                                                  controller: controller
                                                      .textEditingControllerName,
                                                  errorLabel:
                                                      controller.name.error,
                                                  function: (name) {
                                                    controller.changeName(name);
                                                  },
                                                  autoFocus: true,
                                                  label: AppConstants.name,
                                                )),
                                            const SizedBox(height: 10),
                                            Obx(() => FixedTextField(
                                                  hint: controller
                                                      .users[index].email,
                                                  controller: controller
                                                      .textEditingControllerEmail,
                                                  errorLabel:
                                                      controller.email.error,
                                                  function: (email) {
                                                    controller
                                                        .changeUserEmail(email);
                                                  },
                                                  autoFocus: true,
                                                  label:  AppConstants.email,
                                                )),
                                            const SizedBox(height: 10),
                                            CustomMultiSelectTrap(
                                              label:  AppConstants.traps,
                                              list: controller.traps,
                                              onConfirm: (values) {
                                                for (var element in values) {
                                                  print(element.id);
                                                  controller.trapIds
                                                      .add(element.id);
                                                }
                                                print(
                                                    controller.trapIds.length);
                                              },
                                              icon: Icons.grid_view_rounded,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height * 0.05,
                                              width: Dimensions.width,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemCount: controller
                                                      .users[index]
                                                      .trapIds!
                                                      .length,
                                                  itemBuilder: (_, indexUser) {
                                                    controller.trapIds.add(
                                                        controller.users[index]
                                                                .trapIds![
                                                            indexUser]);
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      child: Chip(
                                                        label: Text(controller
                                                            .users[index]
                                                            .trapIds![indexUser]
                                                            .toString()),
                                                        elevation: 2,
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.4),
                                                        shadowColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .RADIUS_SMALL)),
                                                      ),
                                                    );
                                                  }),
                                            )
                                          ],
                                        ),
                                        loading: controller.loading,
                                        onConfirm: () {
                                      controller.updateUser(context,
                                          id: controller.users[index].id);
                                      Get.back();
                                    });
                                  },
                                  child: Image.asset(Images.userEditIcon,
                                      width: Dimensions.width * 0.06,
                                      color: Theme.of(context).primaryColor),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Utility.displayUpdateAlert(
                                        context,
                                        Column(
                                          children: [
                                            Obx(() => FixedTextField(
                                                  controller: controller
                                                      .textEditingControllerOldPassword,
                                                  errorLabel: controller
                                                      .oldPassword.error,
                                                  function: (oldPassword) {
                                                    controller
                                                        .changeOldPassword(
                                                            oldPassword);
                                                  },
                                                  label:  AppConstants.oldPassword,
                                                )),
                                            const SizedBox(height: 10),
                                            Obx(() => FixedTextField(
                                                  errorLabel: controller
                                                      .newPassword.error,
                                                  controller: controller
                                                      .textEditingControllerNewPassword,
                                                  function: (newPassword) {
                                                    controller
                                                        .changeNewPassword(
                                                            newPassword);
                                                  },
                                                  label: AppConstants.newPassword,
                                                )),
                                            const SizedBox(height: 10),
                                            Obx(() => FixedTextField(
                                                  controller: controller
                                                      .textEditingControllerConfirmPassword,
                                                  errorLabel: controller
                                                      .confirmPassword.error,
                                                  function: (confirmPassword) {
                                                    controller
                                                        .changeConfirmPassword(
                                                            confirmPassword);
                                                  },
                                                  label: AppConstants.confirmPassword,
                                                )),
                                          ],
                                        ), onConfirm: () {
                                      controller.changePassword(
                                          userId: controller.users[index].id);
                                    });
                                  },
                                  child: Image.asset(Images.passwordIcon,
                                      width: Dimensions.width * 0.06,
                                      color: Theme.of(context).primaryColor),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.deleteUser(context,
                                        userId: controller.users[index].id);
                                  },
                                  child: Image.asset(
                                    Images.deleteIcon,
                                    width: 20,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                )
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_SMALL),
                            ),
                            onTap: () {},
                            title: Text(controller.users[index].name!,
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Dimensions.fontSizeDefault)),
                            subtitle: Text(controller.users[index].email!,
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Dimensions.fontSizeDefault)),
                            leading: Image.asset(Images.user,
                                color: Theme.of(context).primaryColor,
                                width: Dimensions.width * 0.12),
                          ),
                        ),
                      );
                    })));
  }
}
