import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/clubs_controller.dart';

class ClubsView extends GetView<ClubsController> {
  const ClubsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClubsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ClubsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
