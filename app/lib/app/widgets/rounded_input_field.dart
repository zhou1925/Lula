import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_app/app/core/theme/colors.dart';
import 'package:plant_app/app/widgets/text_field_container.dart';


class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final controller;

  const RoundedInputField({
    required this.hintText,
    this.icon = Icons.phone,
    required this.onChanged,
    this.controller,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      
      child: TextFormField(

        validator: (String? value){
          if(value == null || value.trim().isEmpty){
            return 'Campo requerido';
          }
          if(value.length < 10) {
            return 'Minimo 10 caracteres';
          }
          return null;
        },
        controller: controller,
        onChanged: onChanged,
        
        cursorColor: kBlack,
        decoration: InputDecoration(
          fillColor: Colors.blueAccent,
          icon: Icon(
            icon,
            color: Get.theme.primaryColorLight,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}