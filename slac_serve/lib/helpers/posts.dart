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

  // void likeOrDislikeProduct({String id, List<String> userLikes}) {
  //   _firestore.collection(collection).doc(id).update({"userLikes": userLikes});
  // }

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

  // Future<List<ProductModel>> getProductsOfCategory({String category}) async =>
  //     _firestore
  //         .collection(collection)
  //         .where("category", isEqualTo: category)
  //         .get()
  //         .then((result) {
  //       List<ProductModel> products = [];
  //       for (DocumentSnapshot product in result.docs) {
  //         products.add(ProductModel.fromSnapshot(product));
  //       }
  //       return products;
  //     });

  // Future<List<PostsModel>> searchPosts({String postName}) {
  //   // code to convert the first character to uppercase
  //   String searchKey = postName[0].toUpperCase() + postName.substring(1);
  //   return _firestore
  //       .collection(collection)
  //       .orderBy("name")
  //       .startAt([searchKey])
  //       .endAt([searchKey + '\uf8ff'])
  //       .get()
  //       .then((result) {
  //         List<ProductModel> products = [];
  //         for (DocumentSnapshot product in result.docs) {
  //           products.add(ProductModel.fromSnapshot(product));
  //         }
  //         return products;
  //       });
  // }
}
