import 'dart:convert';
import 'package:movieapp/constants/constants.dart';
import 'package:http/http.dart' as http;
import '../../models/GenreMovieDetails.dart';
import '../../models/GenresMovieModel.dart';
import '../../models/MovieDetailModel.dart';
import '../../models/PopularMovie.dart';
import '../../models/SearchMovieModel.dart';
import '../../models/SimilarMovie.dart';
import '../../models/TopRatedMovie.dart';
import '../../models/TrailerResponse.dart';

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
  static Future<SearchMovieModel> searchMovie(String query) async {
    var url = Uri.https(
        Constants.baseUrl, '/3/search/movie',
        {
          'api_key': Constants.apiKey,
          'query': query
        });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var searchMovieModel = SearchMovieModel.fromJson(json);
      return searchMovieModel;
    } catch (error) {
      rethrow;
    }
  }
  static Future<GenresMovieModel> getGenresMovie() async {
    var url = Uri.https(Constants.baseUrl, '/3/genre/movie/list', {
      'api_key': Constants.apiKey,
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var genreMovieModel = GenresMovieModel.fromJson(json);
      return genreMovieModel;
    } catch (error) {
      rethrow;
    }
  }
  static Future<GenreMovieDetails> genresMovieDetails(int genreID) async {
    var url = Uri.https(Constants.baseUrl, '/3/discover/movie',
        {'api_key': Constants.apiKey, "with_genres": '$genreID'});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var genreMovieDetails = GenreMovieDetails.fromJson(json);
      return genreMovieDetails;
    } catch (error) {
      rethrow;
    }
  }
  static Future<SimilarMovie> getSimilarMovie(int movieID) async {
    var url =
    Uri.https(Constants.baseUrl, '/3/movie/$movieID/similar',
        {'api_key': Constants.apiKey});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var similarMovie = SimilarMovie.fromJson(json);
      return similarMovie;
    } catch (error) {
      rethrow;
    }
  }
  static Future<MovieDetailModel> getMovieDetails(int movieID) async {
    var url = Uri.https(Constants.baseUrl, '/3/movie/$movieID',
        {'api_key': Constants.apiKey});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var movieDetailModel = MovieDetailModel.fromJson(json);
      return movieDetailModel;
    } catch (error) {
      rethrow;
    }
  }
  static Future<TrailerResponse> youtubeMoviesResponse(int movie_id) async {
    Uri url = Uri.https(
        Constants.baseUrl, '/3/movie/$movie_id/videos', {
      "api_key": Constants.apiKey,
      "language": "en-US",
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return TrailerResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}