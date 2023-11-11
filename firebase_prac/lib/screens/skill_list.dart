

class Listing {

  List<Map> _categories = [
    {"name": "Math", "isChecked": false},
    {"name": "Physics", "isChecked": false},
    {"name": "Algorithms", "isChecked": false},
    {"name": "Football", "isChecked": false},
    {"name": "Cooking ", "isChecked": false},
    {"name": "Painting ", "isChecked": false},
  ];

  List<Map> get categories => _categories;

  set categories(List<Map> value) {
    _categories = value;
  }

  List<Map> _selectedCategories = [];

  List<Map> get selectedCategories => _selectedCategories;

  set selectedCategories(List<Map> value) {
    _selectedCategories = value;
  }
}