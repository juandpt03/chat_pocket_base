class ServiceLocator {
  ServiceLocator._internal();
  static final _instance = ServiceLocator._internal();

  factory ServiceLocator() => _instance;

  final Map<Type, dynamic> _services = {};

  void register<T>(T service) {
    _services[T] = service;
  }

  T get<T>() {
    final service = _services[T];
    if (service == null) {
      throw Exception('Service of type $T not found');
    }
    return service as T;
  }

  void unregister<T>() {
    _services.remove(T);
  }

  bool isRegistered<T>() {
    return _services.containsKey(T);
  }

  void clear() {
    _services.clear();
  }
}
