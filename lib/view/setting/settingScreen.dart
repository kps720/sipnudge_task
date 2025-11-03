import 'package:sipnudge_task/import/custom_import.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            " Settings Screen",
            style: AppTextStyles.lexendRegular.copyWith(
              color: AppColors.white,
              fontSize: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}
