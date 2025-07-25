import 'dart:ui';

extension PathExtension on Path {
  Path fromJson(List<dynamic> json) {
    for (final Map<String, dynamic> e in json) {
      final cmdType = e['c'];
      final vals = e['v'];

      if (cmdType is! String) {
        throw FormatException('Expected ct to be String, got $cmdType');
      }
      if (cmdType.isNotEmpty) {
        if (vals is! List<double> && vals.length < 2) {
          throw FormatException(
            'Expected v to be List<double> of length ≥2, got $vals',
          );
        }
      }

      switch (cmdType) {
        case 'mT':
          moveTo(vals[0], vals[1]);
        case 'rMT':
          relativeMoveTo(vals[0], vals[1]);
        case 'lT':
          lineTo(vals[0], vals[1]);
        case 'rLT':
          relativeLineTo(vals[0], vals[1]);
        case 'cT':
          cubicTo(vals[0], vals[1], vals[2], vals[3], vals[4], vals[5]);
        case 'rCT':
          relativeCubicTo(vals[0], vals[1], vals[2], vals[3], vals[4], vals[5]);
        case 'qBT':
          quadraticBezierTo(vals[0], vals[1], vals[2], vals[3]);
        case 'rQBT':
          relativeQuadraticBezierTo(vals[0], vals[1], vals[2], vals[3]);
        case 'aTP':
          final rE = e['rE'] as List<double>;
          final rot = e['rot'] as double;
          final lA = e['lA'] as bool;
          final cW = e['cW'] as bool;
          arcToPoint(
            Offset(vals[0], vals[1]),
            radius: Radius.elliptical(rE[0], rE[1]),
            rotation: rot,
            largeArc: lA,
            clockwise: cW,
          );
        case 'rATP':
          final rE = e['rE'] as List<double>;
          final rot = e['rot'] as double;
          final lA = e['lA'] as bool;
          final cW = e['cW'] as bool;
          relativeArcToPoint(
            Offset(vals[0], vals[1]),
            radius: Radius.elliptical(rE[0], rE[1]),
            rotation: rot,
            largeArc: lA,
            clockwise: cW,
          );
        case '':
          close();
        default:
          throw ArgumentError('Unknown Path command: $cmdType');
      }
    }

    return this;
  }
}
