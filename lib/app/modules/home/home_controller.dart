import 'package:todo_list/app/core/notifier/default_changer_notifier.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/models/total_tasks_model.dart';
import 'package:todo_list/app/models/week_task_model.dart';
import 'package:todo_list/app/services/tasks/tasks_service.dart';

class HomeController extends DefaultChangerNotifier {
  final TasksService _tasksService;
  var filterSelected = TaskFilterEnum.today;
  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];

  String tasksEmptyMessage = '';

  HomeController({required TasksService tasksService})
      : _tasksService = tasksService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    todayTotalTasks = TotalTasksModel(
      totalTasks: todayTasks.length,
      totalTasksFinish: todayTasks.where((task) => task.finished).length,
    );

    tomorrowTotalTasks = TotalTasksModel(
      totalTasks: tomorrowTasks.length,
      totalTasksFinish: tomorrowTasks.where((task) => task.finished).length,
    );

    weekTotalTasks = TotalTasksModel(
      totalTasks: weekTasks.task.length,
      totalTasksFinish: weekTasks.task.where((task) => task.finished).length,
    );

    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();

    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();

        if (tasks.isEmpty)
          tasksEmptyMessage = 'Você não possui tarefas para HOJE!';

        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();

        if (tasks.isEmpty)
          tasksEmptyMessage = 'Você não possui tarefas para AMANHÃ!';

        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksService.getWeek();

        tasks = weekModel.task;
        // initialDateOfWeek = weekModel.startDate;

        if (tasks.isEmpty)
          tasksEmptyMessage = 'Você não possui tarefas para SEMANA!';

        break;
    }
    filteredTasks = tasks;
    allTasks = tasks;

    hideLoading();
    notifyListeners();
  }

  Future<void> refreshPage() async{
  await findTasks(filter: filterSelected);
  await loadTotalTasks();

    notifyListeners();
  }
}
