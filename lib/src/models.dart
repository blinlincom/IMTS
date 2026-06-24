import 'package:flutter/material.dart';

enum FeaturePriority {
  first('第一优先级'),
  second('第二优先级'),
  third('第三优先级'),
  fourth('第四优先级');

  const FeaturePriority(this.label);

  final String label;
}

class FeatureNode {
  const FeatureNode({
    required this.title,
    required this.entry,
    required this.capabilities,
    required this.states,
    required this.priority,
    required this.icon,
  });

  final String title;
  final String entry;
  final List<String> capabilities;
  final List<String> states;
  final FeaturePriority priority;
  final IconData icon;
}

class FeatureGroup {
  const FeatureGroup({
    required this.title,
    required this.summary,
    required this.icon,
    required this.nodes,
  });

  final String title;
  final String summary;
  final IconData icon;
  final List<FeatureNode> nodes;
}

class DemoConversation {
  const DemoConversation({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.avatarText,
    required this.isGroup,
    required this.isPinned,
    required this.isMuted,
    required this.isOnline,
    required this.unread,
    required this.badge,
    required this.messages,
  });

  final String id;
  final String title;
  final String subtitle;
  final String time;
  final String avatarText;
  final bool isGroup;
  final bool isPinned;
  final bool isMuted;
  final bool isOnline;
  final int unread;
  final String badge;
  final List<DemoMessage> messages;
}

class DemoMessage {
  const DemoMessage({
    required this.sender,
    required this.body,
    required this.time,
    required this.kind,
    this.isMine = false,
    this.failed = false,
  });

  final String sender;
  final String body;
  final String time;
  final String kind;
  final bool isMine;
  final bool failed;
}

class DemoContact {
  const DemoContact({
    required this.name,
    required this.username,
    required this.signature,
    required this.badge,
    required this.online,
  });

  final String name;
  final String username;
  final String signature;
  final String badge;
  final bool online;
}

class DemoMoment {
  const DemoMoment({
    required this.author,
    required this.body,
    required this.mediaCount,
    required this.likes,
    required this.comments,
    required this.state,
  });

  final String author;
  final String body;
  final int mediaCount;
  final int likes;
  final int comments;
  final String state;
}

class DemoMetric {
  const DemoMetric({
    required this.label,
    required this.value,
    required this.caption,
    required this.icon,
  });

  final String label;
  final String value;
  final String caption;
  final IconData icon;
}

class DemoCheckpoint {
  const DemoCheckpoint({
    required this.title,
    required this.state,
    required this.owner,
    required this.description,
    required this.icon,
    required this.progress,
  });

  final String title;
  final String state;
  final String owner;
  final String description;
  final IconData icon;
  final double progress;
}

class DemoStateCase {
  const DemoStateCase({
    required this.title,
    required this.body,
    required this.action,
    required this.icon,
  });

  final String title;
  final String body;
  final String action;
  final IconData icon;
}

class OperationSwitch {
  const OperationSwitch({
    required this.name,
    required this.enabled,
    required this.description,
  });

  final String name;
  final bool enabled;
  final String description;
}

class PrototypeBucket {
  const PrototypeBucket({required this.title, required this.pages});

  final String title;
  final List<String> pages;
}
