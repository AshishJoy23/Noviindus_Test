import 'package:noviindus_test/model/branch_model.dart';

class TreatmentModel {
  int? id;
  List<BranchModel>? branches;
  String? name;
  String? duration;
  String? price;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  TreatmentModel(
      {this.id,
      this.branches,
      this.name,
      this.duration,
      this.price,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  TreatmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['branches'] != null) {
      branches = <BranchModel>[];
      json['branches'].forEach((v) {
        branches!.add(BranchModel.fromJson(v));
      });
    }
    name = json['name'];
    duration = json['duration'];
    price = json['price'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (branches != null) {
      data['branches'] = branches!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['duration'] = duration;
    data['price'] = price;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class TreatmentBookingModel {
  final String id;
  final String treatmentName;
  final String maleCount;
  final String femaleCount;

  TreatmentBookingModel({
    required this.id,
    required this.treatmentName,
    required this.maleCount,
    required this.femaleCount,
  });
}
