import 'package:flutter_test/flutter_test.dart';
import 'package:nu_challenge/data/models/url_alias_response.dart';

void main() {
  final Map<String, dynamic> tUrlAliasResponseJson = {
    'alias': 'some_alias',
    '_links': {'self': 'http://original-url.com', 'short': 'http://short-url.com/some_alias'},
  };

  final tUrlAliasResponseModel = UrlAliasResponse(
    alias: 'some_alias',
    links: Links(self: 'http://original-url.com', short: 'http://short-url.com/some_alias'),
  );

  group('UrlAliasResponse Model', () {
    test('should create a valid model from JSON', () {
      final result = UrlAliasResponse.fromJson(tUrlAliasResponseJson);

      expect(result, isA<UrlAliasResponse>());
      expect(result.alias, tUrlAliasResponseModel.alias);
      expect(result.links.self, tUrlAliasResponseModel.links.self);
      expect(result.links.short, tUrlAliasResponseModel.links.short);
    });

    test('should return a JSON map containing the proper data', () {
      final result = tUrlAliasResponseModel.toJson();

      expect(result, tUrlAliasResponseJson);
    });
  });

  group('Links Model', () {
    test('should handle null or invalid _links map during creation', () {
      final jsonWithNullLinks = {'alias': 'some_alias', '_links': null};
      final jsonWithInvalidLinks = {'alias': 'some_alias', '_links': 'not_a_map'};

      final resultFromNull = UrlAliasResponse.fromJson(jsonWithNullLinks);
      final resultFromInvalid = UrlAliasResponse.fromJson(jsonWithInvalidLinks);

      expect(resultFromNull.links.self, '');
      expect(resultFromNull.links.short, '');
      expect(resultFromInvalid.links.self, '');
      expect(resultFromInvalid.links.short, '');
    });
  });
}
