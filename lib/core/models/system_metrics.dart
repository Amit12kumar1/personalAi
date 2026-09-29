class SystemMetrics {
  final double cpuUsage; // 0.0 - 100.0
  final double ramUsage; // 0.0 - 100.0
  final int batteryLevel; // 0 - 100
  final bool isCharging;
  final String networkStatus;
  final int latencyMs;

  const SystemMetrics({
    required this.cpuUsage,
    required this.ramUsage,
    required this.batteryLevel,
    required this.isCharging,
    required this.networkStatus,
    required this.latencyMs,
  });

  factory SystemMetrics.initial() {
    return const SystemMetrics(
      cpuUsage: 18.4,
      ramUsage: 42.1,
      batteryLevel: 94,
      isCharging: true,
      networkStatus: 'SECURE LINK (5G/Wi-Fi)',
      latencyMs: 24,
    );
  }
}
