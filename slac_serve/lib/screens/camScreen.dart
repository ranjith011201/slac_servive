import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:slac_serve/providers/posts.dart';

// import 'package:video_player/video_player.dart';
import 'dart:io';

// import 'package:slac_serve/providers/user.dart';
import 'package:slac_serve/screens/homeFeed.dart';

class CamScreen extends StatefulWidget {
  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  final _key = GlobalKey<ScaffoldState>();
  File _image;

  // final picker = ImagePicker();

  var isImage = true;

  pickImageFromGallery(context) async {
    Navigator.pop(context);
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  captureImageWithCamera(context) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, maxHeight: 680, maxWidth: 970);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  // takeVideo(nContext) {
  //   return showDialog(
  //       context: nContext,
  //       builder: (context) {
  //         return SimpleDialog(
  //           title: Text("New Post"),
  //           children: <Widget>[
  //             SimpleDialogOption(
  //               child: Text(
  //                 "Record Video with Camera",
  //                 style: TextStyle(color: Colors.black),
  //               ),
  //               onPressed: () => _pickVideo(),
  //             ),
  //             SimpleDialogOption(
  //               child: Text(
  //                 "Select Video from Gallery",
  //                 style: TextStyle(color: Colors.black),
  //               ),
  //               onPressed: () => _pickVideoFromCamera(),
  //             ),
  //             SimpleDialogOption(
  //               child: Text(
  //                 "Cancel",
  //                 style: TextStyle(color: Colors.black),
  //               ),
  //               onPressed: () => Navigator.pop(context),
  //             ),
  //           ],
  //         );
  //       });
  // }

  takeImage(nContext) {
    return showDialog(
        context: nContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("New Post"),
            children: <Widget>[
              SimpleDialogOption(
                child: Text(
                  "Capture Image with Camera",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => captureImageWithCamera(nContext),
              ),
              SimpleDialogOption(
                child: Text(
                  "Select Image from Gallery",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => pickImageFromGallery(nContext),
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<PostsProvider>(context);
    Future uploadPic(BuildContext context) async {
      Reference firebaseStorageReference =
          FirebaseStorage.instance.ref().child(_image.path);

      UploadTask uploadTask = firebaseStorageReference.putFile(_image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      postsProvider.imageUrl =
          (await taskSnapshot.ref.getDownloadURL()).toString();
      setState(() {
        print("Profile Picture uploaded");
        // Scaffold.of(context)
        //     .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 9 / 8,
              child: Container(
                width: double.infinity,
                child: (_image != null)
                    ? Image.file(
                        _image,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        'assets/profile1.png',
                        fit: BoxFit.fill,
                      ),
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.amber,
                  size: 30,
                ),
                onPressed: () {
                  takeImage(context);
                },
              ),
            ),
            //   Align(
            //     alignment: Alignment.bottomRight,
            //     child: IconButton(
            //       color: Colors.amber,
            //       icon: Icon(Icons.camera_alt, size: 30),
            //       onPressed: () {
            //         takeImage(context);
            //       },
            //     ),
            //  ),

            SizedBox(height: 2),
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 40, right: 40),
              child: TextField(
                controller: postsProvider.name,
                obscureText: false,
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                  filled: true,
                  fillColor: Color(0xff161d27).withOpacity(0.9),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: Colors.amber)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: Colors.amber)),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 40, right: 40),
              child: TextField(
                controller: postsProvider.title,
                obscureText: false,
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                  filled: true,
                  fillColor: Color(0xff161d27).withOpacity(0.9),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: Colors.amber)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: Colors.amber)),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 40, right: 40),
              child: TextField(
                controller: postsProvider.description,
                obscureText: false,
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                  filled: true,
                  fillColor: Color(0xff161d27).withOpacity(0.9),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: Colors.amber)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: Colors.amber)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 40, right: 40),
              child: TextField(
                controller: postsProvider.address,
                obscureText: false,
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Address",
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                  filled: true,
                  fillColor: Color(0xff161d27).withOpacity(0.9),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: Colors.amber)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: Colors.amber)),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 40, right: 40),
              child: TextField(
                controller: postsProvider.pincode,
                obscureText: false,
                style: TextStyle(fontSize: 16, color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Pincode",
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                  filled: true,
                  fillColor: Color(0xff161d27).withOpacity(0.9),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: Colors.amber)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: Colors.amber)),
                ),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: FlatButton(
                  onPressed: () async {
                    print('pressed' * 5);
                    if (!await postsProvider.createPosts()) {
                      _key.currentState.showSnackBar(
                          SnackBar(content: Text("Resgistration failed!")));
                      return;
                    }
                    await uploadPic(context);
                    print('succesfull' * 10);
                    postsProvider.clearController();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeFeed()),
                        ModalRoute.withName('HomeFeed'));
                  },
                  color: Colors.amber,
                  child: Text(
                    "Post",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: null,
      //   label: Text(
      //     'Post',
      //     style: TextStyle(color: Colors.white, fontSize: 24),
      //   ),
      // ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
