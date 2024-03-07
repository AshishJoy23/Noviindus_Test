import 'package:noviindus_test/model/branch_model.dart';

class PatientModel {
  int? id;
  List<PatientdetailsSet>? patientdetailsSet;
  BranchModel? branch;
  String? user;
  String? payment;
  String? name;
  String? phone;
  String? address;
  String? price;
  int? totalAmount;
  int? discountAmount;
  int? advanceAmount;
  int? balanceAmount;
  String? dateNdTime;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  PatientModel(
      {this.id,
      this.patientdetailsSet,
      this.branch,
      this.user,
      this.payment,
      this.name,
      this.phone,
      this.address,
      this.price,
      this.totalAmount,
      this.discountAmount,
      this.advanceAmount,
      this.balanceAmount,
      this.dateNdTime,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  PatientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['patientdetails_set'] != null) {
      patientdetailsSet = <PatientdetailsSet>[];
      json['patientdetails_set'].forEach((v) {
        patientdetailsSet!.add(PatientdetailsSet.fromJson(v));
      });
    }
    branch =
        json['branch'] != null ? BranchModel.fromJson(json['branch']) : null;
    user = json['user'];
    payment = json['payment'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    price = json['price'];
    totalAmount = json['total_amount'];
    discountAmount = json['discount_amount'];
    advanceAmount = json['advance_amount'];
    balanceAmount = json['balance_amount'];
    dateNdTime = json['date_nd_time'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (patientdetailsSet != null) {
      data['patientdetails_set'] =
          patientdetailsSet!.map((v) => v.toJson()).toList();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    data['user'] = user;
    data['payment'] = payment;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['price'] = price;
    data['total_amount'] = totalAmount;
    data['discount_amount'] = discountAmount;
    data['advance_amount'] = advanceAmount;
    data['balance_amount'] = balanceAmount;
    data['date_nd_time'] = dateNdTime;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PatientdetailsSet {
  int? id;
  String? male;
  String? female;
  int? patient;
  int? treatment;
  String? treatmentName;

  PatientdetailsSet(
      {this.id,
      this.male,
      this.female,
      this.patient,
      this.treatment,
      this.treatmentName});

  PatientdetailsSet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    male = json['male'];
    female = json['female'];
    patient = json['patient'];
    treatment = json['treatment'];
    treatmentName = json['treatment_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['male'] = male;
    data['female'] = female;
    data['patient'] = patient;
    data['treatment'] = treatment;
    data['treatment_name'] = treatmentName;
    return data;
  }
}
