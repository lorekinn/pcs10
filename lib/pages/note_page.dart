import 'package:flutter/material.dart';
import '../models/note.dart';
import '../api/api.dart';

class ProductDetailPage extends StatelessWidget {
  final Sweet sweet;
  final VoidCallback onDelete;
  final ApiService apiService = ApiService();

  ProductDetailPage({super.key, required this.sweet, required this.onDelete});

  final textFont = const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  Future<void> _deleteProduct(BuildContext context) async {
    try {
      await apiService.deleteProduct(sweet.id);
      onDelete();
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при удалении продукта: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          sweet.name,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  sweet.imageUrl,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Описание:',
                      style: textFont.copyWith(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      sweet.description,
                      style: textFont,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildDetailRow('Цена:', '${sweet.price} рублей'),
            _buildDetailRow('Бренд:', sweet.brand),
            _buildDetailRow('Вкус:', sweet.flavor),
            _buildDetailRow('Состав:', sweet.ingredients),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _deleteProduct(context),
                icon: const Icon(Icons.delete),
                label: const Text(
                  'Удалить товар',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: textFont.copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: textFont.copyWith(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
