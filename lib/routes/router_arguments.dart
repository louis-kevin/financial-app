import 'package:flutter/material.dart';

enum RouterTransitions { fade, normal }

typedef TransitionBuilder = Route Function(Widget page);

class RouteArguments {
  int id;
  dynamic model;
  RouterTransitions transitions;
  TransitionBuilder transitionBuilder;

  RouteArguments({
    this.id,
    this.transitions = RouterTransitions.normal,
    this.model,
    this.transitionBuilder,
  });
}
