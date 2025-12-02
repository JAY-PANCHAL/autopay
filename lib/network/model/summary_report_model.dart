class SummaryReportModel {
  final String vehicleNo;
  final double distanceKm;
  final String engineHours;
  final String runningHours;
  final String stopHours;
  final String idleHours;

  final String startLocation;
  final String endLocation;

  final String startingKm;
  final String endingKm;

  final double avgSpeed;
  final double maxSpeed;
  final double fuelSpent;

  SummaryReportModel({
    required this.vehicleNo,
    required this.distanceKm,
    required this.engineHours,
    required this.runningHours,
    required this.stopHours,
    required this.idleHours,
    required this.startLocation,
    required this.endLocation,
    required this.startingKm,
    required this.endingKm,
    required this.avgSpeed,
    required this.maxSpeed,
    required this.fuelSpent,
  });
}
