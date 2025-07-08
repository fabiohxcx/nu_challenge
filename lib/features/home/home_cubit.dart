import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/url_alias_response.dart';
import '../../data/repositories/url_shortener_repository.dart';

part 'home_state.dart';

/// Manages the state for the home screen.
///
/// This Cubit handles the business logic for shortening URLs and maintaining
/// a list of previously shortened URLs.
///
/// {@category Features}
class HomeCubit extends Cubit<HomeState> {
  final UrlShortenerRepository _repository;
  final List<UrlAliasResponse> _urls = [];

  HomeCubit(this._repository) : super(HomeInitial());

  Future<void> shortenUrl(String originalUrl) async {
    if (originalUrl.isEmpty) {
      emit(HomeError(message: 'Please enter a URL to shorten.'));
      return;
    }

    emit(HomeLoading());

    final result = await _repository.shortenUrl(originalUrl: originalUrl);

    result.when(
      success: (urlAliasResponse) {
        _urls.insert(0, urlAliasResponse); // Adiciona no início da lista
        emit(HomeSuccess(shortenedUrls: List.from(_urls)));
      },
      failure: (errorMessage, _) {
        emit(HomeError(message: errorMessage));
      },
    );
  }
}
