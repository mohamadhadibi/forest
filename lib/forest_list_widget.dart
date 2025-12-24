import 'package:flutter/material.dart';
import 'package:forest/models/item_model.dart';
import 'package:forest/models/item_state_enum.dart';

import 'colors.dart';
import 'dotted/dash_path_type.dart';
import 'dotted/dashed_path.dart';

class ForestListWidget extends StatelessWidget {
  final List<ItemModel> items;
  const ForestListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final mapping = _buildSnakeMapping(items.length);
    final listSize = mapping.length;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: 2,
      ),
      itemCount: listSize,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox();
        }

        final rowIndex = index ~/ 2;

        Alignment align = Alignment.center;
        DashPathType dash = DashPathType.straight;
        if (rowIndex.isEven) {
          // row 1, 3
          if (index.isEven) {
            // left
            align = Alignment.center;
            dash = DashPathType.curveLeftUp;
          } else {
            // right
            align = Alignment.centerLeft;
            dash = DashPathType.curveRightDown;
          }
        } else {
          // row 2, 4
          if (index.isEven) {
            // left
            align = Alignment.centerRight;
            dash = DashPathType.curveLeftDown;
          } else {
            // right
            align = Alignment.center;
            dash = DashPathType.curveRightUp;
          }
        }

        if (index == listSize - 1 && items.length.isEven) {
          if (rowIndex.isEven) {
            align = Alignment.centerRight;
          } else {
            align = Alignment.centerLeft;
          }
        }
        final itemIndex = mapping[index];
        if (itemIndex == null) {
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if ((index != (listSize - 1) && items.length.isOdd) ||
                  items.length.isEven)
                DashedPath(color: AppColors.iconColor, type: dash),
              Align(alignment: align, child: _buildIconBox(items[itemIndex])),
            ],
          ),
        );
      },
    );
  }

  /// Build a flattened mapping list for grid indices:
  /// - index 0 -> null (empty)
  /// - index 1 -> items[0]
  /// - subsequent rows are built visually as pairs [left, right]
  ///   with snake pattern.
  /// If itemCount is even, ensure final visual row is [null, lastItem]
  List<int?> _buildSnakeMapping(int itemCount) {
    final List<List<int?>> rows = [];

    if (itemCount == 0) {
      return [null];
    }

    rows.add([null, 0]);

    int p = 1;
    int visualRowIndex = 1;
    while (p < itemCount) {
      final remaining = itemCount - p;

      if (remaining == 1) {
        rows.add([null, p]);
        p += 1;
        break;
      }

      if (visualRowIndex.isOdd) {
        rows.add([p + 1, p]);
      } else {
        rows.add([p, p + 1]);
      }

      p += 2;
      visualRowIndex += 1;
    }

    if (itemCount.isEven) {
      final lastIndex = itemCount - 1;
      bool lastOnRight = false;
      int foundRow = -1;
      int foundCol = -1;

      for (int r = 0; r < rows.length; r++) {
        for (int c = 0; c < 2; c++) {
          if (rows[r][c] == lastIndex) {
            foundRow = r;
            foundCol = c;
            if (c == 1) lastOnRight = true;
            break;
          }
        }
        if (foundRow != -1) break;
      }

      if (!lastOnRight) {
        if (foundRow != -1) {
          rows[foundRow][foundCol] = null;
        }
        rows.add([null, lastIndex]);
      }
    }

    final mapping = <int?>[];
    for (final row in rows) {
      mapping.add(row[0]);
      mapping.add(row[1]);
    }

    return mapping;
  }

  Widget _buildIconBox(ItemModel item) {
    return Container(
      width: 60,
      height: 52,
      decoration: BoxDecoration(
        color: item.state.color(),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.iconColor.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        item.state.icon(),
        color: AppColors.iconColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
