
import 'package:flutter/material.dart';
import 'package:gard/constants.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/core/viewModel/locations_view_model.dart';
import 'package:gard/model/locations_model.dart';
import 'package:gard/views/scanner113_locations_view.dart';
import 'package:gard/views/widgets/bar_widget.dart';
import 'package:gard/views/widgets/custom_Text.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';

class LocationView extends StatelessWidget {
  final controller = Get.find<AuthViewModel>();
  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    return GetBuilder<LocationViewModel>(  
      init:  Get.find<LocationViewModel>(),
      builder: (LocationViewModel controller) {
        if (controller.loading.value) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator(color: primaryColor)),
          );
        } else {
          // Check internet connection
          return FutureBuilder<bool>(
            future: checkInternetConnection(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(child: CircularProgressIndicator(color: primaryColor)),
                );
              }
              final bool isConnected = snapshot.data ?? false;
              if (isConnected) {
                // Connected to the internet, show data
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    Icon(Icons.groups, size: 35, color: primaryColor),
                    SizedBox(width: 20),
                    CustomText(
                      text: '$user',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ],
                ),
              ),
                 body: Stack(
                children: [
                  
                  barWidget(text: 'المواقع',
                   onTap: () {
                            Get.back();
                          },),
                   Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Expanded(
                      child: GetBuilder<LocationViewModel>(
                        builder: (controller) {
                          return ListView.builder(
                            itemCount: controller.locationModel.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                // إنشاء صف الأعمدة
                                return Container(
                                  child: Table(
                                    children: [
                                      TableRow(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 137, 207, 190),
                                        ),
                                        children: [
                                          Container(
                                            height: 50,
                                            child: Center(
                                              child: TableCell(
                                                child: Text('الرقم'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            child: Center(
                                              child: TableCell(
                                                child: Text('الاسم'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                             
                              } else {
                                // إنشاء صفوف البيانات
                                final dataIndex = index - 1;
                                return Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Container(
                                    child: Table(
                                      children: [
                                        TableRow(
                                          children: [
                                            Container(
                                              child: Center(
                                                child: TableCell(
                                                  child: CustomText(
                                                    text: controller.locationModel[dataIndex].locNum.toString(),
                                                    fontSize: 20,),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                  Get.to(()=>ScannerLocationsView(
                                                    nameLoc: controller.locationModel[dataIndex].locName,)
                                                    );
                                                },
                                              child: Container(
                                                child: Center(
                                                  child: TableCell(
                                                    child: CustomText(
                                                      text:controller.locationModel[dataIndex].locName!,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                             
                              }
                            },
                          );
                       
                        },
                      ),
                    ),
                  )
                ],
              ),
                );
              } else {
                // Not connected to the internet, show offline data
                return Scaffold(
                  backgroundColor: Colors.white,
                   appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    Icon(Icons.groups, size: 35, color: primaryColor),
                    SizedBox(width: 20),
                    CustomText(
                      text: '$user',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ],
                ),
              ),
                  
                  body: FutureBuilder<List<LocationsModel>>(
                    future:controller.locationsDatabaseHelper.fetchOfflineData(), // اسم الدالة لاسترداد البيانات المحفوظة محليًا
                    builder: (BuildContext context, AsyncSnapshot<List<LocationsModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(color: primaryColor));
                      }

                      final List<LocationsModel> offlineData = snapshot.data ?? [];

                      if (offlineData.isEmpty) {
                        return Center(child: Text('لا توجد بيانات محفوظة.'));
                      }

                      // عرض البيانات المحفوظة محليًا
                      return ListView.builder(
                        itemCount: offlineData.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          final LocationsModel data = offlineData[index];
                          // ...
                          // عرض بيانات العنصر في القائمة
                          // ...
                          if (index == 0) {
                                // إنشاء صف الأعمدة
                                return Container(
                                  child: Table(
                                    children: [
                                      TableRow(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 137, 207, 190),
                                        ),
                                        children: [
                                          Container(
                                            height: 50,
                                            child: Center(
                                              child: TableCell(
                                                child: Text('الرقم'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            child: Center(
                                              child: TableCell(
                                                child: Text('الاسم'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                             
                              } else {
                                // إنشاء صفوف البيانات
                                final dataIndex = index - 1;
                                return Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Container(
                                    child: Table(
                                      children: [
                                        TableRow(
                                          children: [
                                            Container(
                                              child: Center(
                                                child: TableCell(
                                                  child: CustomText(
                                                    text: data.locNum.toString(),
                                                    fontSize: 20,),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                  Get.to(()=>ScannerLocationsView(
                                                    nameLoc: data.locName,)
                                                    );
                                                },
                                              child: Container(
                                                child: Center(
                                                  child: TableCell(
                                                    child: CustomText(
                                                      text:data.locName!,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                             
                              }
                        },
                      );
                    },
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
 Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}

 