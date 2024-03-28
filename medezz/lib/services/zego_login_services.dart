// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medezz/constants/zego_constants.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

ZegoUIKitPrebuiltCallController? callController;

/// on user login
void onUserLogin({
  required String myUserId,
  required String myUserName,
  required BuildContext context,
}) {
  callController ??= ZegoUIKitPrebuiltCallController();

  /// 4/5. initialized ZegoUIKitPrebuiltCallInvitationService when account is logged in or re-logged in
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: ZegoConstants.appId /*input your AppID*/,
    appSign: ZegoConstants.appSign /*input your AppSign*/,
    userID: myUserId,
    userName: myUserName,
    plugins: [ZegoUIKitSignalingPlugin()],
    notifyWhenAppRunningInBackgroundOrQuit: true,
    androidNotificationConfig: ZegoAndroidNotificationConfig(
      channelID: "ZegoUIKit",
      channelName: "Call Notifications",
      sound: "notification",
      icon: "notification_icon",
    ),
    iOSNotificationConfig: ZegoIOSNotificationConfig(
      isSandboxEnvironment: false,
      systemCallingIconName: 'CallKitIcon',
    ),
    controller: callController,
    requireConfig: (ZegoCallInvitationData data) {
      var config = (data.invitees.length > 1)
          ? ZegoCallType.videoCall == data.type
              ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
              : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
          : ZegoCallType.videoCall == data.type
              ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
              : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

      /// support minimizing, show minimizing button
      config.topMenuBarConfig.isVisible = true;
      config.topMenuBarConfig.buttons.insert(
        0,
        ZegoMenuBarButtonName.minimizingButton,
      );

      // hangup the call after certain durtion
      config.durationConfig.isVisible = true;
      config.durationConfig.onDurationUpdate = (Duration duration) {
        if (duration.inSeconds >= 59) {
          ZegoUIKitPrebuiltCallController().hangUp(context);
        }
      };

      config.onError = (ZegoUIKitError error) {
        log('Zego Error:$error');
      };

      return config;
    },
  );
}

/// on user logout
void onUserLogout() {
  callController = null;

  ZegoUIKitPrebuiltCallInvitationService().uninit();
}
