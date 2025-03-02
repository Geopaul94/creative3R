import 'package:creative/presentation/widgets/custom_bottom_sheet.dart';
import 'package:creative/presentation/widgets/custom_text.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart'; // Make sure to import this package

class Customappbar extends StatelessWidget {
  final String text;
  const Customappbar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateFormatter = DateFormat('dd MM yyyy');
    final dayFormatter = DateFormat('EEEE');
    final formattedDate = dateFormatter.format(now);
    final formattedDay = dayFormatter.format(now);
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to WhatsApp with the specified phone number
                  final url = 'whatsapp://send?phone=+918589837557&text=Hello';
                  launchUrl(Uri.parse(url));
                },
                child: SvgPicture.asset(
                  "assets/images/icons8-whatsapp (1).svg",
                  width: 30.w,
                  height: 30.w,
                ),
              ),
              h5,
              Text(
                formattedDay,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              h5,
              Text(
                formattedDate,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          Center(
            child: CustomText(
              text: text,
              color: Colors.amber[300] ?? Colors.amber,
              fontSize: 30.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
         
          Stack(
  alignment: Alignment.center,
  children: [
    CircleAvatar(
      backgroundColor: Colors.yellow,
      child: IconButton(
        icon: SvgPicture.asset(
          'assets/images/icons8-notification.svg',
          color: Colors.black,
        ),
        onPressed: () {
          showCustomBottomSheet(context);
        },
      ),
    ),
    Positioned(
      top:-2,
      right: -1,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        constraints: const BoxConstraints(
          minWidth: 16,
          minHeight: 16,
        ),
        child: const Text(
          '1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    )
  ],
)
        ],
      ),
    );
  }
}
