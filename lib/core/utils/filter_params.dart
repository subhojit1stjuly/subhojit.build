class FilterParams {
  final String? category;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? searchQuery;
  final String? sortBy;

  FilterParams({
    this.category,
    this.startDate,
    this.endDate,
    this.searchQuery,
    this.sortBy,
  });
  FilterParams copyWith({
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    String? searchQuery,
    String? sortBy,
  }) {
    return FilterParams(
      category: category ?? this.category,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}
