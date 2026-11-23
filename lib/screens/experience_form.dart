import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman Formulir Tambah Pengalaman Portofolio (Tugas 8).
/// Mengimplementasikan StatefulWidget, Form, GlobalKey,
/// validasi isian, showDatePicker(), dan AlertDialog ringkasan data.
class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  // Global key untuk mengidentifikasi dan memvalidasi Form
  final _formKey = GlobalKey<FormState>();

  // Variabel penampung state data input formulir
  String _title = "";
  String _jobTitle = "";
  String _category = "Internship";
  String _summary = "";
  DateTime? _startDate;
  DateTime? _endDate;

  // Controller untuk sinkronisasi teks tanggal dari showDatePicker
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  // Daftar kategori sesuai model Experience Django portofolio
  final List<String> _categories = [
    'Internship',
    'Research',
    'Volunteer',
    'Part-Time',
    'Full-Time',
    'Freelance',
  ];

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  // Fungsi interaktif pembuka kalender showDatePicker
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime initial = isStartDate
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? _startDate ?? DateTime.now());

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2010),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _startDateController.text =
              "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        } else {
          _endDate = picked;
          _endDateController.text =
              "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Experience Form',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input Nama Perusahaan / Institusi
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Fakultas Ilmu Komputer UI",
                    labelText: "Nama Perusahaan / Institusi",
                    prefixIcon: const Icon(Icons.business),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama institusi/perusahaan tidak boleh kosong!";
                    }
                    if (value.trim().length > 100) {
                      return "Nama tidak boleh melebihi 100 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // Input Posisi / Jabatan
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Software Engineer Intern",
                    labelText: "Posisi / Jabatan",
                    prefixIcon: const Icon(Icons.badge),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _jobTitle = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Posisi/jabatan tidak boleh kosong!";
                    }
                    if (value.trim().length > 100) {
                      return "Posisi tidak boleh melebihi 100 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // Pilihan Dropdown Kategori Pengalaman
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori Pengalaman",
                    prefixIcon: const Icon(Icons.category),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  initialValue: _category,
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue ?? _category;
                    });
                  },
                ),
              ),

              // Input Tanggal Mulai dengan DatePicker
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _startDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Tanggal Mulai",
                    hintText: "Pilih tanggal mulai",
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onTap: () => _selectDate(context, true),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Tanggal mulai wajib dipilih!";
                    }
                    return null;
                  },
                ),
              ),

              // Input Tanggal Selesai dengan DatePicker (Opsional / Ongoing)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _endDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Tanggal Selesai (Opsional jika masih berjalan)",
                    hintText: "Pilih tanggal selesai",
                    prefixIcon: const Icon(Icons.event_available),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onTap: () => _selectDate(context, false),
                  validator: (String? value) {
                    if (_startDate != null && _endDate != null) {
                      if (_endDate!.isBefore(_startDate!)) {
                        return "Tanggal selesai tidak boleh sebelum tanggal mulai!";
                      }
                    }
                    return null;
                  },
                ),
              ),

              // Input Ringkasan Pengalaman (Multiline)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Deskripsikan tanggung jawab dan pencapaian utama...",
                    labelText: "Ringkasan Pengalaman",
                    alignLabelWithHint: true,
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _summary = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Ringkasan pengalaman tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16.0),

              // Tombol Simpan Form dengan validasi dan AlertDialog ringkasan
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Pengalaman Berhasil Disimpan!',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text('Institusi: $_title'),
                                const SizedBox(height: 4),
                                Text('Posisi: $_jobTitle'),
                                const SizedBox(height: 4),
                                Text('Kategori: $_category'),
                                const SizedBox(height: 4),
                                Text('Tanggal Mulai: ${_startDateController.text}'),
                                const SizedBox(height: 4),
                                Text(
                                  'Tanggal Selesai: ${_endDateController.text.isEmpty ? "Masih Berjalan (Ongoing)" : _endDateController.text}',
                                ),
                                const SizedBox(height: 4),
                                Text('Ringkasan: $_summary'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                                _formKey.currentState!.reset();
                                setState(() {
                                  _startDate = null;
                                  _endDate = null;
                                  _startDateController.clear();
                                  _endDateController.clear();
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
