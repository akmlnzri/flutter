import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
  final Map product;

  EditProduct({super.key, required this.product});
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  Future updateProduct() async {
    final response = await http.put(
        Uri.parse(
            "http://10.0.2.2:8000/api/products/" + product['id'].toString()),
        body: {
          "name": _nameController.text,
          "description": _descController.text,
          "price": _priceController.text,
          "image_url": _imageController.text
        });

    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Product"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController..text = product['name'],
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter product name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descController..text = product['description'],
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter product description";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController..text = product['price'],
                decoration: const InputDecoration(labelText: "Price"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter product price";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController..text = product['image_url'],
                decoration: const InputDecoration(labelText: "Image Url"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter image url";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateProduct().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Product Successfully updated")));
                      });
                    }
                  },
                  child: const Text("Update")),
            ],
          ),
        ));
  }
}
