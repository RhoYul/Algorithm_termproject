import 'package:flutter/material.dart';
import 'package:term_project/settings_category/Subject.dart';

class SubjectCategoryProvider with ChangeNotifier {
  List<Subject> _subjectCategories = [];
  List<String> _generalCategories = [];

  List<Subject> get subjectCategories => _subjectCategories;
  List<String> get generalCategories => _generalCategories;

  void addSubjectCategory(Subject subject) {
    _subjectCategories.add(subject);
    notifyListeners();
  }

  void addGeneralCategory(String category) {
    _generalCategories.add(category);
    notifyListeners();
  }
}
