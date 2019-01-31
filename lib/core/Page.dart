
class Page<T> {
  final List<T> data;
  final bool isEnd;

  Page(this.data, this.isEnd);

  factory Page.end() {
    return Page([], true);
  }
}