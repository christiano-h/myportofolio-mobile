import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/screens/project_detail_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

/// Halaman daftar proyek publik yang diambil dari backend DRF menggunakan FutureBuilder.
class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  // Menyimpan Future agar permintaan HTTP tidak dipanggil berulang saat build() berjalan
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    // Inisialisasi pengambilan data proyek sekali saat state layar pertama kali dibuat
    _projectsFuture = context.read<ApiClient>().getProjects();
  }

  /// Memuat ulang daftar proyek dari API (digunakan oleh RefreshIndicator dan tombol Retry).
  Future<void> _reload() async {
    final future = context.read<ApiClient>().getProjects();
    setState(() {
      _projectsFuture = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Achievements: Projects')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Project>>(
        future: _projectsFuture,
        builder: (context, snapshot) {
          // 1. Kondisi sedang memuat data dari jaringan
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Kondisi gagal memuat data: tampilkan pesan error beserta tombol Retry
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Failed to load projects: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final projects = snapshot.data ?? const <Project>[];

          // 3. Kondisi data kosong: bungkus dengan RefreshIndicator + SingleChildScrollView
          // dengan AlwaysScrollableScrollPhysics agar fitur pull-to-refresh tetap berfungsi
          if (projects.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reload,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: const Center(child: Text('No projects found.')),
                    ),
                  );
                },
              ),
            );
          }

          // 4. Kondisi data tersedia: tampilkan daftar kartu proyek dengan fitur pull-to-refresh
          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(
                      project.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (project.techStack.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            project.techStack,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        const SizedBox(height: 4),
                        Text(
                          project.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    // Navigasi ke halaman detail proyek saat kartu ditekan
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProjectDetailScreen(project: project),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
