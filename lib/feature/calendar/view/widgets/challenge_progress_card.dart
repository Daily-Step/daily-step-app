import 'package:flutter/material.dart';

class ChallengeProgressCard extends StatelessWidget {
  final String title;
  final String period;
  final int progress;

  const ChallengeProgressCard({
    required this.title,
    required this.period,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    // 진행도에 따른 색상 설정
    Color progressColor;
    if (progress >= 51) {
      progressColor = Colors.blue;
    } else if (progress >= 21) {
      progressColor = Colors.green;
    } else {
      progressColor = Colors.yellow;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress / 100,
                  backgroundColor: Colors.grey[200],
                  color: progressColor, // 동적 색상 설정
                  strokeWidth: 8,
                ),
                Text(
                  '$progress',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  period,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              // 이벤트 처리
            },
          ),
        ],
      ),
    );
  }
}
