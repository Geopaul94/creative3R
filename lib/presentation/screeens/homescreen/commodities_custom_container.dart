
import 'package:creative/presentation/bloc/fetchcommodities/fetchcommodites_bloc.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CommoditiesContainer extends StatelessWidget {
  const CommoditiesContainer({
    super.key,
    required this.commodity,
  });

  final String commodity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Card(
        color: const Color.fromARGB(182, 31, 30, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: Colors.yellow.shade600,
            width: 1.2,
          ),
        ),
        elevation: 4,
        shadowColor: Colors.yellow.withOpacity(0.3),
        child: Column(
          mainAxisSize: MainAxisSize.min, // This ensures the column takes only the space it needs
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [h5,
    Row(
              children: [       w20, 
                Text(
                  commodity,
                  style: TextStyle(
                    color: Colors.amber.shade600,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          h10,
       Row(
              children: [    w20, 
                Text(
                  "2858.58 USD", // Example of another text (you can replace it with dynamic data)
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          
          ],
        ),
      ),
    );
  }
}
