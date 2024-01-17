import 'package:flutter/material.dart';

enum UserType {
  validator,
  user,
}

class UserTypeChip extends StatelessWidget {
  final UserType userType;
  final Alignment alignment;

  const UserTypeChip({
    required this.userType,
    this.alignment = Alignment.centerLeft,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: switch (userType) {
            UserType.user => const Color(0xff263042),
            UserType.validator => const Color(0x292f8af5),
          },
        ),
        child: Text(
          userType == UserType.user ? 'User' : 'Validator',
          style: TextStyle(
            fontSize: 12,
            color: switch (userType) {
              UserType.user => const Color(0xff6c86ad),
              UserType.validator => const Color(0xff2f8af5),
            },
          ),
        ),
      ),
    );
  }
}