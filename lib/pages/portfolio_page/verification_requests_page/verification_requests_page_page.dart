import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/models/verification_request.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/register_identity_records_dialog/register_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';

class VerificationRequestsPage extends StatelessWidget {
  final PortfolioPageState state;

  const VerificationRequestsPage({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCard(
          title: 'Inbound',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTable<VerificationRequest>(
                items: state.inboundVerificationRequests,
                columns: <ColumnConfig<VerificationRequest>>[
                  ColumnConfig(
                    title: 'Requested from',
                    cellBuilder: (BuildContext context, VerificationRequest item) {
                      return Row(
                        children: <Widget>[
                          IdentityAvatar(size: 32, address: item.address),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OpenableAddressText(
                              address: item.address,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xff2f8af5),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Edited',
                    cellBuilder: (BuildContext context, VerificationRequest item) {
                      return Text(
                        DateFormat('d MMM y, HH:mm').format(item.lastRecordEditDate),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Records',
                    cellBuilder: (BuildContext context, VerificationRequest item) {
                      return Text(
                        item.records.map((e) => e.key).join(', '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Tip',
                    textAlign: TextAlign.right,
                    cellBuilder: (BuildContext context, VerificationRequest item) {
                      return Text(
                        item.tip.toNetworkDenominationString(),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                      );
                    },
                  ),
                  if(state.isMyWallet)
                  ColumnConfig(
                    title: 'Actions',
                    textAlign: TextAlign.right,
                    cellBuilder: (BuildContext context, VerificationRequest item) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconTextButton(
                            text: 'Approve',
                            highlightColor: const Color(0xfffbfbfb),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff4888f0),
                            ),
                            onTap: () => DialogRouter().navigate(const RegisterIdentityRecordsDialog()),
                          ),
                          const SizedBox(width: 16),
                          IconTextButton(
                            text: 'Reject',
                            highlightColor: const Color(0xfffbfbfb),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff4888f0),
                            ),
                            onTap: () => DialogRouter().navigate(const RegisterIdentityRecordsDialog()),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        CustomCard(
          title: 'Outbound',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTable<VerificationRequest>(
                items: state.outboundVerificationRequests,
                columns: <ColumnConfig<VerificationRequest>>[
                  ColumnConfig(
                    title: 'Requested to',
                    cellBuilder: (BuildContext context, VerificationRequest item) {
                      return Row(
                        children: <Widget>[
                          IdentityAvatar(size: 32, address: item.verifier),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OpenableAddressText(
                              address: item.verifier,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xff2f8af5),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Edited',
                    cellBuilder: (BuildContext context, VerificationRequest item) {
                      return Text(
                        DateFormat('d MMM y, HH:mm').format(item.lastRecordEditDate),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Records',
                    cellBuilder: (BuildContext context, VerificationRequest item) {
                      return Text(
                        item.records.map((e) => e.key).join(', '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Tip',
                    textAlign: TextAlign.right,
                    cellBuilder: (BuildContext context, VerificationRequest item) {
                      return Text(
                        item.tip.toNetworkDenominationString(),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Actions',
                    textAlign: TextAlign.right,
                    cellBuilder: (BuildContext context, VerificationRequest item) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.info_outline, size: 20, color: Color(0xff2f8af5)),
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
