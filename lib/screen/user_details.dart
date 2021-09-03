import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testassignment/model/user_model.dart';

class UserDetails extends StatelessWidget {
  final UserModel userModel;

  UserDetails(this.userModel);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CupertinoNavigationBar(
        middle: Text("${userModel.username}"),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: ListView(
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Basic Details",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0),
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    RowsData("Name", "${userModel.name}"),
                    RowsData("Email", "${userModel.email}"),
                    RowsData("Phone", "${userModel.phone}"),
                    RowsData("Website", "${userModel.website}"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0),
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    RowsData("Street", "${userModel.address.street}"),
                    RowsData("Apartment", "${userModel.address.suite}"),
                    RowsData("City", "${userModel.address.city}"),
                    RowsData("ZipCode", "${userModel.address.zipcode}"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Company",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0),
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    RowsData("name", "${userModel.company.name}"),
                    RowsData("About", "${userModel.company.catchPhrase}"),
                    RowsData("More", "${userModel.company.bs}"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget RowsData(first, second) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$first",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.0),
          ),
          Text(
            "$second",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 1.0),
          ),
        ],
      ),
    );
  }
}
