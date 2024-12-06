import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class WDateScrollPicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const WDateScrollPicker({
    Key? key,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<WDateScrollPicker> createState() => _WDateScrollPickerState();
}

class _WDateScrollPickerState extends State<WDateScrollPicker> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ScrollDatePicker(
          selectedDate: _selectedDate,
          locale: const Locale('ko'),
          options: DatePickerOptions(itemExtent: 40),
          scrollViewOptions: DatePickerScrollViewOptions(
            year: ScrollViewDetailOptions(
              label: '년',
              margin: const EdgeInsets.only(right: 14),
              textStyle: TextStyle(fontSize: pickerFontSize),
              selectedTextStyle: TextStyle(fontSize: pickerFontSize),
            ),
            month: ScrollViewDetailOptions(
              label: '월',
              margin: const EdgeInsets.only(right: 14),
              textStyle: TextStyle(fontSize: pickerFontSize),
              selectedTextStyle: TextStyle(fontSize: pickerFontSize),
            ),
            day: ScrollViewDetailOptions(
              label: '일',
              textStyle: TextStyle(fontSize: pickerFontSize),
              selectedTextStyle: TextStyle(fontSize: pickerFontSize),
            ),
          ),
          onDateTimeChanged: (DateTime value) {
            setState(() {
              _selectedDate = value;
            });
            widget.onDateSelected(value);
          },
        ),
      ),
    );
  }
}
