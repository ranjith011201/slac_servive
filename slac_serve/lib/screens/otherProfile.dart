import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slac_serve/providers/user.dart';

class OtherProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    auth.reloadUserModel();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
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
            SizedBox(height: 20),
            Text(
              'ContactDetails',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              auth.userModel.email,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Divider(
              thickness: 2,
              color: Colors.white,
              height: 30,
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
