// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:slac_serve/models/user.dart';

// class AuthenticationService {
//   var id;
//   final FirebaseAuth _firebaseAuth;

//   FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   AuthenticationService(this._firebaseAuth);

//   /// Changed to idTokenChanges as it updates depending on more cases.
//   Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

//   /// This won't pop routes so you could do something like
//   /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
//   /// after you called this method if you want to pop all routes.
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }

//   /// There are a lot of different ways on how you can do exception handling.
//   /// This is to make it as easy as possible but a better way would be to
//   /// use your own custom class that would take the exception and return better
//   /// error messages. That way you can throw, return or whatever you prefer with that instead.
//   Future<String> signIn({String email, String password}) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);
//       return "Signed in";
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }

//   /// There are a lot of different ways on how you can do exception handling.
//   /// This is to make it as easy as possible but a better way would be to
//   /// use your own custom class that would take the exception and return better
//   /// error messages. That way you can throw, return or whatever you prefer with that instead.
//   Future<String> signUp(
//       {String email,
//       String password,
//       String name,
//       String address,
//       String imageUrl,
//       String pinCode,
//       String role}) async {
//     try {
//       await _firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password)
//           .then((result) {
//         id = result.user.uid;
//         _firestore.collection('users').doc(result.user.uid).set({
//           'name': name,
//           'email': email,
//           'uid': result.user.uid,
//           'address': address,
//           'pinCode': pinCode,
//           'role': role,
//           'imageUrl': imageUrl,
//         });
//       });
//       return "Signed up";
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }

//   // String getUserName(var id) {
//   //   _firestore
//   //       .collection("users")
//   //       .where("uid", isEqualTo: id)
//   //       .get()
//   //       .then((result) {
//   //     List<UserModel> users = [];
//   //     for (DocumentSnapshot user in result.docs) {
//   //       users.add(UserModel.fromSnapshot(user));
//   //     }
//   //     return users[0].name;
//   //   });
//   // }
// }
