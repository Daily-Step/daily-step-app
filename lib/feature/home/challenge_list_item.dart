import 'package:flutter/material.dart';
import '../../widgets/widget_progress_indicator.dart';

class ChallengeListItem extends StatelessWidget {
  final int index;
  final bool showAction;
  final ValueChanged<bool> onShowActionChanged;

  const ChallengeListItem({
    super.key,
    required this.index,
    required this.showAction,
    required this.onShowActionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! < 0) {
          onShowActionChanged(true);
        } else if (details.primaryDelta! > 0) {
          onShowActionChanged(false);
        }
      },
      child: Stack(
        children: [
          if (showAction) const ActionButtons(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(
              showAction ? -100.0 : 0.0,
              0,
              0,
            ),
            child: ListTile(
              leading: WProgressIndicator(
                percentage: (index + 1) * 25,
              ),
              title: Text('Task ${index + 1}'),
              subtitle: const Text('2024.09.29~2024.11.29'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.check, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}