import 'dart:math';

import 'package:expense_app/data/Data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:intl/intl.dart';



class MainScreen extends StatelessWidget {
  final List<Expense> expenses;
  const MainScreen(this.expenses,{super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape:BoxShape.circle,
                              color: Colors.yellow[700]
                          ),
                        ),
                        Icon(CupertinoIcons.person_fill,
                            color: Colors.yellow[800]
                        ),
                      ],
                    ),
                    const SizedBox(width: 8,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Welcome!",style: TextStyle(fontSize: 12,fontWeight:FontWeight.w600,
                        color: Theme.of(context).colorScheme.outline
                        ),),
                        Text("Furqan",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w600,
                            color: Theme.of(context).colorScheme.outline
                        ),),
                      ],
                    ),
                  ],
                ),
                Row(children: [
                  IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.settings))
                ],)
              ],
            ),
            const SizedBox(height: 20,),
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height/3.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                    transform:const GradientRotation(pi/4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.grey.shade300,
                      offset: Offset(5, 5)
                    )
                  ],
                  borderRadius: BorderRadius.circular(20)
                ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                      const Text("Total Balance",
                      style: TextStyle(fontSize: 17,color: Colors.white,
                      fontWeight: FontWeight.w600
                      ),),
                      const SizedBox(height: 14,),
                      const Text("\$ 4800.0",
                        style: TextStyle(fontSize: 40,color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 25,width: 25,
                              decoration: const BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle,
                              ),
                              child:const Center(child: Icon(CupertinoIcons.arrow_down,size: 17,color: Colors.greenAccent,),),
                            ),
                            const SizedBox(width: 10,),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Income",
                                  style: TextStyle(fontSize: 15,color: Colors.white,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Text("\$ 2800.0",
                                  style: TextStyle(fontSize: 15,color: Colors.white,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 25,width: 25,
                              decoration: const BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle,
                              ),
                              child:const Center(child: Icon(CupertinoIcons.arrow_down,size: 17,color: Colors.greenAccent,),),
                            ),
                            const SizedBox(width: 10,),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Expenses",
                                  style: TextStyle(fontSize: 15,color: Colors.white,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Text("\$ 2800.0",
                                  style: TextStyle(fontSize: 15,color: Colors.white,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
              ],),
              ),
            const SizedBox(height: 40,)
            ,Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text("Transactions",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,
                     color: Theme.of(context).colorScheme.onBackground),),
                 GestureDetector(
                   onTap: (){},
                   child: Text("View All",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,
                       color: Theme.of(context).colorScheme.outline),),
                 ),
               ],
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration:BoxDecoration(
                                          color: Color(expenses[index].category.color),
                                          shape:BoxShape.circle
                                      ),
                                    ),
                                    Image.asset(expenses[index].category.icon,color: Colors.white,scale: 2,),
                                  ],
                                ),
                                const SizedBox(width: 10,),
                                 Text(expenses[index].category.name,style: TextStyle(
                                  fontSize: 14,
                                    fontWeight:FontWeight.w500,
                                    color: Theme.of(context).colorScheme.onBackground
                                ),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                    Text('\$${expenses[index].amount}.00',style: TextStyle(
                            fontSize: 14,
                            fontWeight:FontWeight.w500,
                                        color: Theme.of(context).colorScheme.onBackground
                            ),),
                            Text(DateFormat('dd/MM/yyyy').format(expenses[index].date),style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:FontWeight.w400,
                                        color: Theme.of(context).colorScheme.outline
                                    ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              
              ),
            )
          ],

        ),
      )
    );
  }
}
