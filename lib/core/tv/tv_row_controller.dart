import 'package:flutter/material.dart';
import 'tv_navigation_controller.dart';

class TVRowController {

  final String sectionId;

  final ScrollController scrollController;

  int focusedIndex = 0;

  TVRowController({
    required this.sectionId,
  }) : scrollController =
            TVNavigationController.scroll(
          sectionId,
        );

  // =========================
  // SET FOCUS
  // =========================

  void setFocus(
    int index,
  ) {
    focusedIndex = index;

    TVNavigationController.saveIndex(
      section: sectionId,
      index: index,
    );

    TVNavigationController.autoScroll(
      controller: scrollController,
      index: index,
    );
  }

  // =========================
  // RESTORE
  // =========================

  void restore() {
    focusedIndex =
        TVNavigationController
            .getLastIndex(
      sectionId,
    );

    TVNavigationController.autoScroll(
      controller: scrollController,
      index: focusedIndex,
    );
  }

  // =========================
  // NEXT
  // =========================

  void next(
    int max,
  ) {
    if (focusedIndex < max - 1) {
      setFocus(
        focusedIndex + 1,
      );
    }
  }

  // =========================
  // PREV
  // =========================

  void previous() {
    if (focusedIndex > 0) {
      setFocus(
        focusedIndex - 1,
      );
    }
  }
}
