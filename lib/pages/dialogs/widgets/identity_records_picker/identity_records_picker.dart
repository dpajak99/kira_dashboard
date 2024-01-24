import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/select_identity_records_dialog/select_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/select_token_dialog/select_token_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field_layout.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field_state.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field_cubit.dart';
import 'package:kira_dashboard/widgets/token_icon.dart';

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
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (BuildContext context, List<IdentityRecord> records, _) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            color: Color(0xff06070a),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Records',
                      style: TextStyle(fontSize: 13, color: Color(0xff6c86ad)),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        List<IdentityRecord>? newRecords = await DialogRouter().navigate(SelectIdentityRecordsDialog(
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
                      child: const Icon(
                        AppIcons.pencil,
                        color: Color(0xff6c86ad),
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
                              style: const TextStyle(fontSize: 13, color: Color(0xfffbfbfb)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              record.value,
                              maxLines: 1,
                              style: const TextStyle(fontSize: 13, color: Color(0xfffbfbfb)),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
              if (records.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Records cannot be empty',
                        style: TextStyle(fontSize: 13, color: Color(0xfff12e1f)),
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
