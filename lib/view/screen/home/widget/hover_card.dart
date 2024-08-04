import 'package:flutter/material.dart';
import 'package:flutter_listing/view/widgets/custom_padding.dart';

import '../../../../model/job_model.dart';
import '../../../../utilis/utilis.dart';
import '../../../theme/theme.dart';
import '../../../widgets/widgets.dart';

class HoverCardWidget extends StatefulWidget {
  final JobModel job;
  final Function(String, String) onFilterSelected;
  final ScreenEnum screenEnum;

  const HoverCardWidget(
      {Key? key,
      required this.job,
      required this.onFilterSelected,
      required this.screenEnum})
      : super(key: key);

  @override
  _HoverCardWidgetState createState() => _HoverCardWidgetState();
}

class _HoverCardWidgetState extends State<HoverCardWidget> {
  bool _isHovered = false;

  void _onEnter(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = getMaxWidth(context);
    return MouseRegion(
      onEnter: (_) => _onEnter(true),
      onExit: (_) => _onEnter(false),
      child: Card(
        margin: EdgeInsets.all(widget.screenEnum == ScreenEnum.mobile ? 24 : 8),
        color: AppColors.white,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (widget.screenEnum == ScreenEnum.mobile)
              Positioned(
                top: -20,
                left: 20,
                child: CustomSvgImage(
                  svgPath: widget.job.logo,
                  height: 50,
                  width: 50,
                ),
              ),
            if (_isHovered)
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  width: 8.0,
                  color: AppColors.desaturatedDarkCyan,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  if (widget.screenEnum != ScreenEnum.mobile)
                    CustomSvgImage(
                      svgPath: widget.job.logo,
                      height: 100,
                      width: 100,
                    ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.screenEnum == ScreenEnum.mobile)
                        SizedBox(height: 20),
                      Row(
                        children: [
                          customtext(widget.job.company,
                              fontWeight: FontWeight.w700,
                              color: AppColors.desaturatedDarkCyan),
                          SizedBox(width: 10),
                          if (widget.job.isNew)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.desaturatedDarkCyan,
                              ),
                              child: customtext('New!',
                                  fontWeight: FontWeight.w700,
                                  color:
                                      AppColors.lightGrayishCyanFilterTablets,
                                  size: 12),
                            ),
                          SizedBox(width: 10),
                          if (widget.job.featured)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.blackColor,
                              ),
                              child: customtext('Featured',
                                  fontWeight: FontWeight.w700,
                                  color:
                                      AppColors.lightGrayishCyanFilterTablets,
                                  size: 12),
                            ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      customtext(widget.job.position,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w700),
                      SizedBox(height: 8.0),
                      customtext(
                          '${widget.job.postedAt} . ${widget.job.contract} . ${widget.job.location}',
                          color: AppColors.darkGrayishCyan.withOpacity(0.7)),
                      if (widget.screenEnum == ScreenEnum.mobile) ...{
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.0),
                            // Divider(
                            //   color: AppColors.darkGrayishCyan,
                            //   thickness: 2,
                            //   height: 2,
                            // ),
                            Container(
                              height: 1,
                              width: width * 0.7,
                              color: AppColors.darkGrayishCyan.withOpacity(0.3),
                            ),
                            SizedBox(height: 8.0),
                            Wrap(
                              spacing: 8.0,
                              children: [
                                ...widget.job.languages.map((lang) =>
                                    _languageToolWidget(lang, 'language')),
                                ...widget.job.tools.map((tool) =>
                                    _languageToolWidget(tool, 'tool')),
                              ],
                            )
                          ],
                        ),
                      },
                    ],
                  ),
                  Spacer(),
                  if (widget.screenEnum != ScreenEnum.mobile)
                    Wrap(
                      spacing: 8.0,
                      children: [
                        ...widget.job.languages.map(
                            (lang) => _languageToolWidget(lang, 'language')),
                        ...widget.job.tools
                            .map((tool) => _languageToolWidget(tool, 'tool')),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageToolWidget(String filter, String type) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.lightGrayishCyanBackground,
        border: Border.all(color: AppColors.lightGrayishCyanBackground),
      ),
      child: GestureDetector(
        onTap: () => widget.onFilterSelected(filter, type),
        child: customtext(filter, color: AppColors.desaturatedDarkCyan),
      ),
    );
  }
}
