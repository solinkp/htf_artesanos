import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/domain/todo/todo.dart';
import 'package:htf_artesanos/ui/widgets/custom_loader.dart';
import 'package:htf_artesanos/services/api/api_artisan_service.dart';
import 'package:htf_artesanos/ui/art_pending/widgets/todo_item.dart';

class ArtPendingPage extends StatefulWidget {
  const ArtPendingPage({super.key});

  @override
  State<ArtPendingPage> createState() => _ArtPendingPageState();
}

class _ArtPendingPageState extends State<ArtPendingPage> {
  List<Todo> _todos = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    setState(() {
      _isLoading = true;
    });
    final data = await ApiArtisanService.instance.getArtisanTodos();
    setState(() {
      _todos = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CustomLoader(
              size: SpinnerSize.normal,
            ),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _todos.length,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return TodoItem(todo: _todos[index], completeTodo: _completeTodo);
            },
          );
  }

  void _completeTodo(int todoId) {
    _todos.removeWhere((element) => element.id == todoId);
    setState(() {});
  }
}
