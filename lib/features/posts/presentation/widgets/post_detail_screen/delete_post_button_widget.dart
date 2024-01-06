import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../core/utils/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../screens/posts_screen.dart';
import 'delete_dialog_widget.dart';

class DeletePostButtonWidget extends StatelessWidget {
  final int postId;
  const DeletePostButtonWidget({Key? key , required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.delete_outline),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context),
      label: Text('Delete'),
    );
  }

  Future deleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostBloc,
              AddDeleteUpdatePostState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => PostsScreen()), (
                    route) => false) ;
              }
              else if ( state is ErrorAddDeleteUpdatePostState) {
                SnackBarMessage().showErrorSnackBar(message: state.message, context: context) ;
                Navigator.of(context).pop() ;
              }
            },
            builder: (context, state) {
              if ( state is LoadingAddDeleteUpdatePostState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: postId );
            },
          );
        });
  }
}
