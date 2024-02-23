import 'package:expense_app/screens/stats/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:intl/intl.dart';
import '../../data/Data.dart';



class StatsScreen extends StatelessWidget {
  final List<Expense> expenses;
  const StatsScreen(this.expenses,{super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:  Column(
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children:[
                         GestureDetector(
                           onTap: (){
                             Navigator.pop(context);
                           },
                           child:  Container(
                             height: 35,
                             width: 35,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               color: Colors.white,
                             ),
                           ),
                         ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Icon(CupertinoIcons.arrow_left_circle,color: Colors.white,)
                        ]
                      ),
                      const SizedBox(width: 20,),
                      const Text("Transactions",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Row(
                    children: [
                      Stack(
                          alignment: Alignment.center,
                          children:[
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            Icon(Icons.settings_outlined,color: Colors.white,)
                          ]
                      ),
                    ],
                  )
                ],
              ),
                const SizedBox(height: 20,),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child:Column(
                  children: [
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("01 Jan 2021",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.outline
                      ),),
                      Text("-01 April 2021",style: TextStyle(
                      fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.outline
                  ),),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Text("\$3500.00",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.onBackground
                  ),),
                   const SizedBox(height: 10,),
                   const SizedBox(
                      height: 200,
                      child: MyChart(),
                    )
                              ],
                            ),
                  ),
                const SizedBox(height: 20,)
                ,Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Sat, 20 March 2021",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.outline),),
                    GestureDetector(
                      onTap: (){},
                      child: Text("View All",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.outline),),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Expanded(
                  child: ListView.builder(
                    itemCount:expenses.length,
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
                                        Image.asset(expenses[index].category.icon,scale: 2,)
                                      ],
                                    ),
                                    const SizedBox(width: 10,),
                                    Text(expenses[index].category.name.toString(),style: TextStyle(
                                        fontSize: 14,
                                        fontWeight:FontWeight.w500,
                                        color: Theme.of(context).colorScheme.onBackground
                                    ),),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('\$${expenses[index].amount.toString()}.00',style: TextStyle(
                                        fontSize: 14,
                                        fontWeight:FontWeight.w500,
                                        color: Theme.of(context).colorScheme.onBackground
                                    ),),
                                    Text(DateFormat("dd/MM/yyyy").format(expenses[index].date),style: TextStyle(
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
          ),
        ),
    );
  }
}
