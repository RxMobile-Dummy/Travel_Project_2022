class ViewCouponModel {
  ViewCouponModel({
    this.id,
    this.code,
    this.title,
    this.description,
    this.couponImgUrl,
    this.discount,
    this.minValue,
    this.maxOrderValue,
    this.noOfUser,
    this.eligibleFor,
    this.startDate,
    this.endDate,
  });

  ViewCouponModel.fromJson(dynamic json) {
    id = json['_id'];
    code = json['code'];
    title = json['title'];
    description = json['description'];
    couponImgUrl = json['couponImgUrl'];
    discount = json['discount'];
    minValue = json['minValue'];
    maxOrderValue = json['maxOrderValue'];
    noOfUser = json['noOfUser'];
    eligibleFor = json['eligibleFor'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }
  int? id;
  String? code;
  String? title;
  String? description;
  String? couponImgUrl;
  int? discount;
  int? minValue;
  int? maxOrderValue;
  int? noOfUser;
  String? eligibleFor;
  String? startDate;
  String? endDate;
  ViewCouponModel copyWith({
    int? id,
    String? code,
    String? title,
    String? description,
    String? couponImgUrl,
    int? discount,
    int? minValue,
    int? maxOrderValue,
    int? noOfUser,
    String? eligibleFor,
    String? startDate,
    String? endDate,
  }) =>
      ViewCouponModel(
        id: id ?? this.id,
        code: code ?? this.code,
        title: title ?? this.title,
        description: description ?? this.description,
        couponImgUrl: couponImgUrl ?? this.couponImgUrl,
        discount: discount ?? this.discount,
        minValue: minValue ?? this.minValue,
        maxOrderValue: maxOrderValue ?? this.maxOrderValue,
        noOfUser: noOfUser ?? this.noOfUser,
        eligibleFor: eligibleFor ?? this.eligibleFor,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['code'] = code;
    map['title'] = title;
    map['description'] = description;
    map['couponImgUrl'] = couponImgUrl;
    map['discount'] = discount;
    map['minValue'] = minValue;
    map['maxOrderValue'] = maxOrderValue;
    map['noOfUser'] = noOfUser;
    map['eligibleFor'] = eligibleFor;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    return map;
  }
}
