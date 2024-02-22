import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

typedef CellBuilder<T> = Widget Function(BuildContext context, T item);

class ColumnConfig<T> {
  final int flex;
  final double? width;
  final EdgeInsets? padding;
  final String title;
  final TextAlign textAlign;
  final CellBuilder<T> cellBuilder;

  const ColumnConfig({
    required this.title,
    required this.cellBuilder,
    this.flex = 1,
    this.width,
    this.padding,
    this.textAlign = TextAlign.left,
  });
}

typedef ElementBuilder<T> = Widget Function(BuildContext context, T? item, bool loading);

class CustomTable<T> extends StatelessWidget {
  final ValueChanged<T>? onItemTap;
  final int pageSize;
  final bool loading;
  final List<T> items;
  final List<ColumnConfig<T>> columns;
  final ElementBuilder<T>? mobileBuilder;

  const CustomTable({
    this.onItemTap,
    super.key,
    required this.items,
    required this.columns,
    required this.mobileBuilder,
    this.pageSize = 10,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 900) {
      return _MobileTable(
        onItemTap: onItemTap,
        items: items,
        columns: columns,
        mobileBuilder: mobileBuilder,
        pageSize: loading ? 3 : pageSize,
        loading: loading,
      );
    } else {
      return _DesktopTable<T>(
        onItemTap: onItemTap,
        items: items,
        columns: columns,
        pageSize: pageSize,
        loading: loading,
      );
    }
  }
}

class _MobileTable<T> extends StatelessWidget {
  final ValueChanged<T>? onItemTap;
  final int pageSize;
  final bool loading;
  final List<T> items;
  final List<ColumnConfig<T>> columns;
  final ElementBuilder<T>? mobileBuilder;

  const _MobileTable({
    this.onItemTap,
    super.key,
    required this.items,
    required this.columns,
    required this.mobileBuilder,
    this.pageSize = 10,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        if (loading == false && items.isEmpty)
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 0.7,
                  child: Image.asset(
                    'empty_placeholder_2.png',
                    width: 150,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Nothing here',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium!.copyWith(color: appColors.secondary),
                ),
              ],
            ),
          )
        else ...<Widget>[
          for (int y = 0; (y < (loading ? 4 : items.length)); y++)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomCard(
                child: mobileBuilder!(context, items.elementAtOrNull(y), loading),
              ),
            ),
        ],
      ],
    );
  }
}

class _DesktopTable<T> extends StatelessWidget {
  final ValueChanged<T>? onItemTap;
  final int pageSize;
  final bool loading;
  final List<T> items;
  final List<ColumnConfig<T>> columns;

  const _DesktopTable({
    this.onItemTap,
    super.key,
    required this.items,
    required this.columns,
    this.pageSize = 10,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        if (loading == false && items.isEmpty)
          SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 0.7,
                  child: Image.asset(
                    'empty_placeholder_2.png',
                    width: 150,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Nothing here',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium!.copyWith(color: appColors.secondary),
                ),
              ],
            ),
          )
        else ...<Widget>[
          Container(
            padding: onItemTap != null ? const EdgeInsets.symmetric(horizontal: 24) : EdgeInsets.zero,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: appColors.outline, width: 1),
              ),
            ),
            child: Row(
              children: <Widget>[
                for (int i = 0; i < columns.length; i++)
                  if (columns[i].width != null)
                    SizedBox(
                      width: columns[i].width,
                      child: _TableCellHeader(
                        columns[i].title,
                        padding: columns[i].padding,
                        first: i == 0,
                        last: i == columns.length - 1,
                        textAlign: columns[i].textAlign,
                      ),
                    )
                  else
                    Expanded(
                      flex: columns[i].flex,
                      child: _TableCellHeader(
                        columns[i].title,
                        padding: columns[i].padding,
                        first: i == 0,
                        last: i == columns.length - 1,
                        textAlign: columns[i].textAlign,
                      ),
                    ),
              ],
            ),
          ),
          for (int y = 0; (y < (loading ? pageSize : items.length)); y++)
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashFactory: InkRipple.splashFactory,
                overlayColor: onItemTap != null ? MaterialStateProperty.all(const Color(0x296c86ad)) : null,
                splashColor: onItemTap != null ? const Color(0x294888f0) : null,
                onTap: onItemTap != null ? () => onItemTap?.call(items[y]) : null,
                child: Padding(
                  padding: onItemTap != null ? const EdgeInsets.symmetric(horizontal: 24) : EdgeInsets.zero,
                  child: Row(
                    children: <Widget>[
                      for (int x = 0; x < columns.length; x++)
                        if (columns[x].width != null)
                          SizedBox(
                            width: columns[x].width,
                            child: _TableCell(
                              loading
                                  ? Align(
                                      alignment: columns[x].textAlign == TextAlign.right ? Alignment.centerRight : Alignment.centerLeft,
                                      child: SizedShimmer(
                                        height: 18,
                                        width: 200,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    )
                                  : columns[x].cellBuilder(context, items[y]),
                              first: x == 0,
                              last: x == columns.length - 1,
                              textAlign: columns[x].textAlign,
                            ),
                          )
                        else
                          Expanded(
                            flex: columns[x].flex,
                            child: _TableCell(
                              loading
                                  ? Align(
                                      alignment: columns[x].textAlign == TextAlign.right ? Alignment.centerRight : Alignment.centerLeft,
                                      child: SizedShimmer(
                                        height: 18,
                                        width: 200,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    )
                                  : columns[x].cellBuilder(context, items[y]),
                              first: x == 0,
                              last: x == columns.length - 1,
                              textAlign: columns[x].textAlign,
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ],
    );
  }
}

class _TableCellHeader extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final EdgeInsets? padding;
  final bool first;
  final bool last;

  const _TableCellHeader(this.text, {this.first = false, this.last = false, this.textAlign = TextAlign.left, this.padding});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.only(
        top: 8 + (padding?.top ?? 0),
        bottom: 8 + (padding?.bottom ?? 0),
        left: (first ? 0 : 16) + (padding?.left ?? 0),
        right: (last ? 0 : 16) + (padding?.right ?? 0),
      ),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: 1,
        style: textTheme.labelLarge!.copyWith(color: appColors.secondary),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final Widget child;
  final TextAlign textAlign;
  final bool first;
  final bool last;

  const _TableCell(this.child, {this.first = false, this.last = false, this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 16, left: first ? 0 : 16, right: last ? 0 : 16),
      child: child,
    );
  }
}
