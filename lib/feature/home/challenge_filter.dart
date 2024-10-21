import 'package:flutter/material.dart';

class ChallengeFilter extends StatefulWidget {
  final bool isSelected;
  final Function(bool) onChanged;

  const ChallengeFilter({
    Key? key,
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomSegmentControlState createState() => _CustomSegmentControlState();
}

class _CustomSegmentControlState extends State<ChallengeFilter> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => widget.onChanged(true),
                  child: Container(
                    child: Center(
                      child: Text(
                        '진행완료',
                        style: TextStyle(
                          fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => widget.onChanged(false),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        '진행중',
                        style: TextStyle(
                          fontWeight: !widget.isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: AnimatedAlign(
            duration: Duration(milliseconds: 100),
            alignment: widget.isSelected ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - 4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  widget.isSelected ? '진행완료' : '진행중',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
