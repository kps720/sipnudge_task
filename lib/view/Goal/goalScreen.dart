import 'package:sipnudge_task/import/custom_import.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Goals Screen",
        style: AppTextStyles.lexendRegular.copyWith(
          color: AppColors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
