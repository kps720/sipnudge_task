import 'package:sipnudge_task/import/custom_import.dart';
import 'dart:math' as math;

class CustomTooltip extends StatelessWidget {
  final String percentage;

  const CustomTooltip({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          //  Outer rotated white-bordered shape
          Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              height: 42.h,
              width: 42.w,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.white, width: 1.w),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Container(
                height: 36.h,
                width: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.selectedBar,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(19),
                    topRight: Radius.circular(19),
                    bottomLeft: Radius.circular(19),
                  ),
                ),
              ),
            ),
          ),

          //  percentage value
          Positioned(
            top: 1.5.h,
            child: Container(
              height: 39.h,
              width: 39.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.selectedBar, width: 2.w),
              ),
              child: Center(
                child: Text(
                  percentage,
                  style: AppTextStyles.urbanistBold.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.greyistBlack,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
