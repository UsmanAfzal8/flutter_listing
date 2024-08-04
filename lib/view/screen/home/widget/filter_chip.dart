import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class FilterChipWidget extends StatefulWidget {
  final String filter;
  final String type;
  final Function(String, String) toggleFilter;

  const FilterChipWidget(this.filter, this.type, this.toggleFilter);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool _isHover = false;

  void _onEnter(bool isHovered) {
    setState(() {
      _isHover = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onEnter(true),
      onExit: (_) => _onEnter(false),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.lightGrayishCyanBackground,
          border: Border.all(color: AppColors.lightGrayishCyanBackground),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: customtext(widget.filter,
                  color: AppColors.desaturatedDarkCyan),
            ),
            Container(
                width: 20,
                decoration: BoxDecoration(
                    color: _isHover
                        ? AppColors.blackColor
                        : AppColors.desaturatedDarkCyan,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4))),
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      widget.toggleFilter(widget.filter, widget.type);
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.white,
                    ))),
          ],
        ),
      ),
    );
  }
}