import 'package:get/get.dart';
import 'package:guetaoproj/core/model/article.dart';
import 'package:guetaoproj/core/model/news_response_model.dart';
import 'package:guetaoproj/core/repository/news_repo.dart';
import 'package:guetaoproj/service/http_service.dart';
import 'package:guetaoproj/service/http_service_impl.dart';

class NewsRepoImpl implements NewsRepo {
  HttpService _httpService;

  NewsRepoImpl() {
    _httpService = Get.put(HttpServiceImpl());
    _httpService.init();
  }

  @override
  Future<List<Article>> getNewsHeadLine() async {
    try {
      final response = await _httpService.getRequest("v2/top-headlines?country=br");
      final parsedResponse = NewsResponse.fromJson(response.data);
      return parsedResponse.articles;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<Article>> getSearchedNews(String query) async {
    try {
      final response = await _httpService.getRequest("v2/everything?q=$query");
      final parsedResponse = NewsResponse.fromJson(response.data);
      return parsedResponse.articles;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
