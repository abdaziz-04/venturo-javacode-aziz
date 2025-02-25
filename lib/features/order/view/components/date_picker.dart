import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class DatePicker extends StatefulWidget {
  final void Function(DateTimeRange) onChanged;
  final DateTimeRange selectedDate;

  const DatePicker({
    Key? key,
    required this.onChanged,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTimeRange _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  void didUpdateWidget(covariant DatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _selectedDate = widget.selectedDate;
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2028),
    );

    if (picked != null) {
      widget.onChanged(picked);
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String rangeText =
        '${DateFormat('yyyy-MM-dd').format(_selectedDate.start)} - '
        '${DateFormat('yyyy-MM-dd').format(_selectedDate.end)}';

    return InkWell(
      onTap: () => _selectDateRange(context),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: ColorStyle.imgBg,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.teal),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              rangeText,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.calendar_month,
              color: Colors.teal,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
