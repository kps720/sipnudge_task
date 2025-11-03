import 'package:sipnudge_task/import/custom_import.dart';
import 'package:sipnudge_task/view/bottom_nav/controller/bottomNav_controller.dart';

class FancyBottomNavBar extends StatelessWidget {
  const FancyBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());

    final List<Widget> pages = [
      const HomeScreen(),
      const AnalysisScreen(),
      const GoalsScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          ///  Active Page
          Obx(() => pages[controller.currentIndex.value]),

          ///  Bottom Navbar Overlay Positioned
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(child: const BottomNavBar()),
          ),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final BottomNavController controller = Get.find<BottomNavController>();

  final List<Map<String, dynamic>> items = [
    {"icon": Icons.home_filled, "label": "Home"},
    {"icon": Icons.bar_chart_rounded, "label": "Analysis"},
    {"icon": Icons.emoji_events_rounded, "label": "Goals"},
    {"icon": Icons.settings_rounded, "label": "Settings"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      padding: EdgeInsets.all(1.5.sp),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(4.sp, 4.sp),
            blurRadius: 30.r,
            spreadRadius: 2.r,
            color: AppColors.white.withOpacity(0.09),
          ),
        ],
        gradient: LinearGradient(
          colors: [AppColors.navBgBorder2, AppColors.navBgBorder1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(44.r),
      ),
      child: Container(
        height: 88.h,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.navBg,
          borderRadius: BorderRadius.circular(43.r),
        ),

        ///  Buttons Row
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = controller.currentIndex.value == index;

              return GestureDetector(
                onTap: () => controller.currentIndex.value = index,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 600), //  Slow fade
                  curve: Curves.easeInOut,
                  opacity: isSelected ? 1.0 : 0.5,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 500), //  Slow zoom
                    scale: isSelected ? 1.1 : 0.8,
                    curve: Curves.easeInOut,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.all(1.sp),
                      decoration: isSelected
                          ? BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.navBgBorder2,
                                  AppColors.navBgBorder1,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(50.r),
                            )
                          : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.h,
                          vertical: 8.w,
                        ),
                        decoration: isSelected
                            ? BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [AppColors.bG1, AppColors.bG2],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(50.r),
                              )
                            : BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                        child: SizedBox(
                          width: 65.w,
                          height: 45.h,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                items[index]["icon"],
                                color: AppColors.white,
                                size: 15.sp,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                items[index]["label"],
                                style: isSelected
                                    ? AppTextStyles.lexendRegular.copyWith(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      )
                                    : AppTextStyles.lexendLight.copyWith(
                                        color: AppColors.white,
                                        fontSize: 12.sp,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
