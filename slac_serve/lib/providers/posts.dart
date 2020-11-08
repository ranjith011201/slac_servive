import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:shakthi_masala_user_app/widgets/tabs/spiceblends.dart';
import '../helpers/posts.dart';
import '../models/posts.dart';
import 'package:uuid/uuid.dart';

class PostsProvider with ChangeNotifier {
  PostsServices _postsServices = PostsServices();
  List<PostsModel> posts = [];
  List<PostsModel> postsByContribution = [];
  List<PostsModel> postsByAchievement = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<PostsModel> postsByRequest = [];

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController role = TextEditingController();

  var imageUrl;
  Future<bool> createPosts() async {
    var id = Uuid();
    String postsID = id.v1();
    try {
      await _firestore.collection('posts').doc(postsID).set({
        'title': title.text,
        'description': description.text,
        'address': address.text,
        'pinCode': pincode.text,
        'imageURL': imageUrl,
        // 'id': postsID,
        'name': name.text,
        'role': role.text,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void clearController() {
    name.text = "";
    description.text = "";
    title.text = "";
    address.text = "";
    pincode.text = "";
  }

  PostsProvider.initialize() {
    loadPostsByCategory();
  }

  loadPosts() async {
    posts = await _postsServices.getPosts();
    notifyListeners();
  }

  Future loadPostsByCategory({String categoryName}) async {
    switch (categoryName) {
      case 'Contribution':
        postsByContribution =
            await _postsServices.getPostsByCategory(id: categoryName);
        notifyListeners();
        break;
      case 'Request':
        postsByContribution =
            await _postsServices.getPostsByCategory(id: categoryName);
        notifyListeners();
        break;
      case 'Achievement':
        postsByContribution =
            await _postsServices.getPostsByCategory(id: categoryName);
        notifyListeners();
        break;

      default:
        posts = await _postsServices.getPosts();
        notifyListeners();
    }
  }

//  likeDislikeProduct({String userId, ProductModel product, bool liked})async{
//    if(liked){
//      if(product.userLikes.remove(userId)){
//        _productServices.likeOrDislikeProduct(id: product.id, userLikes: product.userLikes);
//      }else{
//        print("THE USER WA NOT REMOVED");
//      }
//    }else{
//
//      product.userLikes.add(userId);
//        _productServices.likeOrDislikeProduct(id: product.id, userLikes: product.userLikes);
//
//
//      }
//  }

  // Future search({String productName}) async {
  //   productsSearched =
  //       await _productServices.searchProducts(productName: productName);
  //   print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");
  //   print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");
  //   print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");

  //   notifyListeners();
  // }
}
