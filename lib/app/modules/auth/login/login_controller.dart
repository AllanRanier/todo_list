import 'package:todo_list/app/core/notifier/default_changer_notifier.dart';
import 'package:todo_list/app/exception/auth_exception.dart';

import 'package:todo_list/app/services/user/user_service.dart';

class LoginController extends DefaultChangerNotifier {
  final UserService _userService;

  LoginController({
    required UserService userService,
  }) : _userService = userService;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError("Usuário ou senha inválido");
      }
    } on AuthException catch (e) {
      setError(e.message);
    }finally{
      hideLoading();
      notifyListeners();
    }
  }
}
