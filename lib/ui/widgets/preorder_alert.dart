import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/utils/constants/constants.dart';

class PreorderAlert extends StatefulWidget {
  final Function(int) preorderQuantity;

  const PreorderAlert({
    super.key,
    required this.preorderQuantity,
  });

  @override
  State<PreorderAlert> createState() => _PreorderAlertState();
}

class _PreorderAlertState extends State<PreorderAlert> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Reserva',
        style: TextStyle(color: customBrown),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Por favor indique la cantidad del producto que desea reservar',
          ),
          Divider(indent: 5.w, endIndent: 5.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _operationIcon(Icons.remove, _decreaseQuantity),
              SizedBox(width: 15.w),
              Text('$quantity'),
              SizedBox(width: 15.w),
              _operationIcon(Icons.add, _increaseQuantity),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.preorderQuantity(quantity);
            Navigator.of(context).pop();
          },
          child: const Text('Reservar'),
        ),
      ],
    );
  }

  Widget _operationIcon(IconData icon, VoidCallback action) {
    return Container(
      decoration: BoxDecoration(
        color: customBrown,
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: action,
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }

  void _increaseQuantity() {
    setState(() => quantity++);
  }

  void _decreaseQuantity() {
    if (quantity > 1) setState(() => quantity--);
  }
}
