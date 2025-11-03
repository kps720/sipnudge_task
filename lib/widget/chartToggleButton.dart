import 'package:sipnudge_task/import/custom_import.dart';

enum ChartMode { bar, line }

class ChartModeSwitchButton extends StatefulWidget {
  final VoidCallback? onBarSelected;
  final VoidCallback? onLineSelected;

  const ChartModeSwitchButton({
    super.key,
    this.onBarSelected,
    this.onLineSelected,
  });

  @override
  State<ChartModeSwitchButton> createState() => _ChartModeSwitchButtonState();
}

class _ChartModeSwitchButtonState extends State<ChartModeSwitchButton> {
  ChartMode selected = ChartMode.bar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(2.sp, 2.sp),
            blurRadius: 4.r,
            // spreadRadius: 0,
          ),
        ],
      ),
      width: 80.w,
      height: 46.h,
      clipBehavior: Clip.antiAlias,
      child: SegmentedButton<ChartMode>(
        showSelectedIcon: false,
        segments: [
          ButtonSegment(
            value: ChartMode.bar,
            label: Center(
              child: Image.asset(
                AppImages.instance.barIcon,
                height: 20.h,
                width: 20.w,
                color: selected == ChartMode.bar
                    ? AppColors.white
                    : AppColors.forwardArrow,
              ),
            ),
          ),
          ButtonSegment(
            value: ChartMode.line,
            label: Center(
              child: Image.asset(
                AppImages.instance.lineIcon,
                height: 20.h,
                width: 20.w,
                color: selected == ChartMode.line
                    ? AppColors.white
                    : AppColors.forwardArrow,
              ),
            ),
          ),
        ],
        selected: {selected},
        onSelectionChanged: (newSelection) {
          setState(() {
            selected = newSelection.first;
          });
          if (selected == ChartMode.bar) {
            widget.onBarSelected?.call();
          } else {
            widget.onLineSelected?.call();
          }
        },
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          visualDensity: VisualDensity.compact,
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.graphSwitcher;
            }
            return AppColors.white;
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
          ),
          side: WidgetStateProperty.all(BorderSide.none),
        ),
      ),
    );
  }
}
