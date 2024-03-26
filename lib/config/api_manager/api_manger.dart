import 'dart:convert';
import 'package:movieapp/constants/constants.dart';
import 'package:http/http.dart' as http;
import '../../models/PopularMovie.dart';
import '../../models/TopRatedMovie.dart';

class ApiManager{

  // https://api.themoviedb.org/3/movie/popular
  static Future<PopularMovie> getPopularMovie() async {
    var url = Uri.https(Constants.baseUrl, '/3/movie/popular', {'api_key': Constants.apiKey});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var popularMovie = PopularMovie.fromJson(json);
      return popularMovie;
    } catch (error) {
      rethrow;
    }
  }

  // https://api.themoviedb.org/3/movie/top_rated

  static Future<TopRatedMovie> getTopRatedMovie() async {
    var url = Uri.https(Constants.baseUrl, '/3/movie/top_rated',
        {'api_key': Constants.apiKey});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var topRatedMovie = TopRatedMovie.fromJson(json);
      return topRatedMovie;
    } catch (error) {
      rethrow;
    }
  }

  // https://api.themoviedb.org/3/movie/upcoming
  static Future<TopRatedMovie> getUpComingMovie() async {
    var url = Uri.https(Constants.baseUrl, '/3/movie/upcoming',
        {'api_key': Constants.apiKey});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var topRatedMovie = TopRatedMovie.fromJson(json);
      return topRatedMovie;
    } catch (error) {
      rethrow;
    }
  }

}