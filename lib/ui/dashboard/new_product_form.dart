import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';

import 'package:htf_artesanos/utils/custom_snackbar.dart';
import 'package:htf_artesanos/domain/product/create_product_dto.dart';
import 'package:htf_artesanos/services/api/api_artisan_service.dart';
import 'package:htf_artesanos/ui/widgets/custom_text_form_field.dart';
import 'package:htf_artesanos/utils/extensions/string_extensions.dart';

class NewProductForm extends StatefulWidget {
  const NewProductForm({super.key});

  @override
  State<NewProductForm> createState() => _NewProductFormState();
}

class _NewProductFormState extends State<NewProductForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _discountController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _discountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Nuevo Producto',
        style: TextStyle(color: customBrown),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                keyboardType: TextInputType.text,
                hintText: 'Título',
                textController: _titleController,
                icon: Icons.title,
                validator: (value) => value!.validateEmpty(context),
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                keyboardType: TextInputType.text,
                hintText: 'Descripción',
                textController: _descriptionController,
                icon: Icons.description,
                validator: (value) => value!.validateEmpty(context),
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                hintText: 'Precio',
                textController: _priceController,
                icon: Icons.price_change,
                isNumber: true,
                validator: (value) => value!.validateEmpty(context),
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                hintText: 'Descuento',
                textController: _discountController,
                icon: Icons.discount,
                isNumber: true,
                validator: (value) => value!.validateEmpty(context),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              var newProd = CreateProductDTO(
                title: _titleController.text.trim(),
                description: _descriptionController.text.trim(),
                price: double.parse(_priceController.text.trim()),
                discountPercentage:
                    double.parse(_discountController.text.trim()),
              );
              var response = await ApiArtisanService.instance
                  .createArtisanProduct(newProd);
              if (response) {
                showMsnSnackbar('Producto creado exitosamente');
                if (mounted) Navigator.of(context).pop();
              }
            }
          },
          child: const Text('Crear'),
        ),
      ],
    );
  }
}
