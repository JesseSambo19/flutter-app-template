
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../models/user_model.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text('${user.firstName} ${user.lastName}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )), //! Displaying user name
          Text(
            user.email,
            style: const TextStyle(fontStyle: FontStyle.italic, overflow: TextOverflow.ellipsis),
          ), //! Displaying user email
          Text(
            user.phone,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ), //! Displaying user phone number
        ],
      ),
    );
  }
}