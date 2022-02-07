

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/IconBroken.dart';

//MaterialButton
Widget defaultButton({
  double width = double.infinity,
  Color background=Colors.blue,
  bool isUpperCase= true,
  required final Function() function,
  required String text,

})=> Container(
  height: 40.0,
  width: width,
  color: background,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase?text.toUpperCase() : text,
      style: TextStyle(
      color: Colors.white,
    ),
    ),
  ),
);

Widget defaultTextButton({
  required String text,
  required Function() onPressed,
})=>TextButton(
  onPressed: onPressed,
  child: Text(text.toUpperCase()),);

PreferredSizeWidget defaultAppBar({
  required String title,
  List <Widget>? actions,
  required BuildContext context,
}
)=> AppBar(
    leading: IconButton(
    onPressed: (){
    Navigator.pop(context);
    },
      icon: Icon(IconBroken.Arrow___Left_2),
),
title: Text(title),
  actions: actions,
  titleSpacing: 5.0,

);

//suffix icon button
Widget suffixIconBtn ({
  IconData? suffix,
})=>IconButton(
onPressed: () {},
icon: Icon(suffix),

    );



//TextFormField
Widget defaultFormField({
  Function(String value)? onSubmit,
  Function(String value)? onChanged,
  Function()? onTap,
  Function()? suffixPressed,
  required FormFieldValidator<String>? validator,
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  bool isClickable=true,
  bool isPassword=true,
   IconData? suffix,


})=> TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  onTap: onTap,
  validator: validator,
  enabled: isClickable,
  decoration: InputDecoration(
    //or hintText(Second Style)
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix !=null ?
    IconButton(
        onPressed: suffixPressed,
        icon: Icon(suffix,)
    ) :null,
    // suffixIcon:
    // IconButton(
    //   onPressed: (){},
    //   icon: Icon(suffix),
    //   focusColor: Colors.red,
    // ),
    //suffixIcon: suffix !=null ? Icon(suffix,) :null,
    border: OutlineInputBorder(),
  ),
);

Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);



void navigateTo(context,Widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),
);

void navigateAndFinish(context,Widget)=> Navigator.pushAndRemoveUntil
  (
  context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),
    (route){
    return false;
    },
);

void showToast({
  required String message,
  required ToastStates state,
})=> Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor (ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS: color= Colors.green;
    break;
    case ToastStates.ERROR: color= Colors.red;
    break;
    case ToastStates.WARNING: color= Colors.amber;
    break;
  }
  return color;
}


