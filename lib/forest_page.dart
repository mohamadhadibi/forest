import 'package:flutter/material.dart';
import 'package:forest/models/item_state_enum.dart';

import 'colors.dart';
import 'forest_list_widget.dart';
import 'models/item_model.dart';
import 'widgets/half_circle_clipper.dart';

class ForestPage extends StatefulWidget {
  const ForestPage({super.key});

  @override
  State<ForestPage> createState() => _ForestPageState();
}

class _ForestPageState extends State<ForestPage> {
  List<ItemModel> items = [
    ItemModel(state: ItemStateEnum.done),
    ItemModel(state: ItemStateEnum.done),
    ItemModel(state: ItemStateEnum.done),
    ItemModel(state: ItemStateEnum.active),
    ItemModel(state: ItemStateEnum.lock),
    ItemModel(state: ItemStateEnum.lock),
    ItemModel(state: ItemStateEnum.lock),
    ItemModel(state: ItemStateEnum.lock),
    ItemModel(state: ItemStateEnum.lock),
    ItemModel(state: ItemStateEnum.lock),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.skyColor,
      appBar: AppBar(
        backgroundColor: AppColors.skyColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, color: AppColors.toolbarColor),
        ),
        title: Text(
          "Gesundheitsreise",
          style: TextStyle(
            color: AppColors.toolbarColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 120),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Mit Guido auf deiner\n Reise zu mehr\n Wohlbefinden.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.iconColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),

          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Aktuelle Etappe öffnen",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 40),

          Stack(
            children: [
              Container(height: 120, color: AppColors.skyColor),
              ClipPath(
                clipper: HalfCircleClipper(),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.forestLightColor,
                        AppColors.forestLightColor,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.forestLightColor, AppColors.forestDarkColor],
              ),
            ),
            child: ForestListWidget(items: items),
          ),
        ],
      ),
    );
  }
}
