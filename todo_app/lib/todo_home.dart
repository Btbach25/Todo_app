import 'package:flutter/material.dart';
import 'package:todo_app/app_color.dart';
import 'package:todo_app/todayTask.dart'; 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, 
        fontFamily: 'Inter', 
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Map<String, dynamic>> inProgressTasks = [
      {
        "title": "Grocery shopping app design",
        "project": "Office Project",
        "icon": Icons.shopping_bag_outlined,
        "color": AppColors.cardBlueBackground,
        "progress": 0.6,
        "progressColor": AppColors.progressBlue,
      },
      {
        "title": "Uber Eats redesign challenge",
        "project": "Personal Project",
        "icon": Icons.person_outline,
        "color": AppColors.cardPinkBackground,
        "progress": 0.4,
        "progressColor": AppColors.progressOrange,
      },
      {
        "title": "Learning Machine Learing for final test",
        "project": "Study at school",
        "icon": Icons.book,
        "color": Colors.purpleAccent,
        "progress": 0.4,
        "progressColor": Colors.purpleAccent.shade100,
      },
  ];

  final List<Map<String, dynamic>> taskGroups = [
      {
        "title": "Office Project",
        "tasks": "23 Tasks",
        "icon": Icons.work_outline,
        "iconBgColor": Colors.pink.shade100,
        "iconColor": Colors.pink,
        "progress": 0.70
      },
      {
        "title": "Personal Project",
        "tasks": "30 Tasks",
        "icon": Icons.person_pin_outlined,
        "iconBgColor": Colors.blue.shade100,
        "iconColor": Colors.blue,
        "progress": 0.52
      },
      {
        "title": "Daily Study",
        "tasks": "30 Tasks",
        "icon": Icons.book_outlined,
        "iconBgColor": Colors.orange.shade100,
        "iconColor": Colors.orange,
        "progress": 0.87
      },
      {
        "title": "Doin something healthy!",
        "tasks": "29 Tasks",
        "icon": Icons.man,
        "iconBgColor": Colors.green.shade100,
        "iconColor": Colors.green,
        "progress": 0.87
      },
  ];



  int _selectedIndex = 0; 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodayTaskCard(progressPercent: 100),
            const SizedBox(height: 25),
            _buildSectionTitle("In Progress", inProgressTasks.length.toString()),
            const SizedBox(height: 15),
            _buildInProgressTasks(),
            const SizedBox(height: 25),
            _buildSectionTitle("Task Groups", taskGroups.length.toString()),
            const SizedBox(height: 15),
            _buildTaskGroups(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryPurple,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 70, 
      leading: const Padding(
        padding: EdgeInsets.only(left: 20.0, top: 8.0, bottom: 8.0),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
        ),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello!",
            style: TextStyle(color: AppColors.lightText, fontSize: 14),
          ),
          Text(
            "Livia Vaccaro",
            style: TextStyle(
                color: AppColors.darkText, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_outlined, color: AppColors.darkText, size: 28),
          onPressed: () {},
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildSectionTitle(String title, String count) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
              color: AppColors.darkText, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.lightPurpleBackground,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            count,
            style: const TextStyle(color: AppColors.primaryPurple, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _buildInProgressTasks() {
    return SizedBox(
      height: 160, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: inProgressTasks.length,
        itemBuilder: (context, index) {
          final task = inProgressTasks[index];
          return Container(
            width: 220, 
            margin: const EdgeInsets.only(right: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: task["color"],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(task["icon"], color: AppColors.primaryPurple.withOpacity(0.7), size: 20),
                    const SizedBox(width: 5),
                    Text(
                      task["project"],
                      style: TextStyle(color: AppColors.darkText.withOpacity(0.7), fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  task["title"],
                  style: const TextStyle(
                      color: AppColors.darkText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                LinearProgressIndicator(
                  value: task["progress"],
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(task["progressColor"]),
                  minHeight: 6, 
                  borderRadius: BorderRadius.circular(10), 
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTaskGroups() {
    
    return ListView.builder(
      shrinkWrap: true, 
      physics: const NeverScrollableScrollPhysics(), 
      itemCount: taskGroups.length,
      itemBuilder: (context, index) {
        final group = taskGroups[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: group["iconBgColor"],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(group["icon"], color: group["iconColor"], size: 28),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group["title"],
                      style: const TextStyle(
                          color: AppColors.darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      group["tasks"],
                      style: const TextStyle(color: AppColors.lightText, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      value: group["progress"],
                      strokeWidth: 5,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(group["iconColor"]),
                    ),
                  ),
                  Text(
                    "${(group["progress"] * 100).toInt()}%",
                    style: TextStyle(
                        color: group["iconColor"],
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white,
      elevation: 10, 
      child: SizedBox( 
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildBottomNavItem(Icons.home_filled, "Home", 0),
            _buildBottomNavItem(Icons.calendar_today_outlined, "Calendar", 1),
            const SizedBox(width: 40), // Khoảng trống cho FAB
            _buildBottomNavItem(Icons.document_scanner_outlined, "Docs", 2), // Giả sử icon này
            _buildBottomNavItem(Icons.person_outline, "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return IconButton(
      icon: Icon(icon, color: isSelected ? AppColors.primaryPurple : AppColors.lightText, size: 28),
      onPressed: () => _onItemTapped(index),
    );
  }
}