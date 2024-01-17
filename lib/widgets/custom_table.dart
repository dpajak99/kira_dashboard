import 'package:flutter/material.dart';

typedef CellBuilder<T> = Widget Function(BuildContext context, T item);

class ColumnConfig<T> {
  final int flex;
  final double? width;
  final String title;
  final TextAlign textAlign;
  final CellBuilder<T> cellBuilder;

  const ColumnConfig({
    required this.title,
    required this.cellBuilder,
    this.flex = 1,
    this.width,
    this.textAlign = TextAlign.left,
  });
}

class CustomTable<T> extends StatelessWidget {
  final List<T> items;
  final List<ColumnConfig<T>> columns;

  const CustomTable({
    super.key,
    required this.items,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                      first: i == 0,
                      last: i == columns.length - 1,
                      textAlign: columns[i].textAlign,
                    ),
                  ),
            ],
          ),
        ),
        for (T item in items)
          Row(
            children: <Widget>[
              for (int i = 0; i < columns.length; i++)
                if (columns[i].width != null)
                  SizedBox(
                    width: columns[i].width,
                    child: _TableCell(
                      columns[i].cellBuilder(context, item),
                      first: i == 0,
                      last: i == columns.length - 1,
                      textAlign: columns[i].textAlign,
                    ),
                  )
                else
                  Expanded(
                    flex: columns[i].flex,
                    child: _TableCell(
                      columns[i].cellBuilder(context, item),
                      first: i == 0,
                      last: i == columns.length - 1,
                      textAlign: columns[i].textAlign,
                    ),
                  ),
            ],
          )
      ],
    );
  }
}

class _TableCellHeader extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final bool first;
  final bool last;

  const _TableCellHeader(this.text, {this.first = false, this.last = false, this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: first ? 0 : 16, right: last ? 0 : 16),
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
