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
    final listSize = items.length + 1;
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

        return Padding(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if ((index != (listSize - 1) && listSize.isEven) ||
                  listSize.isOdd)
                DashedPath(color: AppColors.iconColor, type: dash),
              Align(alignment: align, child: _buildIconBox(items[index - 1])),
            ],
          ),
        );
      },
    );
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
      child: Column(
        children: [
          Icon(
            item.state.icon(),
            color: AppColors.iconColor,
            fontWeight: FontWeight.bold,
          ),
          Text(item.title.toString()),
        ],
      ),
      /*
      child: Icon(
        item.state.icon(),
        color: AppColors.iconColor,
        fontWeight: FontWeight.bold,
      ),
*/
    );
  }
}
