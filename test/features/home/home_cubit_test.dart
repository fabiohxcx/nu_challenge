import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nu_challenge/data/models/url_alias_response.dart';
import 'package:nu_challenge/data/network/api_result.dart';
import 'package:nu_challenge/data/repositories/url_shortener_repository.dart';
import 'package:nu_challenge/features/home/home_cubit.dart';

class MockUrlShortenerRepository extends Mock implements UrlShortenerRepository {}

void main() {
  late HomeCubit homeCubit;
  late MockUrlShortenerRepository mockUrlShortenerRepository;

  setUp(() {
    mockUrlShortenerRepository = MockUrlShortenerRepository();
    homeCubit = HomeCubit(mockUrlShortenerRepository);
  });

  test('initial state is HomeInitial', () {
    expect(homeCubit.state, isA<HomeInitial>());
  });

  group('shorten url', () {
    final url = 'https://example.com';
    final urlAliasResponse = UrlAliasResponse(
      alias: '123456',
      links: Links(self: "https://example.com", short: "https://url-shortener-server.onrender.com/api/alias/123456"),
    );

    //Success Test
    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, Homesuccess] when shortenUrl is successful',
      build: () {
        when(
          () => mockUrlShortenerRepository.shortenUrl(originalUrl: url),
        ).thenAnswer((_) async => Success(data: urlAliasResponse));

        return homeCubit;
      },
      act: (cubit) => cubit.shortenUrl(url),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeSuccess>().having((state) => state.shortenedUrls, 'shortenedUrls', [urlAliasResponse]),
      ],
    );

    // Fail Test
    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeError] when shortenUrl fails',
      build: () {
        when(
          () => mockUrlShortenerRepository.shortenUrl(originalUrl: url),
        ).thenAnswer((_) async => Failure(errorMessage: 'errorMessage'));

        return homeCubit;
      },
      act: (cubit) => cubit.shortenUrl(url),
      expect: () => [isA<HomeLoading>(), isA<HomeError>().having((state) => state.message, 'message', 'errorMessage')],
    );

    //Blank test
    blocTest<HomeCubit, HomeState>(
      'emits [HomeError] when url is empty',
      build: () => homeCubit,
      act: (cubit) => cubit.shortenUrl(''),
      expect: () => [isA<HomeError>().having((state) => state.message, 'message', 'Please enter a URL to shorten.')],
    );
  });
}
