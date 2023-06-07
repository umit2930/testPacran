/// items : [{"material":1,"value":10.5},{"material":2,"value":6},{"material":3,"value":50},{"material":4,"value":3}]

class CalculateValuesBody {
  CalculateValuesBody({
      this.items,});

  CalculateValuesBody.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }


}

/// material : 1
/// value : 10.5

class Items {
  Items({
      this.material, 
      this.value,});

  Items.fromJson(dynamic json) {
    material = json['material'];
    value = json['value'];
  }
  num? material;
  num? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['material'] = material;
    map['value'] = value;
    return map;
  }

}