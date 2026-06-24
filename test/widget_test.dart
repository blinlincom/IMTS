import 'package:blinblin_com/src/ui/im_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('IM shell renders demo data and architecture map', (
    tester,
  ) async {
    await tester.pumpWidget(const ImApp());

    expect(find.text('搭个话'), findsWidgets);
    expect(find.text('消息'), findsWidgets);
    expect(find.text('联系人'), findsWidgets);
    expect(find.text('我的'), findsWidgets);
    expect(find.text('架构'), findsWidgets);
    expect(find.text('对话信号台'), findsOneWidget);
    expect(find.text('强公告已读'), findsWidgets);
    expect(find.text('林小满'), findsOneWidget);
    expect(find.text('产品内测群'), findsOneWidget);

    await tester.tap(find.text('我的'));
    await tester.pumpAndSettle();

    expect(find.text('状态验收'), findsOneWidget);
    expect(find.text('空会话'), findsOneWidget);
    expect(find.text('消息发送失败'), findsOneWidget);

    await tester.tap(find.text('架构'));
    await tester.pumpAndSettle();

    expect(find.text('IM 功能地图'), findsOneWidget);
    expect(find.text('功能组'), findsOneWidget);
    expect(find.text('页面节点'), findsOneWidget);
    expect(find.text('原型状态'), findsOneWidget);
  });
}
