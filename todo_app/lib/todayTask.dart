import 'package:flutter/material.dart';

class TodayTaskCard extends StatelessWidget {
  final int progressPercent; 

  const TodayTaskCard({
    super.key,
    required this.progressPercent,
  }) : assert(progressPercent >= 0 && progressPercent <= 100,
            'progressPercent must be between 0 and 100');

  Map<String, dynamic> _getCardStyle() {
    String message;
    List<Color> gradientColors;
    Color buttonForegroundColor;
    String buttonText = "View Task";

    if (progressPercent == 100) {
      message = "All tasks completed today! Well done!";
      gradientColors = [const Color(0xFF4CAF50), const Color(0xFF388E3C)]; 
      buttonForegroundColor = const Color(0xFF388E3C);
      buttonText = "See Summary";
    } else if (progressPercent >= 51) {
      message = "Your today's task almost done!";
      gradientColors = [const Color(0xFF8A72FF), const Color(0xFF6B4EFF)];
      buttonForegroundColor = const Color(0xFF7B61FF); 
    } else { // 0 - 50%
      message = "Keep going, you've got this!";
      gradientColors = [const Color(0xFFFFA726), const Color(0xFFFB8C00)]; 
      buttonForegroundColor = const Color(0xFFE65100); 
    }
    return {
      'message': message,
      'gradientColors': gradientColors,
      'buttonForegroundColor': buttonForegroundColor,
      'buttonText': buttonText,
    };
  }

  @override
  Widget build(BuildContext context) {
    final styles = _getCardStyle();
    final double progressValue = progressPercent / 100.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: styles['gradientColors'] as List<Color>,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [ 
          BoxShadow(
            color: (styles['gradientColors'] as List<Color>)[1].withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ]
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  styles['message'] as String,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  softWrap: true, 
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: styles['buttonForegroundColor'] as Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    styles['buttonText'] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: progressValue,
                  strokeWidth: 8,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeCap: StrokeCap.round, 
                ),
              ),
              Text(
                "$progressPercent%",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}