import 'package:expense_repository/expense_repository.dart';
import 'package:equatable/equatable.dart';


abstract class CreateCategoryEvent extends Equatable {
  const CreateCategoryEvent();
  @override
  List<Object> get props=>[];
}


class CreateCategory extends CreateCategoryEvent {
  final Category category;
  const CreateCategory(this.category);
  @override
  List<Object> get props=>[category];
}


