import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/demo_data.dart';
import '../models.dart';

class ImApp extends StatelessWidget {
  const ImApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '搭个话',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const ImHome(),
    );
  }
}

class ImHome extends StatefulWidget {
  const ImHome({super.key});

  @override
  State<ImHome> createState() => _ImHomeState();
}

class _ImHomeState extends State<ImHome> {
  int _index = 0;

  static const _screens = <Widget>[
    MessagesScreen(),
    ContactsScreen(),
    MeScreen(),
    ArchitectureScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [_BrandMark(size: 32), SizedBox(width: 10), Text('搭个话')],
        ),
        actions: [
          const _ConnectionBadge(),
          IconButton(
            tooltip: '扫一扫',
            onPressed: () => _openNode(context, '扫一扫'),
            icon: const Icon(Icons.qr_code_scanner_outlined),
          ),
          IconButton(
            tooltip: '加号快捷面板',
            onPressed: () => _openNode(context, '首页快捷面板'),
            icon: const Icon(Icons.add_circle_outline),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(child: _screens[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: '消息',
          ),
          NavigationDestination(
            icon: Icon(Icons.contacts_outlined),
            selectedIcon: Icon(Icons.contacts),
            label: '联系人',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '我的',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_tree_outlined),
            selectedIcon: Icon(Icons.account_tree),
            label: '架构',
          ),
        ],
      ),
    );
  }

  void _openNode(BuildContext context, String title) {
    final node = DemoData.featureGroups
        .expand((group) => group.nodes)
        .firstWhere((item) => item.title == title);
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => FeatureNodeScreen(node: node)));
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        const _SignalCommandPanel(),
        const SizedBox(height: 12),
        const _GlobalNotice(),
        const SizedBox(height: 12),
        const _SearchBar(label: '搜索会话、群名称、聊天记录'),
        const SizedBox(height: 12),
        _QuickActions(
          actions: const [
            _QuickAction('加好友', Icons.person_add_alt_1_outlined, '加好友搜索'),
            _QuickAction('创建群聊', Icons.group_add_outlined, '创建群聊'),
            _QuickAction('扫一扫', Icons.qr_code_scanner_outlined, '扫一扫'),
            _QuickAction('附近人', Icons.near_me_outlined, '首页快捷面板'),
          ],
        ),
        const SizedBox(height: 18),
        const _CheckpointStrip(),
        const SizedBox(height: 18),
        const _SectionTitle(title: '最近会话', action: '左滑支持置顶 / 删除 / 清空'),
        const SizedBox(height: 8),
        ...DemoData.conversations.map(
          (conversation) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ConversationTile(conversation: conversation),
          ),
        ),
      ],
    );
  }
}

