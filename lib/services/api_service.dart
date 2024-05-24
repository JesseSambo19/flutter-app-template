import 'dart:convert';
import 'package:http/http.dart' as http;

//! The ApiService class handles API calls.
class ApiService {
  //! Method to make a GET request to the given URL.
  Future get(String url) async {
    final response = await http.get(Uri.parse(url)); //! Making the GET request.
    if (response.statusCode == 200) {
      //! Checking if the request was successful.
      return jsonDecode(response.body); //! Parsing the response body as JSON.
    } else {
      throw Exception(
          'Failed to load data'); //! Throwing an exception if the request failed.
    }
  }

  //! Method to make a POST request to the given URL.
  Future post(String url) async {
    final response =
        await http.post(Uri.parse(url)); //! Making the POST request.
    if (response.statusCode == 200) {
      //! Checking if the request was successful.
      return jsonDecode(response.body); //! Parsing the response body as JSON.
    } else {
      throw Exception(
          'Failed to load data'); //! Throwing an exception if the request failed.
    }
  }

  //! Method to make a PUT request to the given URL.
  Future put(String url) async {
    final response = await http.put(Uri.parse(url)); //! Making the PUT request.
    if (response.statusCode == 200) {
      //! Checking if the request was successful.
      return jsonDecode(response.body); //! Parsing the response body as JSON.
    } else {
      throw Exception(
          'Failed to load data'); //! Throwing an exception if the request failed.
    }
  }

  //! Method to make a DELETE request to the given URL.
  Future delete(String url) async {
    final response = await http.delete(Uri.parse(url)); //! Making the DELETE request.
    if (response.statusCode == 200) {
      //! Checking if the request was successful.
      return jsonDecode(response.body); //! Parsing the response body as JSON.
    } else {
      throw Exception(
          'Failed to load data'); //! Throwing an exception if the request failed.
    }
  }
}