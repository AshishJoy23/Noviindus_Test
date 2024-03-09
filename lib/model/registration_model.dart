class RegistrationModel {
  final String? id;
  final String? name;
  final String? excecutive;
  final String? payment;
  final String? phone;
  final String? address;
  final String? totalAmount;
  final String? discountAmount;
  final String? advanceAmount;
  final String? balanceAmount;
  final String? dateNdTime;
  final String? male;
  final String? female;
  final String? branch;
  final String? treatments;

  RegistrationModel({
    required this.id,
    required this.name,
    required this.excecutive,
    required this.payment,
    required this.phone,
    required this.address,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateNdTime,
    required this.male,
    required this.female,
    required this.branch,
    required this.treatments,
  });

  Map<String, String> toJson() {
    return {
      //   'name': 'Test_user',
      // 'excecutive': 'Test_excecutive',
      // 'payment': 'Cash',
      // 'phone': '1234567890',
      // 'address': 'Kozhikode',
      // 'total_amount': '5000',
      // 'discount_amount': '500',
      // 'advance_amount': '1000',
      // 'balance_amount': '3500',
      // 'date_nd_time': '08/03/2024-1:11 PM',
      // 'id': '',
      // 'male': '2,3',
      // 'female': '2,4',
      // 'branch': '162',
      // 'treatments': '90,86',
      'name': name!,
      'excecutive': excecutive!,
      'payment': payment!,
      'phone': phone!,
      'address': address!,
      'total_amount': totalAmount!,
      'discount_amount': discountAmount!,
      'advance_amount': advanceAmount!,
      'balance_amount': balanceAmount!,
      'date_nd_time': dateNdTime!,
      'id': id!,
      'male': male!,
      'female': female!,
      'branch': branch!,
      'treatments': treatments!,
    };
    //   final Map<String, String> data = {};
    //  data['id'] = id!;
    //   data['name'] = name!;
    //   data['excecutive'] = excecutive!;
    //   data['payment'] = payment!;
    //   data['phone'] = phone!;
    //   data['address'] = address!;
    //   data['total_amount'] = totalAmount!;
    //   data['discount_amount'] = discountAmount!;
    //   data['advance_amount'] = advanceAmount!;
    //   data['balance_amount'] = balanceAmount!;
    //   data['date_nd_time'] = dateNdTime!;
    //   data['male'] = male!;
    //   data['female'] = female!;
    //   data['branch'] = branch!;
    //   data['treatments'] = treatments!;
    //   return data;
  }
}
