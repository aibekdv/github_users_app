part of 'lang_cubit.dart';

sealed class LangState extends Equatable {
  const LangState();

  @override
  List<Object> get props => [];
}

final class LangInitial extends LangState {}

final class ChangeLanguage extends LangState {
  final Locale locale;

  const ChangeLanguage({required this.locale});
}
