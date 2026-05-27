import 'package:flutter/widgets.dart';

class TVScrollPhysics
    extends BouncingScrollPhysics {
  const TVScrollPhysics({
    super.parent,
  });

  @override
  TVScrollPhysics applyTo(
    ScrollPhysics? ancestor,
  ) {
    return TVScrollPhysics(
      parent: buildParent(ancestor),
    );
  }
}
