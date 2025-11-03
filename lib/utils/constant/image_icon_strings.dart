class AppImages {
  static final AppImages instance = AppImages._internal();

  factory AppImages() {
    return instance;
  }

  AppImages._internal();

  // images
  final String barIcon = "assets/icons/Chart.png";
  final String lineIcon = "assets/icons/Activity.png";
}
