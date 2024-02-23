
import 'package:equatable/equatable.dart';

abstract class CreateCategoryState extends Equatable{
  const CreateCategoryState();
  @override
  List<Object> get props=>[];
}


final class CreateCategoryInitial extends CreateCategoryState{}

final class CreateCategoryFailure extends CreateCategoryState{}
final class CreateCategoryLoading extends CreateCategoryState{}
final class CreateCategorySuccess extends CreateCategoryState{}

