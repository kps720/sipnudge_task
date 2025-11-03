import 'package:sipnudge_task/import/custom_import.dart';

class CustomMonthlyBarChartCard extends StatefulWidget {
  const CustomMonthlyBarChartCard({super.key});

  @override
  State<CustomMonthlyBarChartCard> createState() =>
      _CustomMonthlyBarChartCardState();
}

class _CustomMonthlyBarChartCardState extends State<CustomMonthlyBarChartCard> {
  int selectedBarIndex = -1;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnalysisController>();

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(4.sp, 4.sp),
              blurRadius: 6.r,
            ),
          ],
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Card(
          color: AppColors.dateFilterBG,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
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
                        onBarSelected: () => print("Monthly Bar Selected"),
                        onLineSelected: () => print("Monthly Line Selected"),
                      ),
                    ],
                  ),

                  spaceVertical20,

                  // ---------- CHART ----------
                  SizedBox(
                    height: 340.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // ---------- LEFT SCALE ----------
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(6, (i) {
                            final percent = 100 - i * 20;
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

                        // ---------- SCROLLABLE BARS ----------
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: List.generate(
                                  controller.currentChartData.length,
                                  (index) {
                                    final data =
                                        controller.currentChartData[index];
                                    final value = data['value'];
                                    final label = data['label'];
                                    final isSelected =
                                        selectedBarIndex == index;

                                    final maxBarHeight = 265.h;
                                    final barHeight =
                                        (value.clamp(0, 100) / 100) *
                                        maxBarHeight;

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedBarIndex =
                                              (selectedBarIndex == index)
                                              ? -1
                                              : index;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                        ),
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
                                                        : AppColors
                                                              .unSelectedBar,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                100.r,
                                                              ),
                                                          topRight:
                                                              Radius.circular(
                                                                100.r,
                                                              ),
                                                        ),
                                                  ),
                                                ),
                                                spaceVertical6,
                                                Text(
                                                  label,
                                                  style: AppTextStyles
                                                      .urbanistMedium
                                                      .copyWith(
                                                        color:
                                                            AppColors.lowWhite,
                                                        fontSize: 14.sp,
                                                        letterSpacing: 0.2.w,
                                                      ),
                                                ),
                                              ],
                                            ),

                                            // ---------- Animated Tooltip ----------
                                            Positioned(
                                              bottom: barHeight + 35.h,
                                              child: AnimatedOpacity(
                                                opacity: isSelected ? 1.0 : 0.0,
                                                duration: const Duration(
                                                  milliseconds: 300,
                                                ),
                                                curve: Curves.easeInOut,
                                                child: isSelected
                                                    ? CustomTooltip(
                                                        percentage:
                                                            "${value.toInt()}%",
                                                      )
                                                    : const SizedBox.shrink(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
