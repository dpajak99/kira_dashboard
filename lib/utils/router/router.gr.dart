// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:kira_dashboard/pages/block_details_page/block_details_page.dart'
    as _i1;
import 'package:kira_dashboard/pages/block_transactions_page/block_transactions_page.dart'
    as _i2;
import 'package:kira_dashboard/pages/blocks_page/blocks_page.dart' as _i3;
import 'package:kira_dashboard/pages/dashboard_page/dashboard_page.dart' as _i4;
import 'package:kira_dashboard/pages/menu_wrapper_page.dart' as _i5;
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page.dart' as _i6;
import 'package:kira_dashboard/pages/proposal_details_page/proposal_details_page.dart'
    as _i7;
import 'package:kira_dashboard/pages/proposals_page/proposals_page.dart' as _i8;
import 'package:kira_dashboard/pages/splash_page/splash_page.dart' as _i9;
import 'package:kira_dashboard/pages/transaction_details_page/transaction_details_page.dart'
    as _i10;
import 'package:kira_dashboard/pages/valdators_page/validators_page.dart'
    as _i11;

/// generated route for
/// [_i1.BlockDetailsPage]
class BlockDetailsRoute extends _i12.PageRouteInfo<BlockDetailsRouteArgs> {
  BlockDetailsRoute({
    _i13.Key? key,
    required String height,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          BlockDetailsRoute.name,
          args: BlockDetailsRouteArgs(
            key: key,
            height: height,
          ),
          rawPathParams: {'height': height},
          initialChildren: children,
        );

  static const String name = 'BlockDetailsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<BlockDetailsRouteArgs>(
          orElse: () =>
              BlockDetailsRouteArgs(height: pathParams.getString('height')));
      return _i1.BlockDetailsPage(
        key: args.key,
        height: args.height,
      );
    },
  );
}

class BlockDetailsRouteArgs {
  const BlockDetailsRouteArgs({
    this.key,
    required this.height,
  });

  final _i13.Key? key;

  final String height;

  @override
  String toString() {
    return 'BlockDetailsRouteArgs{key: $key, height: $height}';
  }
}

/// generated route for
/// [_i2.BlockTransactionsPage]
class BlockTransactionsRoute
    extends _i12.PageRouteInfo<BlockTransactionsRouteArgs> {
  BlockTransactionsRoute({
    String? blockId,
    _i13.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          BlockTransactionsRoute.name,
          args: BlockTransactionsRouteArgs(
            blockId: blockId,
            key: key,
          ),
          rawQueryParams: {'block': blockId},
          initialChildren: children,
        );

  static const String name = 'BlockTransactionsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<BlockTransactionsRouteArgs>(
          orElse: () => BlockTransactionsRouteArgs(
              blockId: queryParams.optString('block')));
      return _i2.BlockTransactionsPage(
        blockId: args.blockId,
        key: args.key,
      );
    },
  );
}

class BlockTransactionsRouteArgs {
  const BlockTransactionsRouteArgs({
    this.blockId,
    this.key,
  });

  final String? blockId;

  final _i13.Key? key;

  @override
  String toString() {
    return 'BlockTransactionsRouteArgs{blockId: $blockId, key: $key}';
  }
}

/// generated route for
/// [_i3.BlocksPage]
class BlocksRoute extends _i12.PageRouteInfo<void> {
  const BlocksRoute({List<_i12.PageRouteInfo>? children})
      : super(
          BlocksRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlocksRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.BlocksPage();
    },
  );
}

/// generated route for
/// [_i4.DashboardPage]
class DashboardRoute extends _i12.PageRouteInfo<void> {
  const DashboardRoute({List<_i12.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.DashboardPage();
    },
  );
}

/// generated route for
/// [_i5.MenuWrapperPage]
class MenuWrapperRoute extends _i12.PageRouteInfo<void> {
  const MenuWrapperRoute({List<_i12.PageRouteInfo>? children})
      : super(
          MenuWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuWrapperRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.MenuWrapperPage();
    },
  );
}

