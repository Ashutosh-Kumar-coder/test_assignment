import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testassignment/model/user_model.dart';
import 'package:testassignment/screen/user_details.dart';
import 'package:testassignment/util/user_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var textEditingController = TextEditingController();
  List<UserModel> filterList = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<List<UserModel>>(
      initialData: UserUtil.userList,
      future: UserUtil.getUser(),
      builder: (context, snapshot) {
        print("fi= ${filterList.isEmpty}");
        if (snapshot.hasData) {
          return Scaffold(
            appBar: CupertinoNavigationBar(
              middle: CupertinoSearchTextField(
                controller: textEditingController,
                backgroundColor: Colors.white,
                onChanged: (val) {
                  setState(() {
                    filterList = snapshot.data!;
                  });
                  if (val.length > 0) {
                    setState(() {
                      filterList = snapshot.data!
                          .where((element) => element.username
                              .toLowerCase()
                              .contains(val.toLowerCase()))
                          .toList();
                      filterList
                          .sort((a, b) => a.username.compareTo(b.username));
                    });
                  } else {
                    setState(() {
                      filterList = snapshot.data!;
                    });
                  }
                },
                placeholder: "Search By UserName",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: Container(
              height: size.height,
              width: size.width,
              child: Builder(
                builder: (context) {
                  return filterList.isEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        UserDetails(snapshot.data![index])));
                              },
                              title: Text("${snapshot.data![index].username}"),
                              subtitle: Text("${snapshot.data![index].email}"),
                              leading: Icon(
                                Icons.person,
                                size: 25,
                              ),
                            );
                          },
                          itemCount: snapshot.data!.length,
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        UserDetails(filterList[index])));
                              },
                              title: Text("${filterList[index].username}"),
                              subtitle: Text("${filterList[index].email}"),
                              leading: Icon(
                                Icons.person,
                                size: 25,
                              ),
                            );
                          },
                          itemCount: filterList.length,
                        );
                },
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
