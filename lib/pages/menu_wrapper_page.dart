import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';

@RoutePage()
class MenuWrapperPage extends StatelessWidget {
  const MenuWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
              width: 200,
              height: double.infinity,
              color: const Color(0xff1a1f36),
              child: Column(
                children: [
                  ListTile(
                    onTap: () => AutoRouter.of(context).navigate(const ValidatorsRoute()),
                    title: const Text('Validators'),
                  ),
                  ListTile(
                    onTap: () => AutoRouter.of(context).navigate(const BlocksRoute()),
                    title: const Text('Blocks'),
                  ),
                ],
              )),
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1500),
                child: const AutoRouter(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
