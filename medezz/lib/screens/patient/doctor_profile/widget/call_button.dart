import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medezz/api/patient/doctors/fetchdoctors.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../../constants/colors.dart';
import '../../book_appointment/pages/book_appointment.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key, required this.doctor});

  final Doctors doctor;

  @override
  Widget build(BuildContext context) {
    Widget sendCallButton({
      required bool isVideoCall,
      void Function(String code, String message, List<String>)? onCallFinished,
      required String callId,
      required String message,
    }) {
      if (callId.isNotEmpty) {
        List<ZegoUIKitUser> singleInvitee = [];
        singleInvitee.add(
          ZegoUIKitUser(
            id: doctor.id,
            name: doctor.name,
          ),
        );

        log("Trying to call Doctor:");
        log("Advocate Phone: ${doctor.id}");
        log("Advocate Name: ${doctor.name}");

        try {
          return ZegoSendCallInvitationButton(
            callID: callId,
            isVideoCall: isVideoCall,
            invitees: singleInvitee,
            // resourceID: 'zego_call_2',
            resourceID: 'medezzCall',
            iconSize: const Size(40, 40),
            buttonSize: const Size(50, 50),
            onPressed: onCallFinished,
          );
        } catch (e) {
          log("Error: $e");
          log(message);
          return Center(child: Text(message));
        }
      } else {
        return const Center(child: Text('Call Id is empty. Call not possible'));
      }
    }

    void onSendCallInvitationFinished(
      String code,
      String message,
      List<String> errorInvitees,
    ) {
      if (errorInvitees.isNotEmpty) {
        String userIDs = "";
        for (int index = 0; index < errorInvitees.length; index++) {
          if (index >= 5) {
            userIDs += '... ';
            break;
          }

          var userID = errorInvitees.elementAt(index);
          userIDs += '$userID ';
        }
        if (userIDs.isNotEmpty) {
          userIDs = userIDs.substring(0, userIDs.length - 1);
        }

        var message = 'User doesn\'t exist or is offline: $userIDs';
        if (code.isNotEmpty) {
          message += ', code: $code, message:$message';
        }
        showToast(
          context: context,
          message,
          position: StyledToastPosition.top,
        );
      } else if (code.isNotEmpty) {
        showToast(
          context: context,
          'code: $code, message:$message',
          position: StyledToastPosition.top,
        );
      }
    }

    void createCallDialogue({
      required String callId,
      required String errMsg,
      required String callType,
    }) {
      showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 500),
        context: context,
        pageBuilder: (ctx, anim1, anim2) => AlertDialog(
          actions: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.white, width: 3),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(35),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () async {},
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.white, width: 3),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(35),
                          ),
                        ),
                        child: Center(
                          child: sendCallButton(
                            callId: callId,
                            message: errMsg,
                            isVideoCall: false,
                            onCallFinished: onSendCallInvitationFinished,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
          backgroundColor: Colors.black,
        ),
      );
    }

    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: CustomColors.primaryColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            onPressed: () {
              String callType = "Audio";

              createCallDialogue(
                callId: "1234",
                errMsg: "Something Went Wrong",
                callType: callType,
              );
            },
            icon: const Icon(
              Icons.call,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Container(
          decoration: BoxDecoration(
            color: CustomColors.primaryColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => BookAppointmentPage(doctorId: doctor.id))));
            },
            icon: const Icon(
              Iconsax.calendar,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
