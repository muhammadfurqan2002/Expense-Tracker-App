import 'package:flutter/cupertino.dart';
import 'package:expense_app/screens/add_expense/expense_bloc/create_category_bloc/create_category_bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';
import '../expense_bloc/create_category_bloc/create_category_event.dart';
import '../expense_bloc/create_category_bloc/create_category_state.dart';


Future categorySection (BuildContext context){
  List<String> myIcons=[
    "entertainment",
    "food",
    "home",
    "pet",
    "shopping",
    "tech",
    "travel",
  ];


  return  showDialog(context: context, builder:(ctx){
    bool isTrue=false;
    bool isLoading=false;
    String selectedIcon="";
    Color selectedColor=Colors.white;
    Category category=Category.empty;
    TextEditingController categoryName=TextEditingController();
    
    return BlocProvider.value(
        value: context.read<CreateCategoryBloc>(),
  child: StatefulBuilder(
    builder: (ctx, setState) {
      return BlocListener<CreateCategoryBloc, CreateCategoryState>(
      listener: (context, state) {
        if(state is CreateCategorySuccess){
          Navigator.pop(ctx,category);
        }else if(state is CreateCategoryLoading){
          setState((){
            isLoading=true;
          });
        }
      },
      child: AlertDialog(
          title:const Center(child:  Text("Category Section")),
          content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: categoryName,
                      textAlignVertical: TextAlignVertical
                          .center,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Name",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius
                                .circular(12),
                            borderSide: BorderSide.none
                        ),

                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      onTap: () {
                        setState(() {
                          isTrue = !isTrue;
                        });
                      },
                      readOnly: true,
                      textAlignVertical: TextAlignVertical
                          .center,
                      decoration:  InputDecoration(
                        filled: true,
                        hintText: "Icon",
                        fillColor: Colors.white,
                        suffixIcon:const Icon(Icons
                            .arrow_drop_down_outlined,
                          size: 22,),
                        border: OutlineInputBorder(
                            borderRadius:!isTrue?BorderRadius.circular(12):
                            const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            borderSide: BorderSide.none
                        ),
                      ),
                    ),
                    !isTrue ? Container() : Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 200,
                      decoration: const BoxDecoration(
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 3
                            ),
                            itemCount:myIcons.length ,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                  setState((){
                                    // if(selectedIcon==""){
                                    selectedIcon='assets/${myIcons[index]}.png';
                                    // }else{
                                    //   selectedIcon="";
                                    // }

                                  });
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color:
                                      selectedIcon=='assets/${myIcons[index]}.png'?Colors.red:Colors.white ,
                                      borderRadius: BorderRadius.circular(5),
                                      border:Border.all(
                                        width: 2,
                                      )
                                  ),
                                  child: Image(
                                    image: AssetImage('assets/${myIcons[index]}.png'),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(

                      onTap: (){
                        showDialog(context:  context,
                            builder:(ctx_2){
                              return AlertDialog(
                                content:Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ColorPicker(
                                      pickerColor: Colors.red,
                                      onColorChanged: (value){
                                        setState((){
                                          selectedColor=value;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: Colors.black,
                                              shape:RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12)
                                              )
                                          ),
                                          onPressed: (){
                                            Navigator.pop(ctx_2);
                                          },
                                          child:const Text("Save Color",
                                            style: TextStyle(
                                                fontSize: 22,color: Colors.white
                                            ),
                                          )),
                                    )
                                  ],
                                ) ,
                              );
                            });

                      },
                      readOnly: true,
                      textAlignVertical: TextAlignVertical
                          .center,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Color",
                        fillColor: selectedColor,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius
                                .circular(12),
                            borderSide: BorderSide.none
                        ),

                      ),
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                      width: double.infinity,
                      height:kToolbarHeight,
                      child:isLoading==true?const Center(child: CircularProgressIndicator(),):
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape:RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              )
                          ),
                          onPressed: (){

                            category.categoryId=const Uuid().v1();
                            category.name=categoryName.text;
                            category.icon=selectedIcon;
                            category.color=selectedColor.value;

                            context.read<CreateCategoryBloc>().add(CreateCategory(category));
                            }, child:const Text("Save",
                        style: TextStyle(
                            fontSize: 22,color: Colors.white
                        ),
                      )),
                    ),
                  ],
                ),
            ),
          ),
      );
    }
  ),
);
  });
}




class PickColor extends StatefulWidget {
  const PickColor({super.key});

  @override
  State<PickColor> createState() => _PickColorState();
}

class _PickColorState extends State<PickColor> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
