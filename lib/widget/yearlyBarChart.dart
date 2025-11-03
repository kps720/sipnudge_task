import 'package:sipnudge_task/import/custom_import.dart';

class CustomYearlyBarChartCard extends StatefulWidget {
  const CustomYearlyBarChartCard({super.key});

  @override
  State<CustomYearlyBarChartCard> createState() =>
      _CustomYearlyBarChartCardState();
}

class _CustomYearlyBarChartCardState extends State<CustomYearlyBarChartCard> {
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
                        onBarSelected: () => print("Yearly Bar Selected"),
                        onLineSelected: () => print("Yearly Line Selected"),
                      ),
                    ],
                  ),

                  spaceVertical20,

                  // ---------- CHART AREA ----------
                  SizedBox(
                    height: 345.h,
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
                                    final chartItem =
                                        controller.currentChartData[index];
                                    final value = (chartItem["value"] as double)
                                        .clamp(0, 100);
                                    final label = chartItem["label"] as String;
                                    final barHeight = (value / 100) * 265.h;
                                    final isSelected =
                                        selectedBarIndex == index;

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
                                          horizontal: 8.w,
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
                                            // ---------- Tooltip ----------
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
