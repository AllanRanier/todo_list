
import 'package:todo_list/app/core/notifier/default_changer_notifier.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';

class HomeController extends DefaultChangerNotifier{
  final filterSelected = TaskFilterEnum.today;
}