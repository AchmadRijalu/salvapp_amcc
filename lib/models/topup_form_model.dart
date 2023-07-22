class TopupFormModel {
  final String? amount;

  TopupFormModel({
    this.amount,
  });

  TopupFormModel copyWith({
    String? amount,
    String? pin,
    String? paymentMethodCode,
  }) =>
      TopupFormModel(
        amount: amount ?? this.amount,
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
      };
}
