
import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_bookstore/main.dart';

void main() {
  testWidgets('NusaBookstore app starts', (tester) async {
    await tester.pumpWidget(const NusaBookstoreApp());

    expect(find.text('NusaBookstore'), findsOneWidget);
  });
}
