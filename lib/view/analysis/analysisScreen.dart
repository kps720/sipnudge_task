import 'package:sipnudge_task/import/custom_import.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AnalysisController controller = Get.put(AnalysisController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.bG1, AppColors.bG2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///  Date Range Header
                  const DateRangeHeaderWidget(),
                  spaceVertical15,

                  ///  Dynamic Chart (switches automatically)
                  if (controller.selectedView.value == 'Weekly')
                    const CustomWeeklyBarChartCard(),
                  if (controller.selectedView.value == 'Monthly')
                    const CustomMonthlyBarChartCard(),
                  if (controller.selectedView.value == 'Yearly')
                    const CustomYearlyBarChartCard(),

                  spaceVertical15,

                  /// Hydration Source Widget
                  const HydrationSourceWidget(),

                  spaceVertical100,
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
