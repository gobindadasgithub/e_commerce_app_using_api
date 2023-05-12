import 'package:dio/dio.dart';
import 'package:e_commerce_shop_api/model/articile_modle.dart';

class ApiControll{
  var dio= Dio();
  static Future<List<Article>> fatchArticle() async{
    Response response=await Dio().get('http://localhost:3000/api/products');
    return (response.data as List).map((x) => Article.fromJson(x)).toList();

  }
  static Future<List<Article>> fetchArticleByCategorie(
      String categoriename) async {
    Response response = await Dio()
        .get('http://localhost:3000/api/products/category/$categoriename');
    return (response.data as List).map((x) => Article.fromJson(x)).toList();
  }
  static Future<Article> fetchArticleByID(int aricle_ID) async {
    Response response =
    await Dio().get('http://localhost:3000/api/products/$aricle_ID');
//        await Dio().get('http://localhost:3000/api/products/1');
    Article _article = Article.fromJson(response.data);
    return _article;
    //return (response.data as List).map((x) => Article.fromJson(x)).toList();
  }


}