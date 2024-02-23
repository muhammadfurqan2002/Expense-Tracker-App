import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'create_expense_event.dart';
part 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {

  final ExpenseRepository expenseRepository;
  CreateExpenseBloc(this.expenseRepository) : super(CreateExpenseInitial()) {
    on<CreateExpense>((event, emit)async {
      emit(CreateExpenseLoading());
      try{
        await expenseRepository.createExpense(event.expense);
        emit(CreateExpenseSuccess());
      }catch(e){
        emit(CreateExpenseError());
      }

    });
  }
}
