class TVTask {

  final String id;

  final Future<void>
      Function() action;

  const TVTask({
    required this.id,
    required this.action,
  });
}
