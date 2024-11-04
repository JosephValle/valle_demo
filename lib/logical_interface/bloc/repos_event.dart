part of "repos_bloc.dart";

@immutable
sealed class ReposEvent {}

class GetRepos extends ReposEvent {}

class FlushRepos extends ReposEvent {}
