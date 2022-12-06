import 'package:flutter/material.dart';
import 'package:pet_adopt/const.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final search = ValueNotifier<String>('');
  List<String> searchList = ["Leo", "Lily", "Dog", "Cat"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 40,
        title: SearchBox(),
        iconTheme: IconThemeData(
          color: blue,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 20.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text(
                      'Tìm kiếm gần đây',
                      style: poppins.copyWith(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      'Xem tất cả',
                      style: poppins.copyWith(
                        color: blue,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width,
                  child: SearchListView(searchList)),
            ],
          ),
          // builder: ((context, value, child) => Text(value)),
        ),
        // child:
      ),
    );
  }

  Widget SearchListView(List pairsList) {
    return ListView.builder(
      itemCount: pairsList.length,
      itemBuilder: (ctx, i) {
        return ListTile(
          contentPadding: EdgeInsets.only(left: 25, right: 20),
          title: Row(
            children: [
              Icon(Icons.access_time),
              SizedBox(width: 10),
              Text(
                pairsList[i],
                style: poppins,
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {},
              )
            ],
          ),
          onTap: () {
            // Navigator.of(context).pushNamed(
            //   SearchDetailScreen.routeName,
            //   arguments: matchQuery[i],
            // );
          },
        );
      },
    );
  }

  Widget IconSearch() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search),
      color: blue,
    );
  }

  Widget SearchBox() {
    return Container(
      margin: EdgeInsets.only(right: 0.0),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 58,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: TextField(
        onSubmitted: ((value) {
        }),
        onChanged: (value) {
          search.value = value;
        },
        decoration: InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(
              color: blue,
            ),
            border: InputBorder.none,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: blue,
              ),
            ),
            suffixIcon: IconSearch()),
      ),
    );
  }
}
