class TopupFormModel {
  final dynamic amount;

  TopupFormModel({
    this.amount,
  });

  TopupFormModel copyWith({
    String? amount,
  }) =>
      TopupFormModel(
        amount: amount ?? this.amount,
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
      };
}
