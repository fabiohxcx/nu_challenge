part of 'home_cubit.dart';

/// {@category Features}
@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<UrlAliasResponse> shortenedUrls;

  HomeSuccess({required this.shortenedUrls});
}

final class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
