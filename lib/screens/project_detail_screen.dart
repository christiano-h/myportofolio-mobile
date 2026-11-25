import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';

/// Halaman detail untuk menampilkan seluruh informasi dari satu [Project] terpilih.
class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tampilkan widget gambar hanya apabila URL gambar proyek tidak kosong
            if (project.projectImageUrl.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  project.projectImageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  // Fallback sederhana jika gambar gagal dimuat dari URL
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, size: 48),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Judul proyek
            Text(
              project.title,
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Daftar teknologi (tech stack)
            Text(
              'Tech Stack',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(project.techStack),
            const SizedBox(height: 16),

            // Deskripsi lengkap proyek
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(project.description),
            const SizedBox(height: 16),

            // Tautan proyek (project URL)
            Text(
              'Project URL',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              project.projectUrl,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
