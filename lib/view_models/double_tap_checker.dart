class DoubleTapChecker<T> {
  T? lastSelectedItem;
  DateTime lastTimestamp = DateTime.now();

  bool isDoubleTap(T item) {
    // if (lastSelectedItem == null || lastSelectedItem != item) {
    //   lastSelectedItem = item;
    //   lastTimestamp = DateTime.now();
    //   return false;
    // }

    final currentTimestamp = DateTime.now();
    final duration = currentTimestamp.difference(lastTimestamp).inMilliseconds;
    lastTimestamp = DateTime.now();
    print(
        "last: $lastTimestamp, current: $currentTimestamp, duration: $duration");
    return duration < 400;
  }
}
