import 'dart:math' as Math;

class Module {
  final String name;
  double credits; // Weight of this module
  double gradePoint; // 0.0 to 4.0

  Module({required this.name, required this.credits, required this.gradePoint});
}

class CGPACalculator {
  
  // - Returns -1 if the input is invalid
  // - fractionDigits indicates the accuracy of the double gpa.
  double calculateSemesterGPA(List<Module> modules, {int fractionDigits = 2}) {
    if (modules.isEmpty) return -1;

    final totalCredits = modules.fold<double>(0.0, (s, c) => s + c.credits);

    if (totalCredits == 0) return 0.0;

    final totalQualityPoints = modules.fold<double>(
      0.0,
      (s, c) => s + c.gradePoint * c.credits,
    );

    final gpa = totalQualityPoints / totalCredits;
    final mod = Math.pow(10, fractionDigits);

    return (gpa*mod).round() / mod;
  }
}

