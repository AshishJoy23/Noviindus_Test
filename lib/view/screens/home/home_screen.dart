import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviindus_test/view/widgets/widgets.dart';

import '../../../utils/colors.dart';
import '../screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                CupertinoIcons.bell,
                size: 30,
              ),
              Positioned(
                top: 0,
                right: 7,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.favButtonColor),
                ),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          HomeSearchBar(),
          SizedBox(
            height: size.height * 0.02,
          ),
          HomeSortingWidget(),
          SizedBox(
            height: size.width * 0.01,
          ),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: 8,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            color: AppColor.textfieldColor,
                            margin: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: size.height * 0.12,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: double.infinity,
                                        width: size.width * 0.1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${index + 1}. ',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Vikram Singh',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Couple Combo Package (Rejuven...)',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: AppColor.baseColor,
                                                fontSize: 16),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.date_range,
                                                    color: Colors.red,
                                                    size: 16,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text('31/01/2024'),
                                                ],
                                              ),
                                              SizedBox(
                                                width: size.height * 0.02,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.person_2_outlined,
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text('Jithesh'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.13,
                                    ),
                                    Text(
                                      'View Booking details',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.keyboard_arrow_right,
                              
                                      color: AppColor.baseColor,
                                      size: 35,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomButtonWidget(
          buttontext: 'Register Now',
          onPressed: () {
            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterNowScreen(),
                            ),
                          );
          },
        ),
      ),
    );
  }
}
