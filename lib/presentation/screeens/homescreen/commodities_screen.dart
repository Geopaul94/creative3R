import 'package:creative/presentation/bloc/fetchcommodities/fetchcommodites_bloc.dart';
import 'package:creative/presentation/screeens/homescreen/commodities_custom_container.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';








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
              physics:
                  NeverScrollableScrollPhysics(), // Disable inner scrolling
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









