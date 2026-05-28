class TVChannel {
  final String id;
  final String name;
  final String logo;
  final String stream;
  final bool live;

  const TVChannel({
    required this.id,
    required this.name,
    required this.logo,
    required this.stream,
    this.live = true,
  });
}
