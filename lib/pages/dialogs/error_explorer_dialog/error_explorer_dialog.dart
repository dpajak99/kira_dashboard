import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_view/json_view.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class ErrorExplorerDialog extends DialogContentWidget {
  final Response<dynamic> response;

  const ErrorExplorerDialog({
    super.key,
    required this.response,
  });

  @override
  State<StatefulWidget> createState() => _ErrorExplorerDialogState();
}

class _ErrorExplorerDialogState extends State<ErrorExplorerDialog> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: 'Error details',
      width: 600,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: appColors.surface,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Row(
              children: [
                Text(widget.response.requestOptions.method),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.response.requestOptions.uri.toString(),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () {},
                  radius: 30,
                  child: Icon(
                    Icons.copy,
                    color: appColors.secondary,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: appColors.surface,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Request',
                        style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: JsonView(
                          json: widget.response.requestOptions.data,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: appColors.surface,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Response',
                        style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: JsonView(
                          json: widget.response.data,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
