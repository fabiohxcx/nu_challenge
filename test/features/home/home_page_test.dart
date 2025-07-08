import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nu_challenge/data/models/url_alias_response.dart';
import 'package:nu_challenge/features/home/home_cubit.dart';
import 'package:nu_challenge/features/home/home_page.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
  late MockHomeCubit mockHomeCubit;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<HomeCubit>.value(value: mockHomeCubit, child: const HomePage()),
    );
  }

  testWidgets('renders initial text when state is HomeInitial', (widgetTester) async {
    when(() => mockHomeCubit.state).thenReturn(HomeInitial());
    await widgetTester.pumpWidget(createTestWidget());
    expect(find.text('Enter a URL to see your history here!'), findsOneWidget);
  });

  testWidgets('shows circular progress indicator when state is HomeLoading', (widgetTester) async {
    // Configure o estado de loading do mock
    when(() => mockHomeCubit.state).thenReturn(HomeLoading());

    await widgetTester.pumpWidget(createTestWidget());

    // Verifique se o indicador de progresso é exibido
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders a list of URLs when state is HomeSuccess', (widgetTester) async {
    final urls = [
      UrlAliasResponse(
        alias: 'alias1',
        links: Links(self: 'https://example.com/1', short: 'short.url/1'),
      ),
      UrlAliasResponse(
        alias: 'alias2',
        links: Links(self: 'https://example.com/2', short: 'short.url/2'),
      ),
    ];

    // Configure o estado de sucesso do mock
    when(() => mockHomeCubit.state).thenReturn(HomeSuccess(shortenedUrls: urls));

    await widgetTester.pumpWidget(createTestWidget());

    // Verifique se o título da lista aparece
    expect(find.text('Recently shortened URLs'), findsOneWidget);

    // Verifique se os itens da lista são renderizados
    expect(find.text('alias1'), findsOneWidget);
    expect(find.text('https://example.com/1'), findsOneWidget);
    expect(find.text('alias2'), findsOneWidget);
    expect(find.text('https://example.com/2'), findsOneWidget);
  });

  testWidgets('calls shortenUrl on cubit when button is pressed', (widgetTester) async {
    // Configure um estado que permita pressionar o botão
    when(() => mockHomeCubit.state).thenReturn(HomeInitial());

    // Simular o comportamento do método shortenUrl
    when(() => mockHomeCubit.shortenUrl(any())).thenAnswer((_) async {});

    await widgetTester.pumpWidget(createTestWidget());

    // Digite uma URL no campo de texto
    await widgetTester.enterText(find.byType(TextField), 'https://sou.nu');

    // Toque no botão de enviar
    await widgetTester.tap(find.byType(ElevatedButton));

    // Verifique se o método shortenUrl foi chamado com a URL correta
    verify(() => mockHomeCubit.shortenUrl('https://sou.nu')).called(1);
  });
}
