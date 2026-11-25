import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  // Menguji bahwa aplikasi dapat dirender dengan MultiProvider dan route guard bekerja
  testWidgets(
    'Home renders and Tambah Proyek redirects to Login when logged out',
    (tester) async {
      await tester.pumpWidget(MyApp(apiClient: ApiClient()));
      expect(find.text('MyPortfolio'), findsOneWidget);

      // Menekan kartu Tambah Proyek saat belum login harus membuka LoginScreen
      await tester.tap(find.text('Tambah Proyek'));
      await tester.pumpAndSettle();

      expect(find.text('Login'), findsWidgets);
      expect(tester.takeException(), isNull);
    },
  );
}
