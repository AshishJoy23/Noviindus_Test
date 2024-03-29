import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: size.height * 0.06,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: 'Search for treatments',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 1.0),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            height: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.baseColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
