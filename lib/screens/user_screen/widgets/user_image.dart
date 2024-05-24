import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../models/user_model.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('Picture: ${user.picture}');
    }
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: CachedNetworkImage(
          width: double.infinity,
          fit: BoxFit.cover,
          imageUrl: user.picture,
          placeholder: (context, url) => const Center(
            child: Padding(
              padding:
                  EdgeInsets.all(30), // Use default value if padding is null
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// import '../../../models/user_model.dart';

// class UserImage extends StatelessWidget {
//   const UserImage({
//     super.key,
//     required this.user,
//   });

//   final UserModel user;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         ),
//         image: DecorationImage(
//           fit: BoxFit.cover,
//           image: NetworkImage(user.picture), //! Displaying user picture
//         ),
//       ),
//     );
//   }
// }