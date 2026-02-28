import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/models/product_model.dart';
import 'package:projekatmobilne/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _priceController;
  late final TextEditingController _categoryController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _imageController;
  late final TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product.productTitle);
    _priceController = TextEditingController(
      text: widget.product.productPrice.toStringAsFixed(0),
    );
    _categoryController = TextEditingController(
      text: widget.product.productCategory,
    );
    _descriptionController = TextEditingController(
      text: widget.product.productDescription,
    );
    _imageController = TextEditingController(text: widget.product.productImage);
    _quantityController = TextEditingController(
      text: widget.product.productQuantity.toString(),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) return;

    final price = double.tryParse(_priceController.text.trim());
    final quantity = int.tryParse(_quantityController.text.trim());

    if (price == null || quantity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cena i količina moraju biti brojevi.")),
      );
      return;
    }

    context.read<ProductsProvider>().updateProduct(
          productId: widget.product.productId,
          title: _titleController.text.trim(),
          price: price,
          category: _categoryController.text.trim(),
          description: _descriptionController.text.trim(),
          image: _imageController.text.trim(),
          quantity: quantity,
        );

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Proizvod je izmenjen.")),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Obavezno polje";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Izmeni proizvod"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: "Naziv"),
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: "Cena"),
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _categoryController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: "Kategorija"),
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: "Količina"),
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imageController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Putanja slike (assets)",
                ),
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(labelText: "Opis"),
                validator: _required,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _saveChanges,
                icon: const Icon(Icons.save_outlined),
                label: const Text("Sačuvaj izmene"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
