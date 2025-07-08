import 'package:dio/dio.dart';
import 'package:nu_challenge/data/network/api_result.dart';
import 'package:nu_challenge/data/network/dio_client.dart';

import '../models/url_alias_response.dart';

/// Defines the contract for the URL shortener data source.
///
/// This abstract class allows for a clean separation between the data layer
/// and the business logic, making the app easier to test and maintain.
///
/// {@category Data Layer}
abstract class UrlShortenerRepository {
  /// Submits a URL to be shortened.
  ///
  /// - [originalUrl]: The URL that needs to be shortened.
  ///
  /// Returns an [ApiResult] containing a [UrlAliasResponse] on success.
  Future<ApiResult<UrlAliasResponse>> shortenUrl({required String originalUrl});

  /// Fetches the original URL for a given short [alias].
  ///
  /// - [alias]: The short code for the URL to look up.
  ///
  /// Returns an [ApiResult] containing the original URL as a [String] on success.
  Future<ApiResult<String>> getUrlDetails({required String alias});
}

/// The concrete implementation of [UrlShortenerRepository].
///
/// This class uses a [DioClient] to communicate with the remote API.
class UrlShortenerRepositoryImpl implements UrlShortenerRepository {
  final DioClient dioClient;

  UrlShortenerRepositoryImpl(this.dioClient);

  @override
  Future<ApiResult<UrlAliasResponse>> shortenUrl({required String originalUrl}) async {
    try {
      final responseData = await dioClient.post('/api/alias', data: {"url": originalUrl});

      final urlResponse = UrlAliasResponse.fromJson(responseData);

      return Success(data: urlResponse);
    } on DioException catch (e) {
      final errorMessage = getDioErrorMessage(e);
      return Failure(errorMessage: errorMessage, statusCode: e.response?.statusCode);
    } catch (e) {
      return Failure(errorMessage: 'Failed to process server response.');
    }
  }

  @override
  Future<ApiResult<String>> getUrlDetails({required String alias}) async {
    try {
      final responseData = await dioClient.get('/api/alias/$alias');

      final String originalUrl = responseData['url'] ?? '';

      return Success(data: originalUrl);
    } on DioException catch (e) {
      final errorMessage = getDioErrorMessage(e);
      return Failure(errorMessage: errorMessage, statusCode: e.response?.statusCode);
    } catch (e) {
      return Failure(errorMessage: 'An unexpected error occurred while processing the data.');
    }
  }
}
