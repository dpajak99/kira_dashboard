import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/select_identity_records_dialog/select_identity_records_dialog.dart';

class IdentityRecordsPickerController extends ValueNotifier<List<IdentityRecord>> {
  IdentityRecordsPickerController() : super(<IdentityRecord>[]);
}

class IdentityRecordsPicker extends StatefulWidget {
  final IdentityRecordsPickerController controller;
  final String address;
  final List<IdentityRecord> initialRecords;

  IdentityRecordsPicker({
    required this.address,
    required this.initialRecords,
    IdentityRecordsPickerController? controller,
    super.key,
  }) : controller = controller ?? IdentityRecordsPickerController();

  @override
  State<StatefulWidget> createState() => _IdentityRecordsPickerState();
}

class _IdentityRecordsPickerState extends State<IdentityRecordsPicker> {
  @override
  void initState() {
    super.initState();
    if (widget.initialRecords.isNotEmpty) {
      widget.controller.value = widget.initialRecords;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (BuildContext context, List<IdentityRecord> records, _) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: appColors.surface,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Records',
                      style: textTheme.labelLarge!.copyWith(color: appColors.secondary),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        List<IdentityRecord>? newRecords = await DialogRouter().navigate<List<IdentityRecord>?>(SelectIdentityRecordsDialog(
                          address: widget.address,
                          selectedRecords: records,
                        ));
                        if( newRecords != null ) {
                          setState(() {
                            widget.controller.value = newRecords;
                          });
                        }
                      },
                      radius: 30,
                      child: Icon(
                        AppIcons.pencil,
                        color: appColors.secondary,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (IdentityRecord record in records)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              record.key,
                              maxLines: 1,
                              style: textTheme.titleLarge!.copyWith(color:  appColors.onBackground),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              record.value,
                              maxLines: 1,
                              style: textTheme.labelLarge!.copyWith(color:  appColors.onBackground),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
              if (records.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Records cannot be empty',
                        style: textTheme.labelLarge!.copyWith(color: appColors.error),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
