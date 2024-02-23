part of 'get_expense_bloc.dart';

@immutable
abstract class GetExpenseState {}

class GetExpenseInitial extends GetExpenseState {}
class GetExpenseFailure extends GetExpenseState {}
class GetExpenseLoad extends GetExpenseState {}
class GetExpenseSuccess extends GetExpenseState {

  final List<Expense> expenses;

  GetExpenseSuccess(this.expenses);

  @override
  List<Object>get props=>[expenses];
}
