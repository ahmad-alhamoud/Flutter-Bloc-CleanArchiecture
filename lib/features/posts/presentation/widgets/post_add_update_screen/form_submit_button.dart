
import 'package:flutter/material.dart';

class FormSubmitButton extends StatelessWidget {
  final void Function() onPressed ;
  final bool isUpdatePost ;

  const FormSubmitButton({Key? key , required this.isUpdatePost , required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
      onPressed: onPressed,
      icon: isUpdatePost ? Icon(Icons.edit) : Icon(Icons.add),
      label: Text(isUpdatePost ? "Update" : "Add"),
    );
  }
}
