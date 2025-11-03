import 'package:sipnudge_task/import/custom_import.dart';

class CustomWeeklyBarChartCard extends StatefulWidget {
  const CustomWeeklyBarChartCard({super.key});

  @override
  State<CustomWeeklyBarChartCard> createState() =>
      _CustomWeeklyBarChartCardState();
}

class _CustomWeeklyBarChartCardState extends State<CustomWeeklyBarChartCard>
    with SingleTickerProviderStateMixin {
  int selectedBarIndex = -1;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnalysisController>();

    final List<String> labels = controller.weekDays;

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(4.sp, 4.sp),
              blurRadius: 6.r,
              spreadRadius: 0.r,
            ),
          ],
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: AppColors.dateFilterBG,
          elevation: 4.sp,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.bG1, AppColors.sourcebG],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------- HEADER ----------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Drink Completion",
                        style: AppTextStyles.urbanistBold.copyWith(
                          fontSize: 20.sp,
                          color: AppColors.white,
                        ),
                      ),
                      ChartModeSwitchButton(
                        onBarSelected: () => print("Weekly Bar Selected"),
                        onLineSelected: () => print("Weekly Line Selected"),
                      ),
                    ],
                  ),

                  spaceVertical20,

                  // ---------- CHART AREA ----------
                  SizedBox(
                    height: 300.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // ---------- LEFT SCALE ----------
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(6, (i) {
                            final percent = (100 - i * 20);
                            return Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: Text(
                                "$percent%",
                                style: AppTextStyles.urbanistMedium.copyWith(
                                  color: AppColors.lowWhite,
                                  fontSize: 14.sp,
                                ),
                              ),
                            );
                          }),
                        ),

                        spaceHorizontal10,

                        // ---------- BAR AREA ----------
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: List.generate(
                                controller.weeklyValues.length,
                                (index) {
                                  final isSelected =
                                      selectedBarIndex == index; // selection
                                  final barHeight =
                                      (controller.weeklyValues[index].clamp(
                                            0,
                                            100,
                                          ) /
                                          100) *
                                      240.h;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedBarIndex = isSelected
                                            ? -1
                                            : index;
                                      });
                                    },
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            AnimatedContainer(
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              width: 34.w,
                                              height: barHeight,
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? AppColors.selectedBar
                                                    : AppColors.unSelectedBar,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                    100.r,
                                                  ),
                                                  topRight: Radius.circular(
                                                    100.r,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            spaceVertical6,
                                            Text(
                                              labels[index],
                                              style: AppTextStyles
                                                  .urbanistMedium
                                                  .copyWith(
                                                    color: AppColors.lowWhite,
                                                    fontSize: 14.sp,
                                                    letterSpacing: 0.2.w,
                                                  ),
                                            ),
                                          ],
                                        ),

                                        // Tooltip
                                        Positioned(
                                          bottom: barHeight + 35.h,
                                          child: AnimatedOpacity(
                                            opacity: isSelected ? 1.0 : 0.0,
                                            duration: const Duration(
                                              milliseconds: 250,
                                            ),
                                            curve: Curves.easeInOut,
                                            child: isSelected
                                                ? CustomTooltip(
                                                    percentage:
                                                        "${controller.weeklyValues[index].toInt()}%",
                                                  )
                                                : const SizedBox.shrink(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
