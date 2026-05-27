class TVModule {

  final String id;

  final String route;

  final bool enabled;

  const TVModule({
    required this.id,
    required this.route,
    this.enabled = true,
  });
}
