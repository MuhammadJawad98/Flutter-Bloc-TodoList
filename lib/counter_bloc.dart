import 'dart:async';

import 'counter_event.dart';

class CounterBloc {
  int _counter = 0;
  final _counterStateController = StreamController<int>();

  StreamSink<int> get _inCounter => _counterStateController.sink;

//for state exposing only a stream which outputs data
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();

//for events, exposing only a sink which is an input
  StreamSink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is Increment) {
      _counter++;
    } else {
      _counter--;
    }
    _inCounter.add(_counter);
  }
  void dispose(){
    _counterEventController.close();
    _counterStateController.close();
  }
}