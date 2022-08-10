import 'package:flutter/material.dart';


class TodoListUiConfig {
  TodoListUiConfig._();

  static ThemeData get theme => ThemeData(
        primaryColor: Color(0xff5C77CE),
        primaryColorLight: Color(0xffABCBF7),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Color(0xff5C77CE)),
        ),
      );
}
