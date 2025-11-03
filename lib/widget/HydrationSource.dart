import 'package:sipnudge_task/import/custom_import.dart';

class HydrationSourceWidget extends StatelessWidget {
  const HydrationSourceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnalysisController>();

    return Obx(() {
      //  Dynamically calculate
      final water = controller.waterPercent.value;
      final food = 100 - water; // ensure total = 100%

      return Container(
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          color: AppColors.sourcebG,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.25),
              offset: Offset(5.sp, 10.sp),
              blurRadius: 5.sp,
              spreadRadius: 0.sp,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Hydration Source',
                  style: AppTextStyles.urbanistBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            spaceVertical15,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120.h,
                  width: 120.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SfCircularChart(
                        margin: EdgeInsets.zero,
                        series: <CircularSeries>[
                          //  WATER SLICE
                          DoughnutSeries<_HydrationData, String>(
                            dataSource: [
                              _HydrationData('Water', water, AppColors.water80),
                            ],
                            xValueMapper: (_HydrationData d, _) => d.source,
                            yValueMapper: (_HydrationData d, _) => d.percent,
                            pointShaderMapper: (datum, index, color, rect) {
                              return LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [AppColors.water2, AppColors.water1],
                              ).createShader(rect);
                            },
                            innerRadius: '80%',
                            radius: '100%',
                            startAngle: 290,
                            endAngle: (290 + (water * 3.6))
                                .toInt(), //  1% = 3.6°
                            cornerStyle: CornerStyle.bothCurve,
                          ),

                          //  FOOD SLICE (overlay, no gap)
                          DoughnutSeries<_HydrationData, String>(
                            dataSource: [
                              _HydrationData('Food', food, AppColors.foodGreen),
                            ],
                            xValueMapper: (_HydrationData d, _) => d.source,
                            yValueMapper: (_HydrationData d, _) => d.percent,
                            pointColorMapper: (_HydrationData d, _) => d.color,
                            innerRadius: '80%',
                            radius: '100%',
                            startAngle: (280 + (water * 3.6) - 2)
                                .toInt(), // slight overlap
                            endAngle: (300 + 360).toInt(),
                            cornerStyle: CornerStyle.bothCurve,
                          ),
                        ],
                      ),

                      //  Center Text
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${(water + food).toInt()}%',
                            style: AppTextStyles.urbanistBold.copyWith(
                              color: AppColors.white,
                              fontSize: 24.sp,
                            ),
                          ),
                          spaceVertical5,
                          Text(
                            'Water Intake',
                            style: AppTextStyles.urbanistRegular.copyWith(
                              color: AppColors.white,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                spaceHorizontal20,

                //  Legends
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(
                      AppColors.water80,
                      'Water (${water.toInt()}%)',
                    ),
                    spaceVertical10,
                    _buildLegendItem(
                      AppColors.foodGreen,
                      'Food (${food.toInt()}%)',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        spaceHorizontal8,
        Text(
          text,
          style: AppTextStyles.urbanistSemiBold.copyWith(
            color: AppColors.white,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}

class _HydrationData {
  final String source;
  final double percent;
  final Color color;

  _HydrationData(this.source, this.percent, this.color);
}
