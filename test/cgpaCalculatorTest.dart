import 'package:ap_sara/cgpaCalculator.dart';

void main() {
  print("======= CGPA Calculator Test =======");
  
  List<Module> modules = [
    Module(name: "Math", credits: 4, gradePoint: 3.9),
    Module(name: "History", credits: 4, gradePoint: 2.0),
    Module(name: "Geography", credits: 4, gradePoint: 3.15),
  ];

  CGPACalculator calc = CGPACalculator();

  final semGPA = calc.calculateSemesterGPA(modules, fractionDigits: 3);
  print("Semester GPA = $semGPA");

}
