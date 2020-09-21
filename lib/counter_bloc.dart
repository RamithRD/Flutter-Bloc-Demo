import 'dart:async';

enum CounterAction { Increment, Decrement, Reset }

class CounterBloc{

  //State variable for counter
  int counter;

  final _stateStreamController = StreamController<int>();
  StreamSink<int> get _counterSink => _stateStreamController.sink;
  //public stream which the UI listens for changes
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();
  //public stream where the UI add Counter Actions
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get _eventStream => _eventStreamController.stream;

  CounterBloc(){
    counter = 0;

    //Listen for user action for counter (increment, decrement or reset) using a stream
    _eventStream.listen((event) {
      if (event == CounterAction.Increment)
        counter++;
      else if (event == CounterAction.Decrement)
        counter--;
      else if (event == CounterAction.Reset)
        counter = 0;

      //add the latest counter value to sink which will then update the event stream
      _counterSink.add(counter);
    });

  }

  disposeCounterStreams(){
    _stateStreamController.close();
    _eventStreamController.close();
  }

}