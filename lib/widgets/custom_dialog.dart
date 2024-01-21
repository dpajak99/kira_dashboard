import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget child;
  final double width;

  const CustomDialog({
    required this.title,
    required this.child,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xff131823),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if(CustomDialogRoute.of(context).showBackButton )
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () => CustomDialogRoute.of(context).pop(),
                        ),
                      ),
                    ),
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}
