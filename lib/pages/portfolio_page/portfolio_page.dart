import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/pages/portfolio_page/balances_page/balances_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/delegations_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_content.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';
import 'package:kira_dashboard/pages/portfolio_page/transactions_page/transactions_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/validator_info_page/validator_info_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/verification_requests_page.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_tab_bar.dart';
import 'package:kira_dashboard/widgets/mouse_state_listener.dart';
import 'package:kira_dashboard/widgets/openable_text.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';
import 'package:kira_dashboard/widgets/sliver_tab_bar_view.dart';
import 'package:kira_dashboard/widgets/user_type_chip.dart';
import 'package:url_recognizer/url_recognizer.dart';

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
            child: CircularProgressIndicator(
              color: Color(0xff2f8af5),
              strokeWidth: 2,
            ),
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
