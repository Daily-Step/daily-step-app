import 'package:flutter/material.dart';

class WScrollPickerModal extends StatefulWidget {
  final int value;
  final Function(int) onSelected;

  const WScrollPickerModal({
    Key? key,
    required this.value,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<WScrollPickerModal> createState() => _WeekPickerModalState();
}

class _WeekPickerModalState extends State<WScrollPickerModal> {
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(
      initialItem: widget.value - 1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: ListWheelScrollView.useDelegate(
                    controller: _controller,
                    itemExtent: 50,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 4,
                      builder: (context, index) {
                        return InkWell(
                          onTap: () => widget.onSelected(index),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 24,
                                color: _controller.selectedItem == index
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Text(
                  '주',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}