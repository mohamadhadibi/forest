import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:forest/models/item_model.dart';
import 'package:forest/models/item_state_enum.dart';

import 'colors.dart';

class ForestListWidget extends StatelessWidget {
  final List<ItemModel> items;
  const ForestListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildZigzagRows(),
    );
  }

  List<Widget> _buildZigzagRows() {
    List<Widget> rows = [];

    for (int i = 0; i < items.length; i++) {
      if (i == 0) {
        rows.add(Center(child: _buildIconBox(items[i])));
      } else {
        if (i % 2 == 1 && i + 1 < items.length) {
          bool leftToRight = ((i ~/ 2) % 2 == 0);
          rows.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment:
                leftToRight ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  if (!leftToRight) _buildIconBox(items[i + 1]),
                  _buildDottedLine(),
                  _buildIconBox(items[i]),
                  if (leftToRight) _buildIconBox(items[i + 1]),
                ],
              ),
            ),
          );
          i++;
        }
      }
    }

    return rows;
  }

  Widget _buildIconBox(ItemModel item) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: item.state.color(),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.iconColor,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(item.state.icon(), color: AppColors.iconColor),
    );
  }

  Widget _buildDottedLine() {
    return SizedBox(
      width: 40,
      height: 48,
      child: DottedBorder(
        options: const RoundedRectDottedBorderOptions(
          dashPattern: [4, 4],
          strokeWidth: 1.5,
          radius: Radius.circular(12),
          color: AppColors.iconColor,
          padding: EdgeInsets.zero,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }

}
