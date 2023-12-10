class GetProductListModel {
  String? entityId;
  String? price;
  String? specialPrice;
  String? image;
  String? rating;

  GetProductListModel(
      {this.entityId, this.price, this.specialPrice, this.image, this.rating});

  GetProductListModel.fromJson(Map<String, dynamic> json) {
    entityId = json['entity_id'];
    price = json['price'];
    specialPrice = json['special_price'];
    image = json['image'];
    rating = json['rating'];
  }

  static List<GetProductListModel> fromJsonList(List<dynamic> jsonList) {
    List<GetProductListModel> _data = [];
    for (var v in jsonList) {
      _data.add(GetProductListModel.fromJson(v));
    }
    return _data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entity_id'] = this.entityId;
    data['price'] = this.price;
    data['special_price'] = this.specialPrice;
    data['image'] = this.image;
    data['rating'] = this.rating;
    return data;
  }
}
