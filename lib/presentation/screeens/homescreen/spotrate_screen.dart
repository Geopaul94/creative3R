import 'package:creative/data/models/spotratemodel/spotreate_model.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_bloc.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_event.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_state.dart';
import 'package:creative/presentation/screeens/homescreen/spotrate_cusotm_container.dart';
import 'package:creative/presentation/widgets/custome_snackbar.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';




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
              physics:
                  NeverScrollableScrollPhysics(), // Disable inner scrolling
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
