// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:kira_dashboard/pages/block_details_page/block_details_page.dart'
    as _i1;
import 'package:kira_dashboard/pages/block_transactions_page/block_transactions_page.dart'
    as _i2;
import 'package:kira_dashboard/pages/blocks_page/blocks_page.dart' as _i3;
import 'package:kira_dashboard/pages/menu_wrapper_page.dart' as _i4;
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page.dart' as _i5;
import 'package:kira_dashboard/pages/proposals_page/proposals_page.dart' as _i6;
import 'package:kira_dashboard/pages/splash_page/splash_page.dart' as _i7;
import 'package:kira_dashboard/pages/transaction_details_page/transaction_details_page.dart'
    as _i8;
import 'package:kira_dashboard/pages/valdators_page/validators_page.dart'
    as _i9;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    BlockDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<BlockDetailsRouteArgs>(
          orElse: () =>
              BlockDetailsRouteArgs(height: pathParams.getString('height')));
      return _i10.AutoRoutePage<dynamic>(
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
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BlockTransactionsPage(
          blockId: args.blockId,
          key: args.key,
        ),
      );
    },
    BlocksRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BlocksPage(),
      );
    },
    MenuWrapperRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.MenuWrapperPage(),
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
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.PortfolioPage(
          address: args.address,
          key: args.key,
        ),
      );
    },
    ProposalsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ProposalsPage(),
      );
    },
    SplashRoute.name: (routeData) {
      final args = routeData.argsAs<SplashRouteArgs>(
          orElse: () => const SplashRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.SplashPage(
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
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.TransactionDetailsPage(
          hash: args.hash,
          key: args.key,
        ),
      );
    },
    ValidatorsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.ValidatorsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.BlockDetailsPage]
class BlockDetailsRoute extends _i10.PageRouteInfo<BlockDetailsRouteArgs> {
  BlockDetailsRoute({
    _i11.Key? key,
    required String height,
    List<_i10.PageRouteInfo>? children,
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

  static const _i10.PageInfo<BlockDetailsRouteArgs> page =
      _i10.PageInfo<BlockDetailsRouteArgs>(name);
}

class BlockDetailsRouteArgs {
  const BlockDetailsRouteArgs({
    this.key,
    required this.height,
  });

  final _i11.Key? key;

  final String height;

  @override
  String toString() {
    return 'BlockDetailsRouteArgs{key: $key, height: $height}';
  }
}

/// generated route for
/// [_i2.BlockTransactionsPage]
class BlockTransactionsRoute
    extends _i10.PageRouteInfo<BlockTransactionsRouteArgs> {
  BlockTransactionsRoute({
    String? blockId,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
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

  static const _i10.PageInfo<BlockTransactionsRouteArgs> page =
      _i10.PageInfo<BlockTransactionsRouteArgs>(name);
}

class BlockTransactionsRouteArgs {
  const BlockTransactionsRouteArgs({
    this.blockId,
    this.key,
  });

  final String? blockId;

  final _i11.Key? key;

  @override
  String toString() {
    return 'BlockTransactionsRouteArgs{blockId: $blockId, key: $key}';
  }
}

/// generated route for
/// [_i3.BlocksPage]
class BlocksRoute extends _i10.PageRouteInfo<void> {
  const BlocksRoute({List<_i10.PageRouteInfo>? children})
      : super(
          BlocksRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlocksRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.MenuWrapperPage]
class MenuWrapperRoute extends _i10.PageRouteInfo<void> {
  const MenuWrapperRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MenuWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuWrapperRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PortfolioPage]
class PortfolioRoute extends _i10.PageRouteInfo<PortfolioRouteArgs> {
  PortfolioRoute({
    String address = '',
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
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

  static const _i10.PageInfo<PortfolioRouteArgs> page =
      _i10.PageInfo<PortfolioRouteArgs>(name);
}

class PortfolioRouteArgs {
  const PortfolioRouteArgs({
    this.address = '',
    this.key,
  });

  final String address;

  final _i11.Key? key;

  @override
  String toString() {
    return 'PortfolioRouteArgs{address: $address, key: $key}';
  }
}

/// generated route for
/// [_i6.ProposalsPage]
class ProposalsRoute extends _i10.PageRouteInfo<void> {
  const ProposalsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ProposalsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProposalsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SplashPage]
class SplashRoute extends _i10.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    _i11.Key? key,
    _i10.PageRouteInfo<dynamic>? routeInfo,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(
            key: key,
            routeInfo: routeInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i10.PageInfo<SplashRouteArgs> page =
      _i10.PageInfo<SplashRouteArgs>(name);
}

class SplashRouteArgs {
  const SplashRouteArgs({
    this.key,
    this.routeInfo,
  });

  final _i11.Key? key;

  final _i10.PageRouteInfo<dynamic>? routeInfo;

  @override
  String toString() {
    return 'SplashRouteArgs{key: $key, routeInfo: $routeInfo}';
  }
}

/// generated route for
/// [_i8.TransactionDetailsPage]
class TransactionDetailsRoute
    extends _i10.PageRouteInfo<TransactionDetailsRouteArgs> {
  TransactionDetailsRoute({
    required String hash,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
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

  static const _i10.PageInfo<TransactionDetailsRouteArgs> page =
      _i10.PageInfo<TransactionDetailsRouteArgs>(name);
}

class TransactionDetailsRouteArgs {
  const TransactionDetailsRouteArgs({
    required this.hash,
    this.key,
  });

  final String hash;

  final _i11.Key? key;

  @override
  String toString() {
    return 'TransactionDetailsRouteArgs{hash: $hash, key: $key}';
  }
}

/// generated route for
/// [_i9.ValidatorsPage]
class ValidatorsRoute extends _i10.PageRouteInfo<void> {
  const ValidatorsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ValidatorsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ValidatorsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
