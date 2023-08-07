class TambahIklanForm {
  final String? foodWasteCategoryId;
  final String? name;
  final String? additionalInformation;
  final int? price;
  final int? requestedWeight;
  final int? minimumWeight;
  final int? maximumWeight;

  TambahIklanForm({
    this.foodWasteCategoryId,
    this.name,
    this.additionalInformation,
    this.price,
    this.requestedWeight,
    this.minimumWeight,
    this.maximumWeight,
  });

  Map<String, dynamic> toJson() {
    return {
      "food_waste_category_id": foodWasteCategoryId,
      'name': name,
      'additional_information': additionalInformation,
      'price': price,
      'requested_weight': requestedWeight,
      'minimum_weight': minimumWeight,
      'maximum_weight': maximumWeight,
    };
  }

  TambahIklanForm copyWith({
    String? foodWasteCategoryId,
    String? userId,
    String? status,
    String? name,
    int? retrievalSystem,
    String? location,
    String? additionalInformation,
    int? price,
    int? requestedWeight,
    int? minimumWeight,
    int? maximumWeight,
  }) =>
      TambahIklanForm(
          foodWasteCategoryId: foodWasteCategoryId ?? this.foodWasteCategoryId,
          name: name ?? this.name,
          additionalInformation:
              additionalInformation ?? this.additionalInformation,
          price: price ?? this.price,
          requestedWeight: requestedWeight ?? this.requestedWeight,
          minimumWeight: minimumWeight ?? this.minimumWeight,
          maximumWeight: maximumWeight ?? this.maximumWeight);
}

// TambahIklanForm copyWith({
//     String? nama,
//     String? kategori,
//     String? sistem,
//     String? lokasi,
//     String? keinginan,
//     String? harga,
//     String? tanggalkadaluarsa,
//     String? beratdibutuhkan,
//     String? beratmin,
//     String? beratmaks,
//   }) =>
//       TambahIklanForm(
//         nama: nama ?? this.nama,
//         kategori: kategori ?? this.kategori,
//         sistem: sistem ?? this.sistem,
//         lokasi: lokasi ?? this.lokasi,
//         keinginan: keinginan ?? this.keinginan,
//         tanggalkadaluarsa: tanggalkadaluarsa ?? this.tanggalkadaluarsa,
//         harga: harga ?? this.harga,
//         beratdibutuhkan: beratdibutuhkan ?? this.beratdibutuhkan,
//         beratmin: beratmin ?? this.beratmin,
//         beratmaks: beratmaks ?? this.beratmaks,
//       );
