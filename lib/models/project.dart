import 'package:json_annotation/json_annotation.dart';

// Menghubungkan file ini dengan berkas hasil generasi build_runner (project.g.dart)
part 'project.g.dart';

/// Model data proyek portofolio yang disinkronkan dengan API Django REST Framework.
/// Anotasi FieldRename.snake otomatis memetakan field camelCase di Dart
/// (seperti techStack) ke kunci JSON snake_case pada DRF (tech_stack).
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    this.id,
    required this.title,
    required this.description,
    required this.techStack,
    required this.projectUrl,
    this.projectImageUrl = '',
  });

  /// Factory constructor untuk melakukan deserialisasi JSON dari response DRF
  /// menjadi objek Dart [Project] melalui helper hasil generasi _$ProjectFromJson.
  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  // Mengecualikan id saat serialisasi body POST karena UUID dibuat otomatis oleh server Django
  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String description;
  final String techStack;
  final String projectUrl;

  // Menggunakan string kosong sebagai default agar deserialisasi aman bila null atau tidak dikirim
  @JsonKey(defaultValue: '')
  final String projectImageUrl;

  /// Mengonversi objek [Project] menjadi Map JSON untuk dikirim sebagai payload HTTP POST.
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
