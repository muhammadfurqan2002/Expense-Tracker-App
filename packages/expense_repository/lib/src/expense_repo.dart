import 'package:expense_repository/src/models/category.dart';

import '../expense_repository.dart';



abstract class ExpenseRepository {

  Future<void> createCategory(Category category);
  Future<void> createExpense(Expense expense);

  Future<List<Category>> getCategory();
  Future<List<Expense>> getExpense();

}