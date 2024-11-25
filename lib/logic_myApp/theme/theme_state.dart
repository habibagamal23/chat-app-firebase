part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

final class ThemeIsLight extends ThemeState {}

final class ThemeIsDark extends ThemeState {}