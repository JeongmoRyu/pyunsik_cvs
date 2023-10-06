class CombinationSimple {
  final int combinationId;
  final String combinationName;
  final int totalPrice;
  final int totalKcal;

  CombinationSimple({
    required this.combinationId,
    required this.combinationName,
    required this.totalPrice,
    required this.totalKcal,
  });

  factory CombinationSimple.fromJson(Map<String, dynamic> json) {
    return CombinationSimple(
      combinationId: json['combinationId'],
      combinationName: json['combinationName'],
      totalPrice: json['totalPrice'],
      totalKcal: json['totalKcal'],
    );
  }
}