class _SignalCommandPanel extends StatelessWidget {
  const _SignalCommandPanel();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.radius),
      child: DecoratedBox(
        decoration: const BoxDecoration(color: AppTheme.ink),
        child: Stack(
          children: [
            const Positioned.fill(
              child: CustomPaint(painter: _SignalPainter()),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      _BrandMark(size: 40, inverse: true),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '对话信号台',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '在线 · 18 未读 · 4 个验收点',
                              style: TextStyle(
                                color: Color(0xFFBFD0DA),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    '把消息、关系、资产和运营配置串成一条可追踪的信号流。',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.45,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _DarkSignalChip(label: '强公告已读'),
                      _DarkSignalChip(label: '长连接在线'),
                      _DarkSignalChip(label: '资料审核中'),
                      _DarkSignalChip(label: '钱包正常'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: DemoData.metrics.take(3).map<Widget>((metric) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _DarkMetric(metric: metric),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DarkMetric extends StatelessWidget {
  const _DarkMetric({required this.metric});

  final DemoMetric metric;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppTheme.radius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(metric.icon, color: AppTheme.tealSoft, size: 18),
            const SizedBox(height: 8),
            Text(
              metric.value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              metric.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFFBFD0DA),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DarkSignalChip extends StatelessWidget {
  const _DarkSignalChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppTheme.teal.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppTheme.tealSoft.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: const TextStyle(
            color: AppTheme.tealSoft,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _SignalPainter extends CustomPainter {
  const _SignalPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    final node = Paint()..color = AppTheme.tealSoft.withValues(alpha: 0.22);

    final points = <Offset>[
      Offset(size.width * 0.72, 18),
      Offset(size.width * 0.92, size.height * 0.30),
      Offset(size.width * 0.74, size.height * 0.64),
      Offset(size.width * 0.96, size.height - 20),
    ];

    for (var i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], line);
    }
    for (final point in points) {
      canvas.drawCircle(point, 5, node);
      canvas.drawCircle(point, 12, line);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CheckpointStrip extends StatelessWidget {
  const _CheckpointStrip();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: DemoData.checkpoints.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final checkpoint = DemoData.checkpoints[index];
          return SizedBox(
            width: 238,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(checkpoint.icon, color: AppTheme.teal, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            checkpoint.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        _Pill(label: checkpoint.state, tone: PillTone.blue),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      checkpoint.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: checkpoint.progress,
                        minHeight: 6,
                        backgroundColor: AppTheme.fog,
                        color: AppTheme.teal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      checkpoint.owner,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ConversationTile extends StatelessWidget {
  const ConversationTile({required this.conversation, super.key});

  final DemoConversation conversation;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radius),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChatScreen(conversation: conversation),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              _Avatar(
                text: conversation.avatarText,
                active: conversation.isOnline,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          conversation.time,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _Pill(label: conversation.badge),
                        if (conversation.isPinned)
                          const _Pill(label: '置顶', tone: PillTone.blue),
                        if (conversation.isMuted)
                          const _Pill(label: '免打扰', tone: PillTone.gray),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      conversation.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppTheme.mutedInk),
                    ),
                  ],
                ),
              ),
              if (conversation.unread > 0) ...[
                const SizedBox(width: 10),
                _UnreadDot(count: conversation.unread),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({required this.conversation, super.key});

  final DemoConversation conversation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(conversation.title),
            Text(
              conversation.isGroup
                  ? '群聊 · ${conversation.isMuted ? '免打扰' : '提醒开启'}'
                  : (conversation.isOnline ? '在线 · 正在输入预留' : '离线'),
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: conversation.isGroup ? '群音视频' : '私聊音视频',
            onPressed: () =>
                _openFeature(context, conversation.isGroup ? '群音视频' : '私聊音视频'),
            icon: const Icon(Icons.video_call_outlined),
          ),
          IconButton(
            tooltip: conversation.isGroup ? '群设置' : '私聊信息页',
            onPressed: () =>
                _openFeature(context, conversation.isGroup ? '群设置页' : '私聊信息页'),
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              children: [
                const Center(
                  child: _Pill(label: '今天 09:00', tone: PillTone.gray),
                ),
                const SizedBox(height: 12),
                ...conversation.messages.map(
                  (message) => _MessageBubble(message: message),
                ),
              ],
            ),
          ),
          _ComposerBar(isGroup: conversation.isGroup),
        ],
      ),
    );
  }

  void _openFeature(BuildContext context, String title) {
    final node = DemoData.featureGroups
        .expand((group) => group.nodes)
        .firstWhere((item) => item.title == title);
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => FeatureNodeScreen(node: node)));
  }
}

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        const _SearchBar(label: '搜索好友昵称或用户名'),
        const SizedBox(height: 12),
        _ShortcutGrid(
          items: const [
            _Shortcut(
              '新的朋友',
              '2 条待处理',
              Icons.person_add_alt_1_outlined,
              '新的朋友',
            ),
            _Shortcut('我的群聊', '18 个已保存群', Icons.groups_2_outlined, '我的群聊'),
            _Shortcut('系统通知', '5 条未读', Icons.notifications_outlined, '系统通知'),
            _Shortcut('朋友圈', '3 条新互动', Icons.photo_library_outlined, '朋友圈首页'),
          ],
        ),
        const SizedBox(height: 18),
        const _SectionTitle(title: '好友列表', action: '128 位好友 · 42 位在线'),
        const SizedBox(height: 8),
        ...DemoData.contacts.map((contact) => _ContactTile(contact: contact)),
      ],
    );
  }
}

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const _Avatar(text: '沈', active: true, size: 58),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DemoData.currentUserName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '@${DemoData.currentUsername}',
                        style: TextStyle(color: AppTheme.mutedInk),
                      ),
                      const SizedBox(height: 8),
                      const Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _Pill(label: DemoData.currentBadge),
                          _Pill(label: '资料审核中', tone: PillTone.amber),
                          _Pill(label: '钱包正常', tone: PillTone.blue),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: '我的二维码',
                  onPressed: () => _openNode(context, '我的二维码'),
                  icon: const Icon(Icons.qr_code_2_outlined),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _MetricGrid(metrics: DemoData.metrics),
        const SizedBox(height: 18),
        const _SectionTitle(title: '状态验收', action: '空 / 失败 / 审核 / 锁定'),
        const SizedBox(height: 8),
        const _StateCaseDeck(),
        const SizedBox(height: 18),
        const _SectionTitle(title: '个人中心入口', action: '默认数据可直接演示'),
        const SizedBox(height: 8),
        _ShortcutGrid(
          items: const [
            _Shortcut('签到', '今日未签到', Icons.event_available_outlined, '签到'),
            _Shortcut(
              '钱包',
              '余额 ¥268.50',
              Icons.account_balance_wallet_outlined,
              '钱包页',
            ),
            _Shortcut('商品中心', '6 个商品上架', Icons.storefront_outlined, '商品中心'),
            _Shortcut('表情商店', '12 套可添加', Icons.emoji_emotions_outlined, '表情商店'),
            _Shortcut('设置', '版本 1.4.0', Icons.settings_outlined, '设置页'),
            _Shortcut('我的主页', '资料待审核', Icons.account_circle_outlined, '我的主页'),
          ],
        ),
        const SizedBox(height: 18),
        const _SectionTitle(title: '朋友圈预览', action: '含审核状态'),
        const SizedBox(height: 8),
        ...DemoData.moments.map((moment) => _MomentTile(moment: moment)),
        const SizedBox(height: 18),
        const _SectionTitle(title: '运营配置摘要', action: '控制客户端显示'),
        const SizedBox(height: 8),
        _OperationSwitchList(
          items: DemoData.operationSwitches.take(8).toList(),
        ),
      ],
    );
  }

  void _openNode(BuildContext context, String title) {
    final node = DemoData.featureGroups
        .expand((group) => group.nodes)
        .firstWhere((item) => item.title == title);
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => FeatureNodeScreen(node: node)));
  }
}

