import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/providers/products_provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

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

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Obavezno polje";
    }
    return null;
  }

  void _saveProduct() {
    if (!_formKey.currentState!.validate()) return;

    final price = double.tryParse(_priceController.text.trim());
    final quantity = int.tryParse(_quantityController.text.trim());

    if (price == null || quantity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cena i kolicina moraju biti brojevi.")),
      );
      return;
    }

    context.read<ProductsProvider>().addProduct(
          title: _titleController.text.trim(),
          price: price,
          category: _categoryController.text.trim(),
          description: _descriptionController.text.trim(),
          image: _imageController.text.trim(),
          quantity: quantity,
        );

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Proizvod je dodat.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dodaj proizvod"),
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
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
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
                decoration: const InputDecoration(labelText: "Kolicina"),
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imageController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Putanja slike (assets)",
                  hintText: "assets/images/nova_slika.jpg",
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
                onPressed: _saveProduct,
                icon: const Icon(Icons.save_outlined),
                label: const Text("Sacuvaj proizvod"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
