

import 'dart:math';

import 'package:expense_app/screens/add_expense/expense_bloc/create_Expense/create_expense_bloc.dart';
import 'package:expense_app/screens/add_expense/expense_bloc/get_category_bloc/get_category_bloc.dart';
  import 'package:expense_app/screens/add_expense/views/category_section.dart';
import 'package:expense_repository/expense_repository.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


  class AddExpense extends StatefulWidget {
    const AddExpense({super.key});

    @override
    State<AddExpense> createState() => _AddExpenseState();
  }

  class _AddExpenseState extends State<AddExpense> {

    late Expense expense;


    TextEditingController  expenseController=TextEditingController();
    TextEditingController  cateController=TextEditingController();
    TextEditingController  dateController=TextEditingController();




    @override
    void initState() {
      // TODO: implement initState
      BlocProvider.of<GetCategoriesBloc>(context).add(GetCategories());
      dateController.text= DateFormat('dd/MM/yyyy').format(DateTime.now())  ;
      expense=Expense.empty;
      expense.expenseId=const Uuid().v1();
      super.initState();
    }
    @override
    Widget build(BuildContext context) {
      return  BlocListener<CreateExpenseBloc, CreateExpenseState>(
              listener: (context, state) {
                if(state is CreateExpenseSuccess){
                  Navigator.pop(context,expense);
                }
        },
        child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: Padding(
            padding:const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                builder: (context, state) {
                  if(state is GetCategoriesSuccess){
                   return Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       const Text("Add Expense",
                         style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,),
                       ),
                       const SizedBox(height: 16,),
                       SizedBox(
                         width: MediaQuery.of(context).size.width*0.7,
                         child: TextFormField(
                           controller: expenseController,
                           textAlignVertical: TextAlignVertical.center,
                           decoration: InputDecoration(
                             filled: true,
                             fillColor: Colors.white,
                             prefixIcon:const Icon(FontAwesomeIcons.dollarSign,size: 17,
                               color: Colors.grey,
                             ),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(30),
                                 borderSide: BorderSide.none
                             ),

                           ),
                         ),
                       ),
                       const SizedBox(height: 16,),
                       TextFormField(
                         // onTap: (){
                         //
                         // },
                         readOnly: true,
                         controller: cateController,
                         textAlignVertical: TextAlignVertical.center,
                         decoration: InputDecoration(
                           filled: true,
                           fillColor:expense.category==Category.empty?Colors.white:Color(expense.category.color),
                           prefixIcon:expense.category==Category.empty?const Icon(FontAwesomeIcons.list,size: 16,
                             color: Colors.grey,
                           ):Image.asset(expense.category.icon,scale: 2,color: Colors.white,),suffixIcon:IconButton(
                           onPressed: ()async{
                              var cat=await categorySection(context);
                              setState(() {
                                  state.categories.insert(0,cat);

                              });
                           },
                           icon:const Icon(FontAwesomeIcons.plus,size: 16,
                             color: Colors.grey,
                           ),
                         ),

                           hintText:"Category",
                           border:const OutlineInputBorder(
                               borderRadius: BorderRadius.vertical(top:Radius.circular(12)),
                               borderSide: BorderSide.none
                           ),

                         ),
                       ),
                       Container(
                           height: 200,
                           width: MediaQuery.of(context).size.width,
                           decoration:const BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.vertical(bottom: Radius.circular(12))
                           ),
                           child: ListView.builder(
                             itemCount: state.categories.length,
                             itemBuilder: (context, index) {
                               return Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Card(
                                   child: ListTile(
                                     onTap: (){
                                       setState(() {
                                         expense.category=state.categories[index];
                                         cateController.text=expense.category.name;
                                       });
                                     },
                                     title: Text(state.categories[index].name.toString(),style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                                     leading: Image.asset('${state.categories[index].icon}',color: Colors.white, scale: 2),
                                     tileColor:Color(state.categories[index].color),
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(8),
                                     ),
                                   ),
                                 ),
                               );
                             },
                           )
                       ),
                       const SizedBox(height: 16,),
                       TextFormField(
                         onTap: ()async{
                           DateTime? newDate=await showDatePicker(context: context,
                               initialDate:expense.date ,
                               firstDate:DateTime.now(),
                               lastDate: DateTime.now().add(Duration(days: 365)));
                           if(newDate!=null){
                             setState(() {
                               dateController.text= DateFormat('dd/MM/yyyy').format(newDate)  ;
                               // selectedDate=newDate;
                              expense.date=newDate;
                             });
                           }
                         },
                         controller: dateController,
                         readOnly: true,
                         textAlignVertical: TextAlignVertical.center,
                         decoration: InputDecoration(
                           filled: true,
                           fillColor: Colors.white,
                           prefixIcon:const Icon(FontAwesomeIcons.clock,size: 17,
                             color: Colors.grey,
                           ),
                           hintText: "Date",
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(12),
                               borderSide: BorderSide.none
                           ),

                         ),
                       ),
                       const SizedBox(height: 40,),
                       Container(
                         width: double.infinity,
                         height:kToolbarHeight,
                         decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                           gradient: LinearGradient(
                             colors: [
                               Theme.of(context).colorScheme.tertiary,
                               Theme.of(context).colorScheme.secondary,
                               Theme.of(context).colorScheme.primary,
                             ],
                             transform:const GradientRotation(pi/4)
                           )
                         ),
                         child: TextButton(
                             style: TextButton.styleFrom(

                             ),
                             onPressed: (){
                              setState(() {
                                expense.amount=int.parse(expenseController.text);
                              });
                              context.read<CreateExpenseBloc>().add(CreateExpense(expense));
                             }, child:const Text("Save",
                           style: TextStyle(
                               fontSize: 22,color: Colors.white
                           ),
                         )),
                       ),
                     ],
                   );
                 }else{
                    return const Padding(
                      padding:  EdgeInsets.only(top: 250),
                      child: Center(child: CircularProgressIndicator(),),
                    );
                  }
              },
            ),
            ),
          ),

        ),
      ),
);
    }
  }