class ArchitectureScreen extends StatefulWidget {
  const ArchitectureScreen({super.key});

  @override
  State<ArchitectureScreen> createState() => _ArchitectureScreenState();
}

class _ArchitectureScreenState extends State<ArchitectureScreen> {
  FeaturePriority? _priority;

  @override
  Widget build(BuildContext context) {
    final totalNodes = DemoData.featureGroups.fold<int>(
      0,
      (sum, group) => sum + group.nodes.length,
    );
    final totalPrototypePages = DemoData.prototypeBuckets.fold<int>(
      0,
      (sum, bucket) => sum + bucket.pages.length,
    );
    final groups = DemoData.featureGroups
        .map((group) {
          final nodes = _priority == null
              ? group.nodes
              : group.nodes
                    .where((node) => node.priority == _priority)
                    .toList();
          return FeatureGroup(
            title: group.title,
            summary: group.summary,
            icon: group.icon,
            nodes: nodes,
          );
        })
        .where((group) => group.nodes.isNotEmpty)
        .toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'IM 功能地图',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  '完整覆盖架构图：客户端入口、主导航、聊天、关系链、朋友圈、资产、商城、设置、运营配置、空/异常/审核状态和原型优先级。',
                  style: TextStyle(color: AppTheme.mutedInk, height: 1.45),
                ),
                const SizedBox(height: 14),
                _ArchitectureStats(
                  groups: DemoData.featureGroups.length,
                  nodes: totalNodes,
                  pages: totalPrototypePages,
                  switches: DemoData.operationSwitches.length,
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('全部'),
                      selected: _priority == null,
                      onSelected: (_) => setState(() => _priority = null),
                    ),
                    ...FeaturePriority.values.map(
                      (priority) => ChoiceChip(
                        label: Text(priority.label),
                        selected: _priority == priority,
                        onSelected: (_) => setState(() => _priority = priority),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...groups.map(
          (group) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _FeatureGroupTile(group: group),
          ),
        ),
        const SizedBox(height: 18),
        const _SectionTitle(title: '原型图建议页面清单', action: '按架构图分组'),
        const SizedBox(height: 8),
        ...DemoData.prototypeBuckets.map(
          (bucket) => _PrototypeBucketTile(bucket: bucket),
        ),
      ],
    );
  }
}

