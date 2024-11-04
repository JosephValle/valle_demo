import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";
import "package:vumc_demo_valle/logical_interface/bloc/repos_bloc.dart";
import "package:vumc_demo_valle/objects/repo_object.dart";
import "package:vumc_demo_valle/user_interface/list/widgets/repo_tile.dart";
import "package:vumc_demo_valle/user_interface/list/home_screen.dart";

class MockReposBloc extends Mock implements ReposBloc {}

void main() {
  late MockReposBloc reposBloc;

  setUp(() {
    reposBloc = MockReposBloc();
    when(() => reposBloc.stream)
        .thenAnswer((_) => const Stream<ReposState>.empty());
    when(() => reposBloc.state)
        .thenReturn(const ReposLoading(repos: [], silent: false));
  });

  Widget createWidgetUnderTest() {
    return BlocProvider<ReposBloc>.value(
      value: reposBloc,
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }

  group("HomeScreen Tests", () {
    testWidgets("displays CircularProgressIndicator when ReposLoading state",
        (WidgetTester tester) async {
      when(() => reposBloc.state)
          .thenReturn(const ReposLoading(repos: [], silent: false));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets("displays error message when ReposError state",
        (WidgetTester tester) async {
      const errorMessage = "Error loading repos";
      when(() => reposBloc.state)
          .thenReturn(const ReposError(error: errorMessage, repos: []));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text("Error: $errorMessage"), findsOneWidget);
    });

    testWidgets("displays RepoTile widgets when repos are loaded",
        (WidgetTester tester) async {
      final repos = [
        RepoObject(
          repositoryId: "abc",
          name: "Test",
          url: "github.com",
          createdDate: DateTime.now(),
          lastPushDate: DateTime.now(),
          description: "Test",
          stars: 100,
        ),
      ];
      when(() => reposBloc.state).thenReturn(ReposLoaded(repos: repos));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(RepoTile), findsNWidgets(repos.length));
    });
  });
}
