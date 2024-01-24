import 'package:flutter/material.dart';
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

class CustomTable<T> extends StatelessWidget {
  final int pageSize;
  final bool loading;
  final List<T> items;
  final List<ColumnConfig<T>> columns;

  const CustomTable({
    super.key,
    required this.items,
    required this.columns,
    this.pageSize = 10,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (loading == false && items.isEmpty)
          const SizedBox(
            height: 300,
            child: Center(
              child: Text('Nothing here :(', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Color(0xff6c86ad))),
            ),
          )
        else ...<Widget>[
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xff222b3a),
                  width: 1,
                ),
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
            Row(
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
    return Container(
      padding: EdgeInsets.only(
        top: 8 + (padding?.top ?? 0),
        bottom: 8 + (padding?.bottom ?? 0),
        left: (first ? 0 : 16) + (padding?.left ?? 0),
        right: (last ? 0 : 16) + (padding?.right ?? 0),
      ),
      child: Text(text, textAlign: textAlign, style: const TextStyle(fontSize: 14, color: Color(0xff6c86ad))),
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
