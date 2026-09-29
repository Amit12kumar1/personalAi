import 'package:flutter_test/flutter_test.dart';
import 'package:jarve_j/main.dart';

void main() {
  testWidgets('JARVIS initial smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const JarvisApp());
    expect(find.byType(JarvisApp), findsOneWidget);
  });
}
