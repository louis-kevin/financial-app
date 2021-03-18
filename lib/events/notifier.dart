import 'package:event_bus/event_bus.dart';

class Notifier {
  static Notifier _instance;

  factory Notifier({EventBus eventBus}) {
    _instance ??= Notifier._internalConstructor(eventBus);
    return _instance;
  }

  Notifier._internalConstructor(this.eventBus);

  EventBus eventBus;

  listen<T>(callback) {
    eventBus ??= EventBus();
    eventBus.on<T>().listen(callback);
    return eventBus;
  }

  fire(dynamic event) {
    eventBus ??= EventBus();
    eventBus.fire(event);
    return eventBus;
  }
}
