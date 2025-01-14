import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_guide/utils/resources/resources.dart';
import 'dart:async';

import '../../../routes/app_pages.dart';
import '../views/setup_view.dart';
import '../data/plan_services.dart';

class PlanController extends GetxController {
  final PlanServices _planServices = PlanServices();
  final pageController = PageController();
  final currentPage = 0.obs;
  final selectedAnswers = <String>[].obs;
  final loadingMessageIndex = 0.obs;
  Timer? _messageTimer;

  final messages = [
    "Finding the perfect spots for you...",
    "Analyzing your preferences...",
    "Crafting your personalized journey...",
    "Almost ready with your dream destinations...",
  ];

  final questions = [
    'What type of traveler are you?',
    'What is your ideal pace for exploring?',
    'How long is your trip?',
    'What’s your travel group?',
    "What's most important to you when traveling?",
  ];

  final List<List<String>> answers = [
    [
      'Adventure Seeker',
      'Historical and Culture Enthusiast',
      'Relaxation and Luxury Lover',
    ],
    [
      'Packed with activities from morning to night',
      'Balanced with sightseeing and downtime',
      'Relaxed and slow-paced',
    ],
    [
      '1-3 days',
      '4-7 days',
      'More than a week',
    ],
    [
      'Solo traveler',
      'Couple',
      'Family with kids',
      'Friends group',
    ],
    [
      'Meeting locals and cultural exchange',
      'Trying new and unique experiences',
    ],
  ];

  final imageQuestion = [
    SVGs.q3,
    SVGs.q2,
    SVGs.q1,
    SVGs.q4,
    SVGs.q5,
  ];

  @override
  void onInit() {
    super.onInit();
  }

  void startLoadingAnimation() async {
    // Reset index
    loadingMessageIndex.value = 0;
    // Save plan to Firebase
    try {
      await _planServices.savePlan(selectedPlan());
    } catch (e) {
      print('Error saving plan: $e');
    }

    // Change message every second
    _messageTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (loadingMessageIndex.value < messages.length - 1) {
        loadingMessageIndex.value++;
      } else {
        timer.cancel();
        // Wait one more second before navigating
        Future.delayed(const Duration(seconds: 1), () {
          Get.offNamed(Routes.HOME); // atau route yang Anda inginkan
        });
      }
    });
  }

  void nextPage(String answer) {
    if (currentPage.value < questions.length - 1) {
      selectedAnswers.add(answer);
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Handle survey completion
      selectedAnswers.add(answer);
      selectedPlan();
      Get.to(SetupView());
    }
  }

  List<String> selectedPlan() {
    List<String> personalizedPlan = [];
    String plan = selectedAnswers.first;

    if (plan == 'Adventure Seeker') {
      personalizedPlan = ['nature', 'beach', 'village', 'traditional_craft'];
    } else if (plan == 'Historical and Culture Enthusiast') {
      personalizedPlan = ['historical_place', 'church', 'traditional_craft'];
    } else if (plan == 'Relaxation and Luxury Lover') {
      personalizedPlan = ['club', 'restaurant_cafe', 'beach', 'winery'];
    }
    return personalizedPlan;
  }

  // Optional: Get saved plan
  Future<List<String>> getSavedPlan() async {
    return await _planServices.getUserPlan();
  }

  @override
  void onClose() {
    pageController.dispose();
    _messageTimer?.cancel();
    super.onClose();
  }
}
