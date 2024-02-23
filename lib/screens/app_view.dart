import 'package:expense_app/screens/add_expense/expense_bloc/create_Expense/create_expense_bloc.dart';
import 'package:expense_app/screens/add_expense/expense_bloc/create_category_bloc/create_category_bloc.dart';
import 'package:expense_app/screens/home/blocs/get_expense_bloc.dart';
import 'package:expense_app/screens/home/views/home_screen.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_expense/expense_bloc/get_category_bloc/get_category_bloc.dart';




class MyAppView extends StatelessWidget {
   const MyAppView({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=>CreateCategoryBloc(FirebaseExpenseRepo())),
          BlocProvider(create: (_)=>GetCategoriesBloc(FirebaseExpenseRepo()..getCategory())),
          BlocProvider(create: (_)=>CreateExpenseBloc(FirebaseExpenseRepo())),
          BlocProvider(create: (_)=>GetExpenseBloc(FirebaseExpenseRepo()..getExpense()))

        ],

        child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
          colorScheme: ColorScheme.light(
            background: Colors.grey.shade100,
            onBackground: Colors.black,
            primary: Color(0xFF00B2E7),
            secondary: Color(0xFFE064F7),
            tertiary: Color(0xFFFF8D6C),
            outline: Colors.grey,
          )
      ),
      home: HomeScreen(),
    ));
  }
}
