import 'package:campuspulse/admin/screens/users/widgets/all_users.dart';
import 'package:campuspulse/admin/screens/users/widgets/total_users.dart';
import 'package:campuspulse/common/widgets/pulse_appbar.dart';
import 'package:campuspulse/screens/home/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../utils/constants/pulse_colors.dart';
import '../../../utils/constants/pulse_text.dart';
import '../../../utils/utils.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final response = await supabase.from('user_details').select('*');

    return List<Map<String, dynamic>>.from(response);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PulseAppBar(title: 'Users'),

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final users = snapshot.data ?? [];

          return Column(
            children: [
              Padding(
                padding: Utils.screenPadding(),
                child: TotalUsers(userCount: users.length),
              ),

              const SizedBox(height: 12),

              if (users.isEmpty)
                const Expanded(child: Center(child: Text('No Users')))
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: users.length,
                    separatorBuilder: (_, __) => Utils.spacePulse(),
                    itemBuilder: (context, index) {
                      final u = users[index];

                      return Padding(
                        padding: Utils.screenPadding(),
                        child: AllUsers(
                          count: index + 1,
                          name: u['name'],

                          onDelete: () async {
                            final userId = u['id'];
                            await supabase
                                .from('user_details')
                                .delete()
                                .eq('id', userId);
                            setState(() {});

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.transparent,
                                  duration: Duration(seconds: 2),
                                  content: Text(
                                    '${u['name']} Deleted',
                                    style: PulseText.label.copyWith(color: PulseColors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
