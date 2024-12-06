import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

class WScrollPicker extends StatefulWidget {
  final int value;
  final int childCount;
  final String? subText;
  final Function(int) onSelected;
  final List? childList;

  final Widget Function(BuildContext, int, bool)? itemBuilder;

  const WScrollPicker({
    Key? key,
    required this.value,
    required this.onSelected,
    required this.childCount,
    this.subText,
    this.childList,
    this.itemBuilder,
  }) : super(key: key);

  @override
  State<WScrollPicker> createState() => _WeekPickerModalState();
}

class _WeekPickerModalState extends State<WScrollPicker> {
  late FixedExtentScrollController _controller;
  late int _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
    _controller = FixedExtentScrollController(
      initialItem: widget.value,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemSelected(int value) {
    setState(() {
      _selectedValue = value;
    });
    widget.onSelected(value);
    Navigator.of(context).pop();
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
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification) {
                        setState(() {
                          _selectedValue = _controller.selectedItem + 1;
                        });
                      }
                      return true;
                    },
                    child: ListWheelScrollView.useDelegate(
                      controller: _controller,
                      itemExtent: 50,
                      perspective: 0.005,
                      diameterRatio: 1.2,
                      physics: const FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: widget.childCount,
                        builder: (context, index) {
                          return InkWell(
                            onTap: () => _onItemSelected(index),
                            child: Center(
                              child: widget.itemBuilder != null
                                  ? widget.itemBuilder!(
                                      context, index, _selectedValue == index)
                                  : Text(
                                      widget.childList != null
                                          ? '${widget.childList?[index]}'
                                          : '${index + 1}',
                                      style: TextStyle(
                                        fontSize: pickerFontSize,
                                        color: _selectedValue == index
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
                ),
                Text(
                  widget.subText != null ? widget.subText! : '',
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