class _ArchitectureStats extends StatelessWidget {
  const _ArchitectureStats({
    required this.groups,
    required this.nodes,
    required this.pages,
    required this.switches,
  });

  final int groups;
  final int nodes;
  final int pages;
  final int switches;

  @override
  Widget build(BuildContext context) {
    final items = [
      ('功能组', '$groups', Icons.account_tree_outlined),
      ('页面节点', '$nodes', Icons.widgets_outlined),
      ('原型状态', '$pages', Icons.fact_check_outlined),
      ('运营开关', '$switches', Icons.tune_outlined),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items
          .map(
            (item) => DecoratedBox(
              decoration: BoxDecoration(
                color: AppTheme.fog,
                borderRadius: BorderRadius.circular(AppTheme.radius),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 9,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(item.$3, size: 18, color: AppTheme.teal),
                    const SizedBox(width: 8),
                    Text(
                      item.$2,
                      style: const TextStyle(
                        color: AppTheme.ink,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.$1,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class FeatureNodeScreen extends StatelessWidget {
  const FeatureNodeScreen({required this.node, super.key});

  final FeatureNode node;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(node.title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(node.icon, color: AppTheme.teal, size: 34),
                  const SizedBox(height: 12),
                  Text(
                    node.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '入口：${node.entry}',
                    style: const TextStyle(color: AppTheme.mutedInk),
                  ),
                  const SizedBox(height: 12),
                  _Pill(label: node.priority.label, tone: PillTone.blue),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _DetailPanel(title: '页面能力', values: node.capabilities),
          const SizedBox(height: 14),
          _DetailPanel(title: '关键状态', values: node.states),
        ],
      ),
    );
  }
}

class _FeatureGroupTile extends StatelessWidget {
  const _FeatureGroupTile({required this.group});

  final FeatureGroup group;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Icon(group.icon, color: AppTheme.teal),
        title: Text(
          group.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(group.summary),
        children: group.nodes
            .map(
              (node) => ListTile(
                leading: Icon(node.icon),
                title: Text(node.title),
                subtitle: Text('${node.entry} · ${node.priority.label}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FeatureNodeScreen(node: node),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ComposerBar extends StatelessWidget {
  const _ComposerBar({required this.isGroup});

  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    final tools = isGroup
        ? const ['表情', '@', '语音', '图片', '红包', '群转账', '群视频']
        : const ['表情', '语音', '图片', '文件', '红包', '转账', '视频'];

    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        border: Border(top: BorderSide(color: AppTheme.line)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                tooltip: '语音模式',
                onPressed: () {},
                icon: const Icon(Icons.mic_none_outlined),
              ),
              Expanded(
                child: TextField(
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: isGroup ? '输入消息，@ 可选择群成员' : '输入消息',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(onPressed: () {}, child: const Text('发送')),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: tools.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) =>
                  ActionChip(label: Text(tools[index]), onPressed: () {}),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final DemoMessage message;

  @override
  Widget build(BuildContext context) {
    final alignment = message.isMine
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final bg = message.isMine ? AppTheme.teal : AppTheme.surface;
    final fg = message.isMine ? Colors.white : AppTheme.ink;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            '${message.sender} · ${message.time} · ${message.kind}',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 4),
          Container(
            constraints: const BoxConstraints(maxWidth: 300),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(14),
              border: message.isMine ? null : Border.all(color: AppTheme.line),
            ),
            child: Text(
              message.body,
              style: TextStyle(color: fg, height: 1.45),
            ),
          ),
          if (message.failed)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                '发送失败，点击重发',
                style: TextStyle(color: AppTheme.coral, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class _GlobalNotice extends StatelessWidget {
  const _GlobalNotice();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                color: AppTheme.coralSoft,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.campaign_outlined,
                  color: AppTheme.coral,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                DemoData.announcement,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            _Pill(label: 'v${DemoData.latestVersion}', tone: PillTone.amber),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.actions});

  final List<_QuickAction> actions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) =>
            SizedBox(width: 124, child: _ActionButton(action: actions[index])),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.action});

  final _QuickAction action;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        final node = DemoData.featureGroups
            .expand((group) => group.nodes)
            .firstWhere((item) => item.title == action.targetTitle);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => FeatureNodeScreen(node: node)),
        );
      },
      icon: Icon(action.icon, size: 18),
      label: Text(action.label, overflow: TextOverflow.ellipsis),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius),
        ),
      ),
    );
  }
}

