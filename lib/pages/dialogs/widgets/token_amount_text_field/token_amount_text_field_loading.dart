import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field_layout.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class TokenAmountTextFieldLoading extends StatelessWidget {
  const TokenAmountTextFieldLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const TokenAmountTextFieldLayout(
      balanceWidget: SizedShimmer(width: 30, height: 13),
      tokenWidget: Padding(
        padding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
        child: SizedShimmer(width: 100, height: 35),
      ),
      amountWidget: SizedShimmer(width: 120, height: 35),
    );
  }
}


