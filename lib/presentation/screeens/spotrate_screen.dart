import 'package:creative/data/models/spotratemodel/spotreate_model.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_bloc.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_event.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_state.dart';
import 'package:creative/presentation/widgets/custome_snackbar.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CommodityContainer extends StatelessWidget {
  final Commodity commodity;

  const CommodityContainer({super.key, required this.commodity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber[700]!, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                //  Icon(Icons.monetization_on, color: Colors.amber[300], size: 28),
                const SizedBox(width: 12),
                Text(
                  commodity.metal,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[300],
                    letterSpacing: 0.8,
                  ),
                ),
                const Spacer(),
                _buildPurityBadge(),
              ],
            ),
            const SizedBox(height: 16),

            // Details Grid
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem(
                  icon: Icons.scale,
                  title: 'Weight',
                  value: commodity.weight,
                ),
                Lottie.asset(
                  'assets/animation/candle.json',
                  width: 100.w,
                ),
                _buildDetailItem(
                  icon: Icons.format_list_numbered,
                  title: 'Units',
                  value: '${commodity.unit}',
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Buy/Sell Section
            Row(
              children: [
                Expanded(
                  child: _buildTradeColumn(
                    type: 'Buy',
                    premium: commodity.buyPremium,
                    charge: commodity.buyCharge,
                    color: Colors.green,
                  ),
                ),
                const VerticalDivider(color: Colors.amber),
                Expanded(
                  child: _buildTradeColumn(
                    type: 'Sell',
                    premium: commodity.sellPremium,
                    charge: commodity.sellCharge,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.amber[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${commodity.purity}K',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildDetailItem(
      {required IconData icon, required String title, required String value}) {
    return Column(
      children: [
        Icon(icon, color: Colors.amber[200], size: 22),
        const SizedBox(height: 4),
        Text(title,
            style: TextStyle(
              color: Colors.amber[100],
              fontSize: 14,
            )),
        Text(value,
            style: TextStyle(
              color: Colors.amber[300],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Widget _buildTradeColumn(
      {required String type,
      required double premium,
      required double charge,
      required Color color}) {
    return Column(
      children: [
        Text(type.toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            )),
        const SizedBox(height: 8),
        Text('${premium.toStringAsFixed(2)}%',
            style: TextStyle(
              color: Colors.amber[300],
              fontSize: 20,
              fontWeight: FontWeight.w800,
            )),
        const SizedBox(height: 4),
        Text('\$${charge.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.amber[100],
              fontSize: 16,
            )),
      ],
    );
  }
}
