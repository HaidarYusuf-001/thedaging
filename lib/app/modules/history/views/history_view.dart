import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryPage extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100, // Background hijau muda
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white, // Background putih untuk search bar
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: (query) {
                        controller.updateSearchQuery(query);
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari item...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // List items
            Expanded(
              child: Obx(() => ListView.separated(
                itemCount: controller.displayedItems.length,
                separatorBuilder: (context, index) => Divider(color: Colors.black),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.access_time, color: Colors.green), // Green icon
                    title: Text(
                      controller.displayedItems[index],
                      style: TextStyle(
                        color: Colors.green.shade800, // Greenish text color
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