class _QuickAction {
  const _QuickAction(this.label, this.icon, this.targetTitle);

  final String label;
  final IconData icon;
  final String targetTitle;
}

class _ShortcutGrid extends StatelessWidget {
  const _ShortcutGrid({required this.items});

  final List<_Shortcut> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.35,
      ),
      itemBuilder: (context, index) => _ShortcutTile(item: items[index]),
    );
  }
}

class _ShortcutTile extends StatelessWidget {
  const _ShortcutTile({required this.item});

  final _Shortcut item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radius),
        onTap: () {
          final node = DemoData.featureGroups
              .expand((group) => group.nodes)
              .firstWhere((candidate) => candidate.title == item.targetTitle);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => FeatureNodeScreen(node: node)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(item.icon, color: AppTheme.teal),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      item.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Shortcut {
  const _Shortcut(this.title, this.subtitle, this.icon, this.targetTitle);

  final String title;
  final String subtitle;
  final IconData icon;
  final String targetTitle;
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({required this.contact});

  final DemoContact contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: ListTile(
          leading: _Avatar(
            text: contact.name.characters.first,
            active: contact.online,
          ),
          title: Text(contact.name),
          subtitle: Text('@${contact.username} · ${contact.signature}'),
          trailing: _Pill(label: contact.badge),
          onTap: () {
            final node = DemoData.featureGroups
                .expand((group) => group.nodes)
                .firstWhere((item) => item.title == '对方个人主页');
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => FeatureNodeScreen(node: node)),
            );
          },
        ),
      ),
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.metrics});

  final List<DemoMetric> metrics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: metrics.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.35,
      ),
      itemBuilder: (context, index) {
        final metric = metrics[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(metric.icon, color: AppTheme.teal),
                const Spacer(),
                Text(
                  metric.value,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 2),
                Text(
                  metric.label,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  metric.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MomentTile extends StatelessWidget {
  const _MomentTile({required this.moment});

  final DemoMoment moment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _Avatar(
                    text: moment.author.characters.first,
                    active: true,
                    size: 36,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      moment.author,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  _Pill(
                    label: moment.state,
                    tone: moment.state == '待审核'
                        ? PillTone.amber
                        : PillTone.blue,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(moment.body),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _Pill(label: '${moment.mediaCount} 张媒体'),
                  _Pill(label: '${moment.likes} 赞'),
                  _Pill(label: '${moment.comments} 评论'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OperationSwitchList extends StatelessWidget {
  const _OperationSwitchList({required this.items});

  final List<OperationSwitch> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: items
            .map(
              (item) => SwitchListTile(
                value: item.enabled,
                onChanged: (_) {},
                title: Text(item.name),
                subtitle: Text(item.description),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _StateCaseDeck extends StatelessWidget {
  const _StateCaseDeck();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 154,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: DemoData.stateCases.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = DemoData.stateCases[index];
          return SizedBox(
            width: 230,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(item.icon, color: AppTheme.coral, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.body,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _Pill(label: item.action, tone: PillTone.amber),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PrototypeBucketTile extends StatelessWidget {
  const _PrototypeBucketTile({required this.bucket});

  final PrototypeBucket bucket;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: ExpansionTile(
          title: Text(bucket.title),
          subtitle: Text('${bucket.pages.length} 个页面/状态'),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: bucket.pages
                      .map((page) => _Pill(label: page))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailPanel extends StatelessWidget {
  const _DetailPanel({required this.title, required this.values});

  final String title;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: values.map((value) => _Pill(label: value)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: label,
        suffixIcon: IconButton(
          tooltip: '搜索',
          onPressed: () {},
          icon: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.action});

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            action,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}

class _ConnectionBadge extends StatelessWidget {
  const _ConnectionBadge();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: _Pill(label: '在线', tone: PillTone.blue),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark({this.size = 34, this.inverse = false});

  final double size;
  final bool inverse;

  @override
  Widget build(BuildContext context) {
    final bg = inverse ? Colors.white : AppTheme.ink;
    final fg = inverse ? AppTheme.ink : Colors.white;
    final accent = inverse ? AppTheme.teal : AppTheme.tealSoft;

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppTheme.radius),
          border: Border.all(
            color: inverse
                ? Colors.white.withValues(alpha: 0.18)
                : AppTheme.line,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(-0.22, -0.08),
              child: Text(
                '搭',
                style: TextStyle(
                  color: fg,
                  fontSize: size * 0.42,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
            ),
            Positioned(
              right: size * 0.18,
              bottom: size * 0.18,
              child: Row(
                children: [
                  _MarkDot(size: size * 0.08, color: accent),
                  SizedBox(width: size * 0.04),
                  _MarkDot(size: size * 0.08, color: accent),
                  SizedBox(width: size * 0.04),
                  _MarkDot(size: size * 0.08, color: accent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MarkDot extends StatelessWidget {
  const _MarkDot({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: SizedBox.square(dimension: size),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.text, required this.active, this.size = 44});

  final String text;
  final bool active;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppTheme.teal, AppTheme.blue],
            ),
            border: Border.all(color: AppTheme.surface, width: 2),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.36,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: active ? AppTheme.success : const Color(0xFF9AA4B2),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

enum PillTone { teal, blue, amber, gray }

class _Pill extends StatelessWidget {
  const _Pill({required this.label, this.tone = PillTone.teal});

  final String label;
  final PillTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = switch (tone) {
      PillTone.teal => (AppTheme.teal, AppTheme.tealSoft),
      PillTone.blue => (AppTheme.blue, AppTheme.blueSoft),
      PillTone.amber => (AppTheme.amber, AppTheme.amberSoft),
      PillTone.gray => (AppTheme.mutedInk, AppTheme.fog),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: colors.$2,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colors.$1,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _UnreadDot extends StatelessWidget {
  const _UnreadDot({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: const BoxDecoration(
        color: AppTheme.coral,
        shape: BoxShape.circle,
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
