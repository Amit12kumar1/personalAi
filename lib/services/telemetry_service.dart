import 'dart:async';
import 'dart:math' as math;
import 'package:jarve_j/core/models/system_metrics.dart';

class TelemetryService {
  final _random = math.Random();
  Timer? _timer;
  
  final _metricsController = StreamController<SystemMetrics>.broadcast();
  Stream<SystemMetrics> get metricsStream => _metricsController.stream;

  SystemMetrics _current = SystemMetrics.initial();
  SystemMetrics get current => _current;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      // Simulate real-world fluctuation in system resources
      final cpu = (15.0 + _random.nextDouble() * 25.0);
      final ram = (40.0 + _random.nextDouble() * 10.0);
      final latency = 20 + _random.nextInt(15);

      _current = SystemMetrics(
        cpuUsage: cpu,
        ramUsage: ram,
        batteryLevel: _current.batteryLevel,
        isCharging: true,
        networkStatus: 'ONLINE • ENCRYPTED',
        latencyMs: latency,
      );
      _metricsController.add(_current);
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    stop();
    _metricsController.close();
  }
}
