import 'package:flutter/material.dart';
import 'package:warkop_bunny/models/profile.dart';
import 'package:warkop_bunny/services/auth/auth_service.dart';
import 'package:warkop_bunny/services/profile_service.dart';

class ManageAccountPage extends StatefulWidget {
  const ManageAccountPage({super.key});

  @override
  State<ManageAccountPage> createState() => _ManageAccountPageState();
}

class _ManageAccountPageState extends State<ManageAccountPage> {
  final ProfileService _service = ProfileService();
  final AuthService _authService = AuthService();
  List<Profile> profiles = [];
  bool isLoading = true;
  String? _selectedValue = 'user'; // Default selected value for role
  final List<String> _roleItems = ['user', 'admin'];

  @override
  void initState() {
    super.initState();
    fetchProfiles();
  }

  Future<void> fetchProfiles() async {
    setState(() => isLoading = true);
    profiles = await _service.getAll();
    // email = await _authService.getAll();
    setState(() => isLoading = false);
  }

  void showForm({Profile? profile}) {
    final nameController = TextEditingController(text: profile?.name ?? '');
    // final emailController = TextEditingController(text: profile?.email ?? '');
    final roleController = TextEditingController(
      text: profile?.role ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(profile == null ? 'Tambah Akun' : 'Edit Akun'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            // TextField(
            //   controller: emailController,
            //   decoration: const InputDecoration(labelText: 'Email'),
            // ),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: 'Role'),
            ),
            // pilih role
            // DropdownButton<String>(
            //   value: _selectedValue,
            //   items: _roleItems.map((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       _selectedValue = newValue;
            //     });
            //   },
            // ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newProfile = Profile(
                id: profile?.id,
                name: nameController.text,
                phoneNumber: roleController.text,
                // email: emailController.text,
              );

              if (profile == null) {
                await _service.create(newProfile);
              } else {
                await _service.update(newProfile);
              }

              Navigator.pop(context);
              fetchProfiles();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Akun'),
        content: const Text('Yakin ingin menghapus akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _service.delete(id);
              Navigator.pop(context);
              fetchProfiles();
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Akun Pengguna')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final p = profiles[index];
                return ListTile(
                  title: Text(p.name),
                  subtitle: Text(p.role ?? '-'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // IconButton(
                      //   icon: const Icon(Icons.edit),
                      //   onPressed: () => showForm(profile: p),
                      // ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => confirmDelete(p.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => showForm(),
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
