// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:kira_dashboard/pages/menu_wrapper_page.dart' as _i1;
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page.dart' as _i2;
import 'package:kira_dashboard/pages/valdators_page/validators_page.dart'
    as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    MenuWrapperRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.MenuWrapperPage(),
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
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.PortfolioPage(
          address: args.address,
          key: args.key,
        ),
      );
    },
    ValidatorsRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ValidatorsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.MenuWrapperPage]
class MenuWrapperRoute extends _i4.PageRouteInfo<void> {
  const MenuWrapperRoute({List<_i4.PageRouteInfo>? children})
      : super(
          MenuWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuWrapperRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PortfolioPage]
class PortfolioRoute extends _i4.PageRouteInfo<PortfolioRouteArgs> {
  PortfolioRoute({
    String address = '',
    _i5.Key? key,
    List<_i4.PageRouteInfo>? children,
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

  static const _i4.PageInfo<PortfolioRouteArgs> page =
      _i4.PageInfo<PortfolioRouteArgs>(name);
}

class PortfolioRouteArgs {
  const PortfolioRouteArgs({
    this.address = '',
    this.key,
  });

  final String address;

  final _i5.Key? key;

  @override
  String toString() {
    return 'PortfolioRouteArgs{address: $address, key: $key}';
  }
}

/// generated route for
/// [_i3.ValidatorsPage]
class ValidatorsRoute extends _i4.PageRouteInfo<void> {
  const ValidatorsRoute({List<_i4.PageRouteInfo>? children})
      : super(
          ValidatorsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ValidatorsRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
