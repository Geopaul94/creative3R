import 'package:creative/presentation/bloc/fetchcommodities/fetchcommodites_bloc.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_bloc.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_event.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_state.dart';
import 'package:creative/presentation/screeens/commodities_screen.dart';
import 'package:creative/presentation/screeens/spotrate_screen.dart';
import 'package:creative/presentation/widgets/CustomeAppbar.dart';
import 'package:creative/presentation/widgets/custom_text.dart';
import 'package:creative/presentation/widgets/customappbar.dart';
import 'package:creative/presentation/widgets/custome_snackbar.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:creative/utilities/constants/url_files/url_files.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';





























// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: black,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Customappbar(
//                 text: 'Home',
//               ),
//               Divider(
//                 thickness: 0.5,
//                 color: grey,
//               ),
//               CustomText(
//                 text: 'Live Market Updates',
//                 color: amber,
//                 fontSize: 20.sp,
//               ),
//               // Make both screens scroll as part of the full screen
//               CommoditiesScreen(), // Let it take its natural height
//               SpotRateScreen(),     // Let it take its natural height
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




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
              
              // First BlocProvider for the first GridView
              CommoditiesScreen(),

              SizedBox(height: 20),

              // Second BlocProvider for another GridView or content
              SpotRateScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class CommoditiesScreen extends StatelessWidget {
  const CommoditiesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchCommoditiesBloc()..add(OnFetchCommoditiesEvent()),
      child: BlocBuilder<FetchCommoditiesBloc, FetchCommoditiesState>(
        builder: (context, state) {
          if (state is FetchCommoditiesLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FetchCommoditiesErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is FetchCommoditiesSuccessState) {
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(), // Disable inner scrolling
              shrinkWrap: true, // Shrink to fit content
              padding: EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 2.2, // Adjusted for shorter height
              ),
              itemCount: state.commodities.length,
              itemBuilder: (context, index) {
                final commodity = state.commodities[index];
                return CommoditiesContainer(commodity: commodity);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class SpotRateScreen extends StatelessWidget {
  const SpotRateScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpotRateBloc()..add(FetchSpotRate()),
      child: BlocBuilder<SpotRateBloc, SpotRateState>(
        builder: (context, state) {
          if (state is SpotRateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SpotRateLoaded) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(), // Disable inner scrolling
              shrinkWrap: true, // Shrink to fit content
              itemCount: state.commodities.length,
              itemBuilder: (context, index) {
                final commodity = state.commodities[index];
                return CommodityContainer(commodity: commodity);
              },
            );
          } else if (state is SpotRateError) {
            final message = state.error;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              customSnackbar(context, message, red);
            });
            return Center(child: Text(message));
          }
    
          return Center(child: Text('Press to load commodities'));
        },
      ),
    );
  }
}
