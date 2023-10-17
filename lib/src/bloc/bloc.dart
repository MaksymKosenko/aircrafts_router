import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

void _noop(dynamic _) {}

abstract class Bloc {
  final _subscription = CompositeSubscription();

  /// Subscribes to the stream and adds the subscription to a list of automatically disposed subscriptions.
  @protected
  void subscribe<T>(Stream<T> stream,
      {void Function(T data)? onData,
      void Function(dynamic error)? onError,
      void Function()? onDone,
      bool cancelOnError = false}) {
    _subscription.add(stream.listen(onData ?? _noop,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError));
  }

  /// Subscribes to the stream and adds the subscription to a list of automatically disposed subscriptions.
  /// Returns a [ValueStream] that can be exposed to the Bloc consumers.
  @protected
  ValueStream<T> publishStream<T>(Stream<T> stream,
      {required T initialValue,
      void Function(T data)? onData,
      void Function(dynamic error)? onError,
      void Function()? onDone,
      bool cancelOnError = false}) {
    final observable = stream.publishValueSeeded(initialValue).autoConnect();
    _subscription.add(observable.listen(onData ?? _noop,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError));
    return observable;
  }

  @protected
  @mustCallSuper
  void dispose() {
    _subscription.dispose();
  }
}

typedef BlocBuilder<T extends Bloc> = T Function(BuildContext context);

void _disposer(BuildContext context, Bloc bloc) => bloc.dispose();

class BlocProvider<T extends Bloc> extends Provider<T> {
  BlocProvider({
    Key? key,
    required BlocBuilder<T> builder,
    required Widget child,
  }) : super(key: key, create: builder, dispose: _disposer, child: child);

  static T? of<T extends Bloc>(BuildContext context,
      {bool throwIfNotFound = true}) {
    if (throwIfNotFound) {
      return Provider.of<T>(context, listen: false);
    } else {
      try {
        return Provider.of<T>(context, listen: false);
      } on Object catch (_) {
        return null;
      }
    }
  }
}

class MultiBlocProvider extends MultiProvider {
  MultiBlocProvider({
    Key? key,
    required List<BlocProvider> providers,
    required Widget child,
  }) : super(key: key, providers: providers, child: child);
}
