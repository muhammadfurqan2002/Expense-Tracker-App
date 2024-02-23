
import 'package:expense_repository/expense_repository.dart';
import 'package:bloc/bloc.dart';
import 'create_category_event.dart';
import 'create_category_state.dart';




class CreateCategoryBloc extends Bloc<CreateCategoryEvent, CreateCategoryState> {

  final ExpenseRepository expenseRepository;

  CreateCategoryBloc(this.expenseRepository) : super(CreateCategoryInitial()) {
    on<CreateCategory>((event, emit)async {
      emit(CreateCategoryLoading());
      try{
        await expenseRepository.createCategory(event.category);
        emit(CreateCategorySuccess());
          }catch(e){
              emit(CreateCategoryFailure());
          }
    });
  }
}
