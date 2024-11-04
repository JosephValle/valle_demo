part of "repos_bloc.dart";

@immutable
sealed class ReposState {
  final List<RepoObject> repos;
  final bool clearing;

  const ReposState({required this.repos, this.clearing = false});
}

final class ReposLoading extends ReposState {
  final bool silent;

  const ReposLoading({required super.repos, required this.silent,  super.clearing});
}

final class ReposLoaded extends ReposState {
  const ReposLoaded({required super.repos, super.clearing});
}

final class ReposError extends ReposState {
  final String error;

  const ReposError({required this.error, required super.repos, super.clearing});
}
