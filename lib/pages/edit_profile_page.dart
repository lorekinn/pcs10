import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String fullName;
  final String phone;
  final String avatarUrl;
  final Function(String, String, String) onSave;

  const EditProfilePage({
    super.key,
    required this.fullName,
    required this.phone,
    required this.avatarUrl,
    required this.onSave,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  late TextEditingController _avatarUrlController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.fullName);
    _phoneController = TextEditingController(text: widget.phone);
    _avatarUrlController = TextEditingController(text: widget.avatarUrl);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Редактировать профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'ФИО'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Номер телефона'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _avatarUrlController,
                decoration: const InputDecoration(labelText: 'Ссылка на аватар'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  widget.onSave(
                    _fullNameController.text,
                    _phoneController.text,
                    _avatarUrlController.text,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
