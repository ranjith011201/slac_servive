import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slac_serve/providers/user.dart';
// import 'package:slac_serve/services/user.dart';
// import 'package:provider/provider.dart';
// import 'package:slac_serve/providers/user.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<UserProvider>(context);
//     auth.reloadUserModel();
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
//         child: Align(
//           alignment: Alignment.topCenter,
//           child: Column(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 60,
//                 child: ClipOval(
//                   child: new SizedBox(
//                     width: 180,
//                     height: 180,
//                     child: Image.asset(
//                       'assets/profile1.png',
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//               ),
//               Text(
//                 auth.userModel.name,
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:slac_serve/widgets/feedWidget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
//     auth.reloadUserModel();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: ClipOval(
                      child: new SizedBox(
                        width: 180,
                        height: 180,
                        child: Image.asset(
                          'assets/profile1.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    auth.userModel.name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Text(
            auth.userModel.email,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Divider(
            thickness: 2,
            color: Colors.white,
            height: 30,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: Text(
                'My Posts',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: FeedWidget(),
          ),
        ],
      ),
    );
  }
}
