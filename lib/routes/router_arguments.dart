import 'package:flutter/material.dart';

enum RouterTransitions { fade, normal }

typedef TransitionBuilder = Route Function(Widget page);

class RouteArguments {
  int id;
  dynamic model;
  RouterTransitions transitions;
  TransitionBuilder transitionBuilder;
  Function state;

  RouteArguments({
    this.id,
    this.transitions = RouterTransitions.normal,
    this.model,
    this.transitionBuilder,
    this.state,
  });
}
