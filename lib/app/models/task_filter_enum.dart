enum TaskFilterEnum {
  today('DE HOJE'),
  tomorrow('DE AMANHÃ'),
  week('DA SEMANA');

  final String value;

  const TaskFilterEnum(this.value);
}

// extension TaskFilterDescription on TaskFilterEnum {
//   String get description {
//     switch (this) {
//       case TaskFilterEnum.today:
//        return 'DE HOJE';
//       case TaskFilterEnum.tomorrow:
//         return 'DE AMANHÃ';
//       case TaskFilterEnum.week:
//         return 'DA SEMANA';
//     }
//   }
// }
