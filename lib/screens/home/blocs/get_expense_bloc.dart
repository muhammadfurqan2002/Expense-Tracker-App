import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'get_expense_event.dart';
part 'get_expense_state.dart';

class GetExpenseBloc extends Bloc<GetExpenseEvent, GetExpenseState> {
    final ExpenseRepository expenseRepository;
  GetExpenseBloc(this.expenseRepository) : super(GetExpenseInitial()) {
    on<GetExpenseEvent>((event, emit)async {
      emit(GetExpenseLoad());
      try{
        List<Expense> expenses=await expenseRepository.getExpense();
        emit(GetExpenseSuccess(expenses));
      }catch(e){
        emit(GetExpenseFailure());
      }
    });
  }
}
