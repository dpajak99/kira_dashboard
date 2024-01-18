// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/cupertino.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:kira_dashboard/pages/block_transactions_page/block_transactions_page.dart'
    as _i1;
import 'package:kira_dashboard/pages/blocks_page/blocks_page.dart' as _i2;
import 'package:kira_dashboard/pages/menu_wrapper_page.dart' as _i3;
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page.dart' as _i4;
import 'package:kira_dashboard/pages/proposals_page/proposals_page.dart' as _i5;
import 'package:kira_dashboard/pages/valdators_page/validators_page.dart'
    as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    BlockTransactionsRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<BlockTransactionsRouteArgs>(
          orElse: () => BlockTransactionsRouteArgs(
              blockId: queryParams.optString('block')));
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BlockTransactionsPage(
          blockId: args.blockId,
          key: args.key,
        ),
      );
    },
    BlocksRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BlocksPage(),
      );
    },
    MenuWrapperRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.MenuWrapperPage(),
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
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.PortfolioPage(
          address: args.address,
          key: args.key,
        ),
      );
    },
    ProposalsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ProposalsPage(),
      );
    },
    ValidatorsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ValidatorsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.BlockTransactionsPage]
class BlockTransactionsRoute
    extends _i7.PageRouteInfo<BlockTransactionsRouteArgs> {
  BlockTransactionsRoute({
    String? blockId,
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
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

  static const _i7.PageInfo<BlockTransactionsRouteArgs> page =
      _i7.PageInfo<BlockTransactionsRouteArgs>(name);
}

class BlockTransactionsRouteArgs {
  const BlockTransactionsRouteArgs({
    this.blockId,
    this.key,
  });

  final String? blockId;

  final _i8.Key? key;

  @override
  String toString() {
    return 'BlockTransactionsRouteArgs{blockId: $blockId, key: $key}';
  }
}

/// generated route for
/// [_i2.BlocksPage]
class BlocksRoute extends _i7.PageRouteInfo<void> {
  const BlocksRoute({List<_i7.PageRouteInfo>? children})
      : super(
          BlocksRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlocksRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.MenuWrapperPage]
class MenuWrapperRoute extends _i7.PageRouteInfo<void> {
  const MenuWrapperRoute({List<_i7.PageRouteInfo>? children})
      : super(
          MenuWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuWrapperRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PortfolioPage]
class PortfolioRoute extends _i7.PageRouteInfo<PortfolioRouteArgs> {
  PortfolioRoute({
    String address = '',
    _i9.Key? key,
    List<_i7.PageRouteInfo>? children,
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

  static const _i7.PageInfo<PortfolioRouteArgs> page =
      _i7.PageInfo<PortfolioRouteArgs>(name);
}

class PortfolioRouteArgs {
  const PortfolioRouteArgs({
    this.address = '',
    this.key,
  });

  final String address;

  final _i9.Key? key;

  @override
  String toString() {
    return 'PortfolioRouteArgs{address: $address, key: $key}';
  }
}

/// generated route for
/// [_i5.ProposalsPage]
class ProposalsRoute extends _i7.PageRouteInfo<void> {
  const ProposalsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ProposalsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProposalsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ValidatorsPage]
class ValidatorsRoute extends _i7.PageRouteInfo<void> {
  const ValidatorsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ValidatorsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ValidatorsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
