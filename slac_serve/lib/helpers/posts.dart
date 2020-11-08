import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/posts.dart';

class PostsServices {
  String collection = "posts";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PostsModel>> getPosts() async =>
      _firestore.collection(collection).get().then((result) {
        List<PostsModel> posts = [];
        for (DocumentSnapshot post in result.docs) {
          posts.add(PostsModel.fromSnapshot(post));
        }
        return posts;
      });

  Future<List<PostsModel>> getPostsByCategory({String id}) async => _firestore
          .collection(collection)
          .where("role", isEqualTo: id)
          .get()
          .then((result) {
        List<PostsModel> posts = [];
        for (DocumentSnapshot post in result.docs) {
          posts.add(PostsModel.fromSnapshot(post));
        }
        return posts;
      });
}
