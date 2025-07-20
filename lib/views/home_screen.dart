import 'package:anmol_marketing/controllers/home_controller.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("Home", style: context.bodyLargeStyle),
        backgroundColor: AppColors.appLightThemeBackground,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: context.screenHeight * 0.27,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff0D0367),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: mainAxisEnd,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color(0xff5020DA),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Text(
                              "Last Order",
                              style: context.displayLargeStyle!.copyWith(
                                color: AppColors.whiteTextColor,
                              ),
                            ),
                          ),
                          context.heightBox(25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Order Date
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order Date:',
                                    style: context.bodySmallStyle!.copyWith(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '20, August 2024',
                                    style: context.bodySmallStyle!.copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              // Amount
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Amount:',
                                    style: context.bodySmallStyle!.copyWith(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Rs. 20,000',
                                    style: context.bodySmallStyle!.copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              // Status
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status:',
                                    style: context.bodySmallStyle!.copyWith(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'In Progress',
                                    style: context.bodySmallStyle!.copyWith(
                                      color: Colors.greenAccent,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Color(0xFF3B2A98), Color(0xFF6C1BBD)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://t4.ftcdn.net/jpg/02/14/74/61/360_F_214746128_31JkeaP6rU0NzzzdFC4khGkmqc8noe6h.jpg',
                                ),
                                radius: 34,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: crossAxisStart,
                                children: [
                                  Text(
                                    'GlaxoSmithKline Pharma',
                                    style: context.bodySmallStyle!.copyWith(
                                      color: AppColors.whiteTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Current Balance",
                                    style: context.displayLargeStyle!.copyWith(
                                      color: AppColors.darkGreyColor,
                                    ),
                                  ),
                                  Text(
                                    'Rs. 45,000',
                                    style: context.bodyMediumStyle!.copyWith(
                                      color: AppColors.whiteTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              context.heightBox(context.screenHeight * 0.02),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 120,
                  ),
                  itemBuilder: (context, index) {
                    final cardDetails = controller.cardItems[index];
                    return InkWell(
                      onTap: cardDetails.onTap,
                      child: Container(
                        margin: EdgeInsets.all(8),

                        decoration: BoxDecoration(
                          color: cardDetails.cardColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: mainAxisCenter,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white.withAlpha(
                                  ((0.3) * 255).toInt(),
                                ),
                                child: Image.asset(
                                  cardDetails.cardIcon,
                                  width: 30,
                                  height: 30,
                                  color: cardDetails.textColor,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                cardDetails.cardName,
                                style: context.displayLargeStyle!.copyWith(
                                  color: cardDetails.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
