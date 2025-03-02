import 'package:creative/presentation/screeens/authentication/login_screen.dart';
import 'package:creative/presentation/widgets/CustomElevatedButton.dart';
import 'package:creative/presentation/widgets/custom_text.dart';
import 'package:creative/presentation/widgets/customappbar.dart';
import 'package:creative/presentation/widgets/custome_snackbar.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          border: Border.all(
            color: Colors.grey[700]!,
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                  text: 'Get Notified',
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              const SizedBox(height: 16),
              Text(
                '''Set a price at which you'd like to buy gold , and we will send you reminder! ''',
                style: TextStyle(color: grey,fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  // Add your onTap functionality here if needed
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(12), // Corrected borderRadius
                    color: Colors.amber,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 10), // Add padding if needed
                  child: Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/icons8-notification.svg',
                          height: 40.h,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          showCustomBottomSheet(context);
                        },
                      ),
                      w30,
                      Center(
                        child: CustomElevatedButton(
                    width:200.w,      height: 40.h,
                          color: Colors.amber, // Simplified color declaration
                         
                          fontSize: 14.sp,
                          text: 'Notify me',
                          onPressed: () {
                            Navigator.pop(context);
                            customSnackbar(context, 'Success', green);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
