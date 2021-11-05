class CustomDrawerController {

  int _currentIndex = -1;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int newIndex) {
    _currentIndex = newIndex;
  }

  static const cursosIndex = 1;
  static const disciplinaIndex = 2;
  static const tarefasIndex = 3;
}