import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/select_token_dialog/select_token_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/select_token_dialog/select_token_dialog_state.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';
import 'package:kira_dashboard/widgets/token_icon.dart';

class SelectTokenDialog extends DialogContentWidget {
  final String address;

  const SelectTokenDialog({super.key, required this.address});

  @override
  State<StatefulWidget> createState() => _SelectTokenDialogState();
}

class _SelectTokenDialogState extends State<SelectTokenDialog> {
  late final SelectTokenDialogCubit cubit = SelectTokenDialogCubit(address: widget.address);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Select token',
      width: 420,
      scrollable: false,
      child: BlocBuilder<SelectTokenDialogCubit, SelectTokenDialogState>(
        bloc: cubit,
        builder: (BuildContext context, SelectTokenDialogState state) {
          return SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: state.balances.length,
              itemBuilder: (BuildContext context, int index) {
                Coin balance = state.balances[index];
                return ListTile(
                  onTap: () => CustomDialogRoute.of(context).pop(balance),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: TokenIcon(size: 40, iconUrl: balance.icon),
                  title: Text(
                    balance.name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xfffbfbfb),
                    ),
                  ),
                  subtitle: Text(
                    balance.toNetworkDenominationString(),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff6c86ad),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
