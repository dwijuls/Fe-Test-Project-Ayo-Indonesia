class ProvinceModels {
  String? id;
  String? nama;
  double? latitude;
  double? longitude;

  ProvinceModels({this.id, this.nama, this.latitude, this.longitude});

  ProvinceModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
