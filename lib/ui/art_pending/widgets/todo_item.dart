import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/domain/todo/todo.dart';
import 'package:htf_artesanos/utils/custom_snackbar.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';
import 'package:htf_artesanos/services/api/api_artisan_service.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(int) completeTodo;

  const TodoItem({super.key, required this.todo, required this.completeTodo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: customMossGreen),
        ),
        tileColor: customSageGreen,
        leading: const Icon(Icons.pending_actions_sharp),
        title: Text(todo.todo),
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Reserva #${todo.id}',
                style: const TextStyle(color: customBrown),
              ),
              content: const Text('¿Desea marcar esta reserva como lista?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var response = await ApiArtisanService.instance
                        .updateArtisanTodo(todo.id);
                    if (response) {
                      showMsnSnackbar('Reserva marcada como lista');
                      completeTodo(todo.id);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Completar'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
