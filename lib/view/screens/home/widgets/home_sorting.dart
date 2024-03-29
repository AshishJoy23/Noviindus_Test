import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class HomeSortingWidget extends StatelessWidget {
  const HomeSortingWidget({
    key,
  });


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: size.height * 0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Sort by :',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: double.infinity,
            width: size.width * 0.4,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(
                        color: Colors.black, fontSize: 16),
                  ),
                  Icon(Icons.keyboard_arrow_down,color: AppColor.baseColor,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

