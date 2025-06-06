enum TaskStatus {
  toDo('To Do'),
  doing('Doing'),
  expired('Expired'),
  done('Done');

  final String name;

  const TaskStatus(this.name);

  static TaskStatus fromString(String input) {
    switch (input) {
      case 'To Do':
        return TaskStatus.toDo;
      case 'Doing':
        return TaskStatus.doing;
      case 'Expired':
        return TaskStatus.expired;
      case 'Done':
        return TaskStatus.done;
      default:
        throw UnsupportedError('Status not supported');
    }
  }
}
