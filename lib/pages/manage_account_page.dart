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
    final phoneNumberController = TextEditingController(
      text: profile?.phoneNumber ?? '',
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
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: 'Nomor Telepon'),
            ),
            // TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
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
                phoneNumber: phoneNumberController.text,
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
                  subtitle: Text(p.phoneNumber ?? '-'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => showForm(profile: p),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => confirmDelete(p.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
