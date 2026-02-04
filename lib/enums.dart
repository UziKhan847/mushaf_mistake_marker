enum MarkType {
  unknown(0),
  mistake(1),
  oldMistake(2),
  doubt(3),
  tajwid(4);

  const MarkType(this.id);
  final int id;

  static MarkType fromId(int? id) =>
      MarkType.values.firstWhere((e) => e.id == id, orElse: () => .unknown);
}

enum Phase { initial, submitting, success, error }

enum PageLayout { singlePage, dualPage }

enum PageSide { rightSide, leftSide, none }

enum PageChangeOrigin { modeChange, swipe }

enum MarkupMode {
  mark(0),
  highlight(1),
  eraser(2);

  const MarkupMode(this.id);

  final int id;

  static MarkupMode fromId(int? id) =>
      MarkupMode.values.firstWhere((e) => e.id == id, orElse: () => .mark);
}

enum GradientEdge { start, end }
