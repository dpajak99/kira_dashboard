import 'package:auto_route/auto_route.dart';
import 'package:bech32/bech32.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/dry_intrinsic_width.dart';
import 'package:kira_dashboard/widgets/mouse_state_listener.dart';

class MenuSearchbar extends StatefulWidget {
  const MenuSearchbar({super.key});

  @override
  State<StatefulWidget> createState() => MenuSearchbarState();
}

class MenuSearchbarState extends State<MenuSearchbar> {
  final TextEditingController controller = TextEditingController();
  final JustTheController popupController = JustTheController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 350,
      height: 40,
      child: JustTheTooltip(
        isModal: true,
        triggerMode: TooltipTriggerMode.manual,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        tailLength: 8,
        controller: popupController,
        content: _buildPopup(),
        child: Container(
          width: 350,
          decoration: const BoxDecoration(
            color: Color(0xff151923),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Color(0xff47546d),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 240,
                child: DryIntrinsicWidth(
                  child: TextField(
                    controller: controller,
                    maxLines: 1,
                    style: textTheme.bodyMedium!.copyWith(
                      color: appColors.onBackground,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Search for address or transaction hash',
                      hintStyle: textTheme.bodyMedium!.copyWith(
                        color: const Color(0xff47546d),
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: _validate,
                    onSubmitted: (_) => popupController.showTooltip(),
                    onEditingComplete: () => popupController.showTooltip(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ValueListenableBuilder(
                valueListenable: controller,
                builder: (BuildContext context, TextEditingValue value, Widget? child) {
                  if (value.text.isEmpty) {
                    return const SizedBox(width: 38);
                  }
                  return SizedBox(
                    width: 38,
                    child: MouseStateListener(
                      onTap: () {
                        controller.clear();
                        popupController.hideTooltip();
                      },
                      childBuilder: (Set<MaterialState> states) {
                        return Icon(
                          Icons.close,
                          size: 16,
                          color: states.contains(MaterialState.hovered) ? appColors.secondary : const Color(0xff47546d),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopup() {
    String value = controller.text;
    bool validAddress = isAddress(value);
    bool validTxHash = isTxHash(value);

    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: const Color(0xff253246),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (validAddress)
            ListTile(
              onTap: () {
                AutoRouter.of(context).navigate(PortfolioRoute(address: value));
                controller.clear();
                popupController.hideTooltip();
              },
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(
                'Address',
                style: textTheme.bodySmall!.copyWith(color: appColors.secondary),
              ),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IdentityAvatar(
                    address: value,
                    size: 32,
                  ),
                ],
              ),
              subtitle: Text(
                value,
                maxLines: 1,
                style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
              ),
            )
          else if (validTxHash)
            ListTile(
              onTap: () {
                AutoRouter.of(context).navigate(TransactionDetailsRoute(hash: value));
                controller.clear();
                popupController.hideTooltip();
              },
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(
                'Transaction',
                style: textTheme.bodySmall!.copyWith(color: appColors.secondary),
              ),
              subtitle: Text(
                value,
                maxLines: 1,
                style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Text(
                'Invalid address or transaction hash',
              ),
            ),
        ],
      ),
    );
  }

  void _validate(String value) {
    if (value.isEmpty) {
      popupController.hideTooltip();
      return;
    }
    bool validAddress = isAddress(value);
    bool validTxHash = isTxHash(value);

    if (validAddress || validTxHash) {
      popupController.showTooltip();
    }
    setState(() {});
  }

  bool isAddress(String value) {
    try {
      bech32.decode(value);
      return true;
    } catch (_) {
      return false;
    }
  }

  bool isTxHash(String value) {
    String tmpHash = value;
    if (tmpHash.startsWith('0x')) {
      tmpHash = tmpHash.substring(2);
    }

    try {
      hex.decode(tmpHash);
      return tmpHash.length == 64;
    } catch (e) {
      return false;
    }
  }
}
