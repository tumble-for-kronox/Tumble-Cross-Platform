import 'dart:async';
import 'dart:io';
import 'dart:convert';

class HttpService {
  static Future<HttpClientResponse?> sendGetRequestToServer(Uri url) async {
    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      HttpClientRequest request =
          await client.getUrl(url).timeout(const Duration(seconds: 10));
      return await request.close();
    } on Exception {
      return null;
    }
  }

  static Future<HttpClientResponse?> sendPostRequestToServer(
      Uri url, String body) async {
    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      HttpClientRequest request =
          await client.postUrl(url).timeout(const Duration(seconds: 10));
      request.add(utf8.encode(body));
      return await request.close();
    } on Exception {
      return null;
    }
  }

  static Future<HttpClientResponse?> sendPutRequestToServer(Uri url) async {
    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      HttpClientRequest request =
          await client.putUrl(url).timeout(const Duration(seconds: 10));
      return await request.close();
    } on Exception {
      return null;
    }
  }
}
