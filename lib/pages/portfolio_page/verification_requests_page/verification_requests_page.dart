import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/models/verification_request.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/inbound_verification_requests_list_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/inbound_verification_requests_list_state.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/outbound_verification_requests_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class VerificationRequestsPage extends StatefulWidget {
  final String address;
  final bool isMyWallet;

  const VerificationRequestsPage({
    super.key,
    required this.address,
    required this.isMyWallet,
  });

  @override
  State<StatefulWidget> createState() => _VerificationRequestsPageState();
}

class _VerificationRequestsPageState extends State<VerificationRequestsPage> {
  late final InboundVerificationRequestsListCubit inboundCubit = InboundVerificationRequestsListCubit(
    address: widget.address,
    isMyWallet: widget.isMyWallet,
  );

  late final OutboundVerificationRequestsListCubit outboundCubit = OutboundVerificationRequestsListCubit(
    address: widget.address,
    isMyWallet: widget.isMyWallet,
  );

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        BlocBuilder<InboundVerificationRequestsListCubit, InboundVerificationRequestsListState>(
          bloc: inboundCubit,
          builder: (BuildContext context, InboundVerificationRequestsListState state) {
            return CustomCard(
              title: 'Inbound',
              enableMobile: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTable<VerificationRequest>(
                    items: state.requests,
                    pageSize: state.pageSize,
                    loading: state.isLoading,
                    mobileBuilder: (BuildContext context, VerificationRequest? item, bool loading) {
                      if (item == null || loading) {
                        return const SizedShimmer(width: double.infinity, height: 200);
                      }
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    IdentityAvatar(size: 32, address: item.address),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: OpenableAddressText(
                                        address: item.address,
                                        style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (widget.isMyWallet)
                                IconTextButton(
                                  text: 'Approve',
                                  highlightColor: const Color(0xfffbfbfb),
                                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                                  onTap: () => inboundCubit.approveVerificationRequest(int.parse(item.id)),
                                ),
                              const SizedBox(width: 8),
                              IconTextButton(
                                text: 'Reject',
                                highlightColor: const Color(0xfffbfbfb),
                                style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                                onTap: () => inboundCubit.rejectVerificationRequest(int.parse(item.id)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _MobileRow(
                            title: Text(
                              'Records',
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
                            ),
                            value: Text(
                              item.records.map((e) => e.key).join(', '),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _MobileRow(
                            title: Text(
                              'Edited',
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
                            ),
                            value: Text(
                              DateFormat('d MMM y, HH:mm').format(item.lastRecordEditDate),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _MobileRow(
                            title: Text(
                              'Tip',
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
                            ),
                            value: Text(
                              item.tip.toNetworkDenominationString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                            ),
                          ),
                        ],
                      );
                    },
                    columns: <ColumnConfig<VerificationRequest>>[
                      ColumnConfig(
                        title: 'Requested from',
                        width: 200,
                        cellBuilder: (BuildContext context, VerificationRequest item) {
                          return Row(
                            children: <Widget>[
                              IdentityAvatar(size: 32, address: item.address),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CopyableAddressText(
                                  address: item.address,
                                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
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
                            style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
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
                            style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
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
                            style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                          );
                        },
                      ),
                      if (widget.isMyWallet)
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
                                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                                  onTap: () => inboundCubit.approveVerificationRequest(int.parse(item.id)),
                                ),
                                const SizedBox(width: 16),
                                IconTextButton(
                                  text: 'Reject',
                                  highlightColor: const Color(0xfffbfbfb),
                                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                                  onTap: () => inboundCubit.rejectVerificationRequest(int.parse(item.id)),
                                ),
                              ],
                            );
                          },
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 32),
        BlocBuilder<InboundVerificationRequestsListCubit, InboundVerificationRequestsListState>(
          bloc: inboundCubit,
          builder: (BuildContext context, InboundVerificationRequestsListState state) {
            return CustomCard(
              title: 'Outbound',
              enableMobile: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTable<VerificationRequest>(
                    items: state.requests,
                    pageSize: state.pageSize,
                    loading: state.isLoading,
                    mobileBuilder: (BuildContext context, VerificationRequest? item, bool loading) {
                      if (item == null || loading) {
                        return const SizedShimmer(width: double.infinity, height: 200);
                      }
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    IdentityAvatar(size: 32, address: item.address),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: OpenableAddressText(
                                        address: item.address,
                                        style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (widget.isMyWallet)
                                IconTextButton(
                                  text: 'Cancel',
                                  highlightColor: const Color(0xfffbfbfb),
                                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                                  onTap: () => outboundCubit.cancelVerificationRequest(int.parse(item.id)),
                                ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _MobileRow(
                            title: Text(
                              'Records',
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
                            ),
                            value: Text(
                              item.records.map((e) => e.key).join(', '),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _MobileRow(
                            title: Text(
                              'Edited',
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
                            ),
                            value: Text(
                              DateFormat('d MMM y, HH:mm').format(item.lastRecordEditDate),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _MobileRow(
                            title: Text(
                              'Tip',
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
                            ),
                            value: Text(
                              item.tip.toNetworkDenominationString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                            ),
                          ),
                        ],
                      );
                    },
                    columns: <ColumnConfig<VerificationRequest>>[
                      ColumnConfig(
                        title: 'Requested to',
                        width: 200,
                        cellBuilder: (BuildContext context, VerificationRequest item) {
                          return Row(
                            children: <Widget>[
                              IdentityAvatar(size: 32, address: item.verifier),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CopyableAddressText(
                                  address: item.verifier,
                                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
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
                            style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
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
                            style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
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
                            style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                          );
                        },
                      ),
                      if (widget.isMyWallet)
                        ColumnConfig(
                          title: 'Actions',
                          textAlign: TextAlign.right,
                          cellBuilder: (BuildContext context, VerificationRequest item) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconTextButton(
                                  text: 'Cancel',
                                  highlightColor: const Color(0xfffbfbfb),
                                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                                  onTap: () => outboundCubit.cancelVerificationRequest(int.parse(item.id)),
                                ),
                              ],
                            );
                          },
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MobileRow extends StatelessWidget {
  final Widget title;
  final Widget value;

  const _MobileRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: title,
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: value,
        ),
      ],
    );
  }
}
