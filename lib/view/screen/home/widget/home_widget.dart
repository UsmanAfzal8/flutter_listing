import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_listing/view/screen/home/widget/filter_chip.dart';
import 'package:flutter_listing/view/screen/home/widget/hover_card.dart';
import 'dart:convert';
import '../../../../model/job_model.dart';
import '../../../../utilis/utilis.dart';
import '../../../theme/theme.dart';
import '../../../widgets/custom_padding.dart';
import '../../../widgets/widgets.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key, required this.screenEnum});
  final ScreenEnum screenEnum;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late Future<List<JobModel>> futureJobs;
  List<String> selectedLanguages = [];
  List<String> selectedTools = [];

  @override
  void initState() {
    super.initState();
    futureJobs = fetchJobs();
  }

  Future<List<JobModel>> fetchJobs() async {
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => JobModel.fromJson(json)).toList();
  }

  void _toggleFilter(String filter, String type) {
    setState(() {
      if (type == 'language') {
        if (selectedLanguages.contains(filter)) {
          selectedLanguages.remove(filter);
        } else {
          selectedLanguages.add(filter);
        }
      } else if (type == 'tool') {
        if (selectedTools.contains(filter)) {
          selectedTools.remove(filter);
        } else {
          selectedTools.add(filter);
        }
      }
    });
  }

  List<JobModel> _filterJobs(List<JobModel> jobs) {
    if (selectedLanguages.isEmpty && selectedTools.isEmpty) {
      return jobs;
    }
    return jobs.where((job) {
      final languageMatch = selectedLanguages.isEmpty ||
          selectedLanguages.any((lang) => job.languages.contains(lang));
      final toolMatch = selectedTools.isEmpty ||
          selectedTools.any((tool) => job.tools.contains(tool));
      return languageMatch && toolMatch;
    }).toList();
  }

  bool _isClearHovered = false;

  void _onEnter(bool isHovered) {
    setState(() {
      _isClearHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrayishCyanBackground,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                CustomSvgImage(
                  svgPath: widget.screenEnum == ScreenEnum.mobile
                      ? AppImages.mobileBackground
                      : AppImages.desktopBackground,
                  height: 100,
                  width: double.infinity,
                ),
                if (selectedLanguages.isNotEmpty || selectedTools.isNotEmpty)
                  Padding(
                    padding: CustomPadding(
                        screenEnum: widget.screenEnum,
                        context: context,
                        bottom: 0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: [
                                ...selectedLanguages.map((lang) =>
                                    FilterChipWidget(
                                        lang, 'language', _toggleFilter)),
                                ...selectedTools.map((tool) => FilterChipWidget(
                                    tool, 'tool', _toggleFilter)),
                              ],
                            ),
                          ),
                          _clearFiltersChip()
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<JobModel>>(
                future: futureJobs,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No jobs available'));
                  }

                  final jobs = _filterJobs(snapshot.data!);
                  return Padding(
                    padding: CustomPadding(
                      screenEnum: widget.screenEnum,
                      context: context,
                      bottom: 0,
                    ),
                    child: ListView.builder(
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                        return HoverCardWidget(
                          job: jobs[index],
                          onFilterSelected: _toggleFilter,
                          screenEnum: widget.screenEnum,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _clearFiltersChip() {
    return MouseRegion(
      onEnter: (_) => _onEnter(true),
      onExit: (_) => _onEnter(false),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedLanguages.clear();
            selectedTools.clear();
          });
        },
        child: customtext('clear',
            color: AppColors.desaturatedDarkCyan,
            decoration: _isClearHovered
                ? TextDecoration.underline
                : TextDecoration.none),
      ),
    );
  }
}