/// generated route for
/// [_i6.PortfolioPage]
class PortfolioRoute extends _i12.PageRouteInfo<PortfolioRouteArgs> {
  PortfolioRoute({
    String address = '',
    _i13.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          PortfolioRoute.name,
          args: PortfolioRouteArgs(
            address: address,
            key: key,
          ),
          rawPathParams: {'address': address},
          initialChildren: children,
        );

  static const String name = 'PortfolioRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<PortfolioRouteArgs>(
          orElse: () => PortfolioRouteArgs(
                  address: pathParams.getString(
                'address',
                '',
              )));
      return _i6.PortfolioPage(
        address: args.address,
        key: args.key,
      );
    },
  );
}

class PortfolioRouteArgs {
  const PortfolioRouteArgs({
    this.address = '',
    this.key,
  });

  final String address;

  final _i13.Key? key;

  @override
  String toString() {
    return 'PortfolioRouteArgs{address: $address, key: $key}';
  }
}

/// generated route for
/// [_i7.ProposalDetailsPage]
class ProposalDetailsRoute
    extends _i12.PageRouteInfo<ProposalDetailsRouteArgs> {
  ProposalDetailsRoute({
    required String proposalId,
    _i13.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ProposalDetailsRoute.name,
          args: ProposalDetailsRouteArgs(
            proposalId: proposalId,
            key: key,
          ),
          rawPathParams: {'proposalId': proposalId},
          initialChildren: children,
        );

  static const String name = 'ProposalDetailsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ProposalDetailsRouteArgs>(
          orElse: () => ProposalDetailsRouteArgs(
              proposalId: pathParams.getString('proposalId')));
      return _i7.ProposalDetailsPage(
        proposalId: args.proposalId,
        key: args.key,
      );
    },
  );
}

class ProposalDetailsRouteArgs {
  const ProposalDetailsRouteArgs({
    required this.proposalId,
    this.key,
  });

  final String proposalId;

  final _i13.Key? key;

  @override
  String toString() {
    return 'ProposalDetailsRouteArgs{proposalId: $proposalId, key: $key}';
  }
}

/// generated route for
/// [_i8.ProposalsPage]
class ProposalsRoute extends _i12.PageRouteInfo<void> {
  const ProposalsRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ProposalsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProposalsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.ProposalsPage();
    },
  );
}

/// generated route for
/// [_i9.SplashPage]
class SplashRoute extends _i12.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    _i13.Key? key,
    _i12.PageRouteInfo<dynamic>? routeInfo,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(
            key: key,
            routeInfo: routeInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SplashRouteArgs>(orElse: () => const SplashRouteArgs());
      return _i9.SplashPage(
        key: args.key,
        routeInfo: args.routeInfo,
      );
    },
  );
}

class SplashRouteArgs {
  const SplashRouteArgs({
    this.key,
    this.routeInfo,
  });

  final _i13.Key? key;

  final _i12.PageRouteInfo<dynamic>? routeInfo;

  @override
  String toString() {
    return 'SplashRouteArgs{key: $key, routeInfo: $routeInfo}';
  }
}

/// generated route for
/// [_i10.TransactionDetailsPage]
class TransactionDetailsRoute
    extends _i12.PageRouteInfo<TransactionDetailsRouteArgs> {
  TransactionDetailsRoute({
    required String hash,
    _i13.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          TransactionDetailsRoute.name,
          args: TransactionDetailsRouteArgs(
            hash: hash,
            key: key,
          ),
          rawPathParams: {'hash': hash},
          initialChildren: children,
        );

  static const String name = 'TransactionDetailsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TransactionDetailsRouteArgs>(
          orElse: () =>
              TransactionDetailsRouteArgs(hash: pathParams.getString('hash')));
      return _i10.TransactionDetailsPage(
        hash: args.hash,
        key: args.key,
      );
    },
  );
}

class TransactionDetailsRouteArgs {
  const TransactionDetailsRouteArgs({
    required this.hash,
    this.key,
  });

  final String hash;

  final _i13.Key? key;

  @override
  String toString() {
    return 'TransactionDetailsRouteArgs{hash: $hash, key: $key}';
  }
}

/// generated route for
/// [_i11.ValidatorsPage]
class ValidatorsRoute extends _i12.PageRouteInfo<void> {
  const ValidatorsRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ValidatorsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ValidatorsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.ValidatorsPage();
    },
  );
}
