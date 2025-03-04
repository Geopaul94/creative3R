import 'package:creative/presentation/bloc/fetchcommodities/fetchcommodites_bloc.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_bloc.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_event.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_state.dart';
import 'package:creative/presentation/screeens/homescreen/commodities_screen.dart';
import 'package:creative/presentation/screeens/homescreen/spotrate_screen.dart';
import 'package:creative/presentation/widgets/CustomeAppbar.dart';
import 'package:creative/presentation/widgets/custom_text.dart';
import 'package:creative/presentation/widgets/customappbar.dart';
import 'package:creative/presentation/widgets/custome_snackbar.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:creative/utilities/constants/url_files/url_files.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Custom App Bar
              Customappbar(text: 'Home'),
              Divider(thickness: 0.5, color: grey),

              // Title
              CustomText(
                text: 'Live Market Updates',
                color: amber,
                fontSize: 20.sp,
              ),

           
              CommoditiesScreen(),

              SizedBox(height: 20),

             
              SpotRateScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

