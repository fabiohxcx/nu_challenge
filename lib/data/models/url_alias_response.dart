/// Represents the `_links` object from the API response.
///
/// This class holds the different URL variations provided by the server.
/// {@category Model}
class Links {
  final String self;
  final String short;

  Links({required this.self, required this.short});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(self: json['self'] ?? '', short: json['short'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'self': self, 'short': short};
  }
}

/// Represents the main response object after successfully shortening a URL.
///
/// This model encapsulates the entire JSON payload returned by the API.
/// ---
/// ### Example:
/// ```{"alias":"702889725","_links":{"self":"www.google.com","short":"https://url-shortener-server.onrender.com/api/alias/702889725"}}```
/// {@category Model}
class UrlAliasResponse {
  final String alias;
  final Links links;

  UrlAliasResponse({required this.alias, required this.links});

  factory UrlAliasResponse.fromJson(Map<String, dynamic> json) {
    return UrlAliasResponse(
      alias: json['alias'] ?? '',

      links: (json['_links'] != null && json['_links'] is Map<String, dynamic>)
          ? Links.fromJson(json['_links'])
          : Links(self: '', short: ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {'alias': alias, '_links': links.toJson()};
  }
}
