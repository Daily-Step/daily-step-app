
extension MapWithIndex<T> on List<T> {
  Iterable<R> mapIndexed<R>(R Function(T value, int index) f) {
    return asMap().entries.map((entry) => f(entry.value, entry.key));
  }
}
