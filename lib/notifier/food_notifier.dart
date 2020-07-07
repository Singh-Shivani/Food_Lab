import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:foodlab/api/food_api.dart';
import 'package:foodlab/model/food.dart';

class FoodNotifier with ChangeNotifier {
  List<Food> _foodList = [];
  Food _currentFood;

  UnmodifiableListView<Food> get foodList {
    return UnmodifiableListView(_foodList);
  }

  Food get currentFood {
    return _currentFood;
  }

  set foodList(List<Food> foodList) {
    foodList = _foodList;
    notifyListeners();
  }

  set currentFood(Food food) {
    food = _currentFood;
    notifyListeners();
  }
}
