import 'dart:math';

import 'package:expense_app/screens/add_expense/views/add_expense.dart';
import 'package:expense_app/screens/home/blocs/get_expense_bloc.dart';
import 'package:expense_app/screens/home/views/main_screen.dart';
import 'package:expense_app/screens/stats/Stats.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color selected=Colors.blue;
  Color unSelected=Colors.grey;
  int index=0;

  @override
  void initState() {
    BlocProvider.of<GetExpenseBloc>(context).add(GetExpenses());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpenseBloc, GetExpenseState>(
  builder: (context, state) {
   if(state is GetExpenseSuccess){
     return Scaffold(
       bottomNavigationBar:ClipRRect(
         borderRadius:const BorderRadius.vertical(
           top: Radius.circular(30),
         ),
         child: BottomNavigationBar(
           onTap: (value){
             setState(() {
               index=value;
             });
           },
           backgroundColor: Colors.white,
           showSelectedLabels: false,
           showUnselectedLabels: false,
           elevation: 3,

           items:[
             BottomNavigationBarItem(
                 label: 'Home',
                 icon: Icon(CupertinoIcons.home,
                   color: index==0?selected:unSelected,
                 )),
             BottomNavigationBarItem(

                 label: 'Stats',
                 icon:IconButton(
                   onPressed: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>StatsScreen(state.expenses)));

                   },
                   icon:Icon(CupertinoIcons.graph_square_fill,
                     color: index==1?selected:unSelected,
                   ) ,
                 )),



           ],
         ),
       ),
       floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
       floatingActionButton: FloatingActionButton(

         shape: const CircleBorder(),
         onPressed: ()async{
            Expense? newExpense=await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddExpense()));

            setState(() {
              if(newExpense!=null){
                state.expenses.insert(0, newExpense);
              }
            });
            },
         child:Container(
             width: 60,
             height: 60,
             decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 gradient: LinearGradient(
                     colors:[
                       Theme.of(context).colorScheme.tertiary,
                       Theme.of(context).colorScheme.secondary,
                       Theme.of(context).colorScheme.primary,
                     ],
                     transform:const GradientRotation(pi/4)
                 )
             ),
             child: const Icon(CupertinoIcons.add)) ,),
       body:MainScreen(state.expenses),
     );
   }else{
     return const Scaffold(
       body: Center(child: CircularProgressIndicator(),),
     );
   }
  },
);
  }
}
