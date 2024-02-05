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

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    BlockDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<BlockDetailsRouteArgs>(
          orElse: () =>
              BlockDetailsRouteArgs(height: pathParams.getString('height')));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BlockDetailsPage(
          key: args.key,
          height: args.height,
        ),
      );
    },
    BlockTransactionsRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<BlockTransactionsRouteArgs>(
          orElse: () => BlockTransactionsRouteArgs(
              blockId: queryParams.optString('block')));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BlockTransactionsPage(
          blockId: args.blockId,
          key: args.key,
        ),
      );
    },
    BlocksRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BlocksPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.DashboardPage(),
      );
    },
    MenuWrapperRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MenuWrapperPage(),
      );
    },
    PortfolioRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PortfolioRouteArgs>(
          orElse: () => PortfolioRouteArgs(
                  address: pathParams.getString(
                'address',
                '',
              )));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.PortfolioPage(
          address: args.address,
          key: args.key,
        ),
      );
    },
    ProposalDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProposalDetailsRouteArgs>(
          orElse: () => ProposalDetailsRouteArgs(
              proposalId: pathParams.getString('proposalId')));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.ProposalDetailsPage(
          proposalId: args.proposalId,
          key: args.key,
        ),
      );
    },
    ProposalsRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ProposalsPage(),
      );
    },
    SplashRoute.name: (routeData) {
      final args = routeData.argsAs<SplashRouteArgs>(
          orElse: () => const SplashRouteArgs());
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.SplashPage(
          key: args.key,
          routeInfo: args.routeInfo,
        ),
      );
    },
    TransactionDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<TransactionDetailsRouteArgs>(
          orElse: () =>
              TransactionDetailsRouteArgs(hash: pathParams.getString('hash')));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.TransactionDetailsPage(
          hash: args.hash,
          key: args.key,
        ),
      );
    },
    ValidatorsRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.ValidatorsPage(),
      );
    },
  };
}

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

  static const _i12.PageInfo<BlockDetailsRouteArgs> page =
      _i12.PageInfo<BlockDetailsRouteArgs>(name);
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

  static const _i12.PageInfo<BlockTransactionsRouteArgs> page =
      _i12.PageInfo<BlockTransactionsRouteArgs>(name);
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

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
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

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
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

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
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

  static const _i12.PageInfo<PortfolioRouteArgs> page =
      _i12.PageInfo<PortfolioRouteArgs>(name);
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

  static const _i12.PageInfo<ProposalDetailsRouteArgs> page =
      _i12.PageInfo<ProposalDetailsRouteArgs>(name);
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

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
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

  static const _i12.PageInfo<SplashRouteArgs> page =
      _i12.PageInfo<SplashRouteArgs>(name);
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

  static const _i12.PageInfo<TransactionDetailsRouteArgs> page =
      _i12.PageInfo<TransactionDetailsRouteArgs>(name);
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

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}
