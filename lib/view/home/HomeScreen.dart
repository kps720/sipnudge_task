import 'package:sipnudge_task/import/custom_import.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Home Screen",
        style: AppTextStyles.lexendRegular.copyWith(fontSize: 24.sp),
      ),
    );
  }
}
