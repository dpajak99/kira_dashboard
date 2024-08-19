import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_content.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';

@RoutePage()
class PortfolioPage extends StatefulWidget {
  final String address;

  const PortfolioPage({
    @PathParam('address') this.address = '',
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  late final PortfolioPageCubit cubit = PortfolioPageCubit(address: widget.address);

  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioPageCubit, PortfolioPageState>(
      bloc: cubit,
      builder: (BuildContext context, PortfolioPageState state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: CustomColors.primary, strokeWidth: 2),
          );
        }
        return PortfolioPageContent(
          isMyWallet: state.isMyWallet,
          address: widget.address,
          isValidator: state.validator != null,
          isFavourite: state.isFavourite,
          onAddFavourite: cubit.addFavourite,
          onRemoveFavourite: cubit.removeFavourite,
          identityRecords: state.identityRecords,
          validator: state.validator,
        );
      },
    );
  }
}
