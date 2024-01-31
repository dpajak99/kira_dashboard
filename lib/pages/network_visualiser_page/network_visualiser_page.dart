import 'package:auto_route/annotations.dart';
import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/network_visualiser_page/network_visualiser_cubit.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';
import 'package:kira_dashboard/widgets/sliver_page_padding.dart';

@RoutePage()
class NetworkVisualiserPage extends StatefulWidget {
  const NetworkVisualiserPage({super.key});

  @override
  State<StatefulWidget> createState() => _NetworkVisualiserPageState();
}

class _NetworkVisualiserPageState extends State<NetworkVisualiserPage> {
  final NetworkVisualiserCubit networkVisualiserCubit = NetworkVisualiserCubit();

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      slivers: [
        SliverPagePadding(
          sliver: SliverToBoxAdapter(
            child: SimpleMap(
              // String of instructions to draw the map.
              instructions: SMapWorld.instructions,

              countryBorder: const CountryBorder(
                color: Color(0xff06070a),
                width: 1,
              ),

              // Matching class to specify custom colors for each area.

              // Default color for all countries.
              defaultColor: const Color(0xff6c86ad),

              // Details of what area is being touched, giving you the ID, name and tapdetails
              callback: (id, name, tapdetails) {
                print(id);
              },
            ),
          ),
        ),
      ],
    );
  }
}
