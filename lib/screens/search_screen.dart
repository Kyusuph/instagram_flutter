import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_flutter/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchContoller = TextEditingController();
  bool _showUsers = false;

  @override
  void dispose() {
    super.dispose();
    _searchContoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _searchContoller,
          decoration: const InputDecoration(hintText: 'Search for a user'),
          onFieldSubmitted: (String val) {
            setState(() {
              _showUsers = true;
            });
          },
        ),
      ),
      body: _showUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: _searchContoller.text)
                  .get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final usersnap = snapshot.data!.docs[index].data();
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(usersnap['photoUrl']),
                      ),
                      title: Text(usersnap['username']),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final postSnap = snapshot.data!.docs[index];
                    return Image.network(
                      postSnap['postUrl'],
                    );
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.count(
                    index % 7 == 0 ? 2 : 1,
                    index % 7 == 0 ? 2 : 1,
                  ),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                );
              }),
    );
  }
}
