import 'package:dio/dio.dart';

/// A sealed class that represents the result of an API call, which can
/// either be a [Success] or a [Failure].
///
/// Using a sealed class ensures that all possible outcomes (subclasses)
/// are handled, preventing runtime errors.
///
/// ---
/// ### Example:
///
/// Use the `when` method to handle both states safely:
/// ```dart
/// final apiResult = await myRepository.fetchData();
///
/// final message = apiResult.when(
///   success: (user) => 'Welcome, ${user.name}!',
///   failure: (error, _) => 'Error: $error',
/// );
///
/// print(message);
/// ```
/// {@category Data Layer}
sealed class ApiResult<T> {
  const ApiResult();

  /// Executes a callback based on whether the result is a [Success] or [Failure].
  ///
  /// - [success]: The function to execute if the result is successful.
  /// - [failure]: The function to execute if the result has failed.
  R when<R>({required R Function(T data) success, required R Function(String errorMessage, int? statusCode) failure});
}

/// Represents a successful API call, containing the resulting [data].
final class Success<T> extends ApiResult<T> {
  final T data;
  const Success({required this.data});
  @override
  R when<R>({required R Function(T data) success, required R Function(String errorMessage, int? statusCode) failure}) {
    return success(data);
  }
}

/// Represents a failed API call, containing an [errorMessage] and an optional
/// [statusCode].
final class Failure<T> extends ApiResult<T> {
  final String errorMessage;
  final int? statusCode;
  const Failure({required this.errorMessage, this.statusCode});
  @override
  R when<R>({required R Function(T data) success, required R Function(String errorMessage, int? statusCode) failure}) {
    return failure(errorMessage, statusCode);
  }
}

/// Converts a [DioException] into a user-friendly error message string.
///
/// This function categorizes the error based on its [DioExceptionType]
/// to provide more specific feedback to the user.
String getDioErrorMessage(DioException error) {
  switch (error.type) {
    case DioExceptionType.badResponse:
      return _handleBadResponse(error.response);

    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return 'Connection timed out. Please try again.';

    case DioExceptionType.badCertificate:
      return 'Bad certificate. The connection is not secure.';

    case DioExceptionType.connectionError:
      return 'Connection error. Please check your internet connection.';

    case DioExceptionType.cancel:
      return 'The request was cancelled.';

    case DioExceptionType.unknown:
      return 'An unexpected error occurred. Please try again.';
  }
}

/// A private helper that generates an error message from a server `Response`.
///
/// It uses the HTTP status code to return a more specific error.
String _handleBadResponse(Response? response) {
  final int? statusCode = response?.statusCode;
  switch (statusCode) {
    case 400:
      return 'Bad Request. Please check your input.';
    case 401:
      return 'Unauthorized. Please check your credentials.';
    case 403:
      return 'Forbidden. You do not have permission to access this resource.';
    case 404:
      return 'The requested resource was not found.';
    case 500:
      return 'Internal Server Error. Please try again later.';
    default:
      return 'Received an invalid status code: $statusCode';
  }
}
