part of 'create_expense_bloc.dart';

@immutable
abstract class CreateExpenseState {}

class CreateExpenseInitial extends CreateExpenseState {}
class CreateExpenseSuccess extends CreateExpenseState {}
class CreateExpenseLoading extends CreateExpenseState {}
class CreateExpenseError extends CreateExpenseState {}
