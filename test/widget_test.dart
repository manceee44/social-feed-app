import 'package:flutter_test/flutter_test.dart';
import 'package:inttask/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SocialFeedApp());
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.text('Post list'), findsOneWidget);
  });
}
