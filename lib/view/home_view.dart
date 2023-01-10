import 'package:flutter/material.dart';
import 'package:project1/data/response/status.dart';
import 'package:project1/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';
import '../view_model/user_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _homeViewModel = HomeViewModel();
  @override
  void initState() {
    super.initState();
    _homeViewModel.fetchStudentsList();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Home",
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              userPreferences.remove().then(
                (value) {
                  Navigator.pushNamed(context, RoutesName.login);
                },
              );
            },
            child: const Text(
              "LogOut",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) => HomeViewModel(),
        child: Center(
          child: Consumer<HomeViewModel>(
            builder: (context, value, _) {
              switch (value.studentsList.status) {
                case Status.loading:
                  return const CircularProgressIndicator();
                case Status.completed:
                  return Text(value.studentsList.message.toString());
                case Status.error:
                  return ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Text(
                            value.studentsList.data!.studentName.toString());
                      });
                default:
                  break;
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
