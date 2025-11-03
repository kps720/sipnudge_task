import 'package:sipnudge_task/import/custom_import.dart';

class DateRangeHeaderWidget extends StatelessWidget {
  const DateRangeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnalysisController>();

    return Card(
      elevation: 0,
      color: AppColors.dateFilterBG,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(color: AppColors.white.withOpacity(0.4), width: 1.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        child: Obx(
          () => Column(
            children: [
              // Segment Buttons
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.all(2.w),
                child: Row(
                  children: [
                    _buildSegment("Weekly", controller),
                    _buildSegment("Monthly", controller),
                    _buildSegment("Yearly", controller),
                  ],
                ),
              ),

              spaceVertical15,

              // Navigation Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous
                  InkWell(
                    onTap: controller.goToPrevious,
                    child: Obx(
                      () => AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity:
                            controller.lastArrow.value == "backward" &&
                                controller.isNavigating.value
                            ? 0.6
                            : 1.0,
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20.sp,
                          color:
                              controller.lastArrow.value == "backward" &&
                                  controller.isNavigating.value
                              ? AppColors.white
                              : AppColors.forwardArrow,
                        ),
                      ),
                    ),
                  ),

                  // Date Text
                  Text(
                    controller.dateRangeText.value,
                    style: AppTextStyles.urbanistSemiBold.copyWith(
                      color: AppColors.white,
                    ),
                  ),

                  // Next
                  InkWell(
                    onTap: controller.goToNext,
                    child: Obx(
                      () => AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity:
                            controller.lastArrow.value == "forward" &&
                                controller.isNavigating.value
                            ? 0.6
                            : 1.0,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                          color:
                              controller.lastArrow.value == "forward" &&
                                  controller.isNavigating.value
                              ? AppColors.white
                              : AppColors.forwardArrow,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegment(String text, AnalysisController controller) {
    final bool isSelected = controller.selectedView.value == text;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.onSegmentChanged(text),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.weeklySelected : Colors.transparent,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Text(
            text,
            style: AppTextStyles.urbanistBold.copyWith(
              fontSize: 16.sp,
              color: isSelected
                  ? AppColors.white
                  : AppColors.weeklyUnSelectedText,
            ),
          ),
        ),
      ),
    );
  }
}
