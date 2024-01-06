import 'package:flutter/material.dart';

import '../../../domain/entities/post_entity.dart';
import '../../screens/post_add_update_post_screen.dart';

class UpdatePostButtonWidget extends StatelessWidget {
  final Post post;

  const UpdatePostButtonWidget({Key? key, required this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    PostAddUpdateScreen(post: post, isUpdatePost: true)));
      },
      label: Text('Edit'),
    );
  }
}
