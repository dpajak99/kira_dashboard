class PaginatedListWrapper<T> {
  final int total;
  final List<T> items;

  const PaginatedListWrapper({
    required this.total,
    required this.items,
  });
}