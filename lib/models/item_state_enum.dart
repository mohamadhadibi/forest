import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ItemStateEnum { done, active, lock }

extension ItemStateEnumExt on ItemStateEnum {
  String toValue() {
    switch (this) {
      case ItemStateEnum.done:
        return 'done';
      case ItemStateEnum.active:
        return 'active';
      case ItemStateEnum.lock:
        return 'lock';
    }
  }

  Color color() {
    switch (this) {
      case ItemStateEnum.done:
        return Color(0xFF25aa6f);
      case ItemStateEnum.active:
        return Color(0xFFed6c00);
      case ItemStateEnum.lock:
        return Color(0xFFeae9bd);
    }
  }

  IconData icon() {
    switch (this) {
      case ItemStateEnum.done:
        return CupertinoIcons.check_mark;
      case ItemStateEnum.active:
        return CupertinoIcons.bolt;
      case ItemStateEnum.lock:
        return CupertinoIcons.lock;
    }
  }
}
