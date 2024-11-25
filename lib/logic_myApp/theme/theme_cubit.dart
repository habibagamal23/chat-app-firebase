import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/sharedprefrance/shared_pref_helper.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()){
    getThemeFromShared();
  }
  bool isDark= false;
  Future getThemeFromShared() async {
   isDark= SharedPrefsHelper.getTheme();
    if (isDark) {
      emit(ThemeIsDark());
    } else {
      emit(ThemeIsLight());
    }
  }

  Future ToggleTheme() async {
    if (state is ThemeIsDark) {
      emit(ThemeIsLight());
      await SharedPrefsHelper.setTheme(false);
    } else {
      emit(ThemeIsDark());
      await SharedPrefsHelper.setTheme(true);
    }
  }
}
