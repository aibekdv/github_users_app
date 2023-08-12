part of 'language_cubit.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

final class ChangeLanguage extends LanguageState {
  final Locale locale;

  ChangeLanguage({required this.locale});
}
