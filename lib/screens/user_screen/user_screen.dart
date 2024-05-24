//! Importing necessary packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_model/utils/check_connectivity.dart';

//! Importing user provider and model
import '../../providers/app_provider.dart';
import '../../providers/user_provider.dart';
import '../../models/user_model.dart';
import '../../widgets/internet_connection.dart';
import '../../widgets/loading.dart';
import '../../widgets/no_user_data.dart';
import '../../widgets/refresh.dart';
import 'widgets/user_details.dart';
import 'widgets/user_image.dart';

//! Defining UserScreen widget
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  UserScreenState createState() => UserScreenState();
}

//! State class for UserScreen widget
class UserScreenState extends State<UserScreen> {
  late AppProvider appProvider;
  late UserProvider userProvider;

//! this will initially be empty, but it will used only once when navigating is on this screen
  late Future<UserModel?> userFuture;
  @override
  void initState() {
    super.initState();
    checkConnectivity(context);
    //! this will be called only once on this screen
    userFuture = Provider.of<UserProvider>(context, listen: false).fetchUser();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppProvider>(context, listen: false)
          .fetchDataPeriodically(context, () async {
        userFuture =
            Provider.of<UserProvider>(context, listen: false).fetchUser();
      });
    });
  }

  Future refreshUI() async {
    setState(() {
      userFuture =
          Provider.of<UserProvider>(context, listen: false).fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
    userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Random User'),
      ), //! AppBar with title
      body: appProvider.getIsConnected
          ? RefreshIndicator(
              onRefresh: refreshUI,
              //! in order for RefreshIndicator to work, wrap the child widget with a ListView e.g. FutureBuilder
              //! if the children of the child widget use a ListView, then wrap the individual widgets with a ListView
              //! otherwise RefreshIndicator won't work for all widgets in the widget tree
              //!  Do not use more than one ListView widget otherwise there will an error
              child: ListView(
                children: [
                  FutureBuilder<UserModel?>(
                    //! this will be called only once on this screen, if exiting the screen and coming back
                    //! then it will be called again
                    future: userFuture,
                    //! will be called more than once
                    // future: userProvider.fetchUser(),
                    builder: (context, AsyncSnapshot<UserModel?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Loading();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Refresh();
                        } else if (snapshot.hasData) {
                          if (kDebugMode) {
                            print('Snapshot data: ${snapshot.data}');
                          }
                          final UserModel user = snapshot.data!;
                          // final UserModel user =
                          //         userProvider.user!; //! Extracting user object
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      UserImage(user: user),
                                      UserDetails(user: user),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                      return const NoUserData();
                    },
                  ),
                ],
              ),
            )
          : const InternetConnection(),
    );
  }
}





//! Old code
// //
// //! Importing necessary packages
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:users_model/utils/connectivity.dart';

// //! Importing user provider and model
// import '../../providers/app_provider.dart';
// import '../../providers/user_provider.dart';
// import '../../models/user_model.dart';
// import 'widgets/user_details.dart';
// import 'widgets/user_image.dart';

// //! Defining UserScreen widget
// class UserScreen extends StatefulWidget {
//   const UserScreen({super.key});

//   @override
//   UserScreenState createState() => UserScreenState();
// }

// //! State class for UserScreen widget
// class UserScreenState extends State<UserScreen> {
//   @override
//   void initState() {
//     super.initState();
//     checkConnectivity(context);
//     //! Fetching user data when the screen initializes
//     Provider.of<UserProvider>(context, listen: false).fetchUser();
//   }

//   late AppProvider appProvider;

//   @override
//   Widget build(BuildContext context) {
//     appProvider = Provider.of<AppProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Random User'),
//       ), //! AppBar with title
//       body: appProvider.getIsConnected
//           ? Center(
//               child: Consumer<UserProvider>(
//                 //! Using Consumer to rebuild parts of the UI that depend on user data
//                 builder: (context, userProvider, child) {
//                   //! Checking if user data is still loading
//                   if (userProvider.user == null) {
//                     return const CircularProgressIndicator(); //! Displaying a loading indicator
//                   }
//                   //! Once user data is available, displaying user details
//                   final UserModel user =
//                       userProvider.user!; //! Extracting user object
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         // height: 300,
//                         width: 250,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.grey,
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             UserImage(user: user),
//                             UserDetails(user: user),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             )
//           : const Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: Column(
//                     children: [
//                       Icon(Icons.wifi_off),
//                       Text(
//                         'Please connect to the internet.',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
