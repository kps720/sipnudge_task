import 'dart:math';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AnalysisController extends GetxController {
  ///  Static Weekly Labels
  final List<String> weekDays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  ///  Selected view (Weekly / Monthly / Yearly)
  final selectedView = "Weekly".obs;

  ///  Date Range Display Text
  final dateRangeText = "".obs;

  ///  Start and End Dates
  late DateTime startDate;
  late DateTime endDate;

  ///  Chart Data Values
  final weeklyValues = <double>[].obs;
  final monthlyValues = <double>[].obs;
  final yearlyValues = <double>[].obs;

  ///  Hydration Data
  var waterPercent = 80.0.obs;
  var foodPercent = 20.0.obs;

  ///  2025 range limits
  final DateTime yearStart = DateTime(2025, 1, 1);
  final DateTime yearEnd = DateTime(2025, 12, 31);
  late DateTime today;

  ///  Arrow animation states
  var isNavigating = false.obs;
  var lastArrow = "".obs; // "forward" or "backward"

  @override
  void onInit() {
    super.onInit();
    today = DateTime.now();
    _setInitialRange();
    _generateAllChartData();
    _generateHydrationData();
  }

  ///  Initial setup
  void _setInitialRange() {
    today = DateTime.now();
    if (today.year != 2025) {
      today = DateTime(2025, 11, 2); // fallback (for testing)
    }

    startDate = today.subtract(Duration(days: today.weekday - 1));
    endDate = startDate.add(const Duration(days: 6));
    if (endDate.isAfter(today)) endDate = today;

    _updateDateRangeText();
  }

  ///  View switch handler
  void onSegmentChanged(String view) {
    selectedView.value = view;

    switch (view) {
      case "Weekly":
        _setWeeklyRange();
        break;
      case "Monthly":
        _setMonthlyRange();
        break;
      case "Yearly":
        _setYearlyRange();
        break;
    }

    _updateDateRangeText();
    _generateAllChartData();
    _generateHydrationData();
  }

  ///  Navigation (Previous / Next)
  void goToPrevious() {
    _animateArrow("backward");

    DateTime newStart = startDate;
    DateTime newEnd = endDate;

    switch (selectedView.value) {
      case "Weekly":
        newStart = startDate.subtract(const Duration(days: 7));
        newEnd = endDate.subtract(const Duration(days: 7));
        break;

      case "Monthly":
        newStart = DateTime(startDate.year, startDate.month - 1, 1);
        newEnd = DateTime(newStart.year, newStart.month + 1, 0);
        break;

      case "Yearly":
        newStart = DateTime(startDate.year - 1, 1, 1);
        newEnd = DateTime(newStart.year, 12, 31);
        break;
    }

    if (newStart.isBefore(yearStart)) return;

    startDate = newStart;
    endDate = newEnd;
    if (endDate.isAfter(today)) endDate = today;

    _updateDateRangeText();
    _generateAllChartData();
    _generateHydrationData();
  }

  void goToNext() {
    _animateArrow("forward");

    DateTime newStart = startDate;
    DateTime newEnd = endDate;

    switch (selectedView.value) {
      case "Weekly":
        newStart = startDate.add(const Duration(days: 7));
        newEnd = endDate.add(const Duration(days: 7));
        break;

      case "Monthly":
        newStart = DateTime(startDate.year, startDate.month + 1, 1);
        newEnd = DateTime(newStart.year, newStart.month + 1, 0);
        break;

      case "Yearly":
        newStart = DateTime(startDate.year + 1, 1, 1);
        newEnd = DateTime(newStart.year, 12, 31);
        break;
    }

    if (newStart.isAfter(today) || newEnd.isAfter(today)) return;

    startDate = newStart;
    endDate = newEnd;
    if (endDate.isAfter(today)) endDate = today;

    _updateDateRangeText();
    _generateAllChartData();
    _generateHydrationData();
  }

  ///  Animate arrow icons
  void _animateArrow(String direction) {
    lastArrow.value = direction;
    isNavigating.value = true;
    Future.delayed(const Duration(milliseconds: 300), () {
      isNavigating.value = false;
    });
  }

  ///  Update top date text
  void _updateDateRangeText() {
    switch (selectedView.value) {
      case "Weekly":
        dateRangeText.value =
            "${DateFormat('MMM d').format(startDate)} – ${DateFormat('MMM d, yyyy').format(endDate)}";
        break;
      case "Monthly":
        dateRangeText.value = DateFormat('MMMM yyyy').format(startDate);
        break;
      case "Yearly":
        dateRangeText.value = DateFormat('yyyy').format(startDate);
        break;
    }
  }

  ///  Range setters
  void _setWeeklyRange() {
    startDate = today.subtract(Duration(days: today.weekday - 1));
    endDate = startDate.add(const Duration(days: 6));
    if (endDate.isAfter(today)) endDate = today;
  }

  void _setMonthlyRange() {
    startDate = DateTime(today.year, today.month, 1);
    endDate = today;
  }

  void _setYearlyRange() {
    startDate = DateTime(2025, 1, 1);
    endDate = today;
  }

  ///  Random chart data generation
  void _generateAllChartData() {
    final random = Random();

    weeklyValues.value = List.generate(
      7,
      (_) => (random.nextInt(61) + 40).toDouble(),
    );

    monthlyValues.value = List.generate(
      endDate.day,
      (_) => (random.nextInt(61) + 40).toDouble(),
    );

    yearlyValues.value = List.generate(
      today.month,
      (_) => (random.nextInt(61) + 40).toDouble(),
    );
  }

  ///  Hydration Data
  void _generateHydrationData() {
    final random = Random();
    final water = random.nextInt(70) + 30; // 30–100%
    final food = 100 - water;

    waterPercent.value = water.toDouble();
    foodPercent.value = food.toDouble();
  }

  void updateHydration(double water, double food) {
    if (water + food == 100) {
      waterPercent.value = water;
      foodPercent.value = food;
    }
  }

  ///  Chart Data Getter (Dynamic)
  List<Map<String, dynamic>> get currentChartData {
    switch (selectedView.value) {
      case "Weekly":
        return List.generate(
          7,
          (i) => {"label": weekDays[i], "value": weeklyValues[i]},
        );
      case "Monthly":
        return List.generate(
          monthlyValues.length,
          (i) => {"label": "${i + 1}", "value": monthlyValues[i]},
        );
      case "Yearly":
        final months = [
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "Jun",
          "Jul",
          "Aug",
          "Sep",
          "Oct",
          "Nov",
          "Dec",
        ];
        return List.generate(
          today.month,
          (i) => {"label": months[i], "value": yearlyValues[i]},
        );
      default:
        return [];
    }
  }
}
