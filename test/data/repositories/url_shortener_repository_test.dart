import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nu_challenge/data/models/url_alias_response.dart';
import 'package:nu_challenge/data/network/api_result.dart';
import 'package:nu_challenge/data/network/dio_client.dart';
import 'package:nu_challenge/data/repositories/url_shortener_repository.dart';

import 'url_shortener_repository_test.mocks.dart';

@GenerateMocks([DioClient])
void main() {
  late MockDioClient mockDioClient;
  late UrlShortenerRepositoryImpl repository;

  setUp(() {
    mockDioClient = MockDioClient();
    repository = UrlShortenerRepositoryImpl(mockDioClient);
  });

  group('UrlShortenerRepository', () {
    const tOriginalUrl = 'https://www.google.com';
    const tAlias = 'some_alias';
    final tUrlAliasResponse = UrlAliasResponse(
      alias: tAlias,
      links: Links(self: tOriginalUrl, short: 'https://short.url/$tAlias'),
    );
    final tSuccessResponseData = tUrlAliasResponse.toJson();

    group('shortenUrl', () {
      test('should return UrlAliasResponse when the call to DioClient is successful', () async {
        when(mockDioClient.post(any, data: anyNamed('data'))).thenAnswer((_) async => tSuccessResponseData);

        final result = await repository.shortenUrl(originalUrl: tOriginalUrl);

        expect(result, isA<Success<UrlAliasResponse>>());
        result.when(
          success: (data) => expect(data.alias, tAlias),
          failure: (err, code) => fail('Expected Success but got Failure'),
        );
        verify(mockDioClient.post('/api/alias', data: {'url': tOriginalUrl}));
        verifyNoMoreInteractions(mockDioClient);
      });

      test('should return Failure when the call to DioClient throws a DioException', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/api/alias'),
          response: Response(requestOptions: RequestOptions(path: ''), statusCode: 400),
          type: DioExceptionType.badResponse,
        );
        when(mockDioClient.post(any, data: anyNamed('data'))).thenThrow(dioException);

        final result = await repository.shortenUrl(originalUrl: tOriginalUrl);

        expect(result, isA<Failure>());
        result.when(
          success: (data) => fail('Expected Failure but got Success'),
          failure: (errorMessage, statusCode) {
            expect(errorMessage, 'Bad Request. Please check your input.');
            expect(statusCode, 400);
          },
        );
      });

      test('should return Failure on a generic exception', () async {
        when(mockDioClient.post(any, data: anyNamed('data'))).thenThrow(Exception('Generic Error'));

        final result = await repository.shortenUrl(originalUrl: tOriginalUrl);

        expect(result, isA<Failure>());
        result.when(
          success: (data) => fail('Expected Failure but got Success'),
          failure: (errorMessage, statusCode) {
            expect(errorMessage, 'Failed to process server response.');
            expect(statusCode, isNull);
          },
        );
      });
    });

    group("Get Url Details", () {
      const jsonString = '''
      {
          "url": "www.google.com"
      }
      ''';

      final Map<String, dynamic> jsonAsMap = jsonDecode(jsonString);
      String alias = "702889725";

      test('should return Url when the call to DioClient is successful', () async {
        when(mockDioClient.get(any)).thenAnswer((_) async => jsonAsMap);

        final result = await repository.getUrlDetails(alias: alias);

        expect(result, isA<Success<String>>());
        result.when(
          success: (data) => expect(data, "www.google.com"),
          failure: (err, code) => fail('Expected Success but got Failure'),
        );
        verify(mockDioClient.get('/api/alias/$alias'));
        verifyNoMoreInteractions(mockDioClient);
      });

      test('should return Success when the returned json is blank', () async {
        when(mockDioClient.get(any)).thenAnswer((_) async => {});

        final result = await repository.getUrlDetails(alias: alias);

        expect(result, isA<Success<String>>());
        result.when(
          success: (data) => expect(data, ""),
          failure: (err, code) => fail('Expected Success but got Failure'),
        );
        verify(mockDioClient.get('/api/alias/$alias'));
        verifyNoMoreInteractions(mockDioClient);
      });

      test('should return Failure when the call to DioClient throws a DioException', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/api/alias/$alias'),
          type: DioExceptionType.sendTimeout,
        );
        when(mockDioClient.get(any)).thenThrow(dioException);

        final result = await repository.getUrlDetails(alias: alias);

        result.when(
          success: (data) => fail('Expected Failure but got Success'),
          failure: (errorMessage, statusCode) {
            expect(errorMessage, 'Connection timed out. Please try again.');
          },
        );
      });
    });
  });
}
