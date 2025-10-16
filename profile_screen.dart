import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/profile_provider.dart';

Future<void> _showEditNameDialog(BuildContext context, String currentName) async {
  final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
  final nameController = TextEditingController(text: currentName);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Display Name'),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter your new name'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () async {
              await profileProvider.updateDisplayName(nameController.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          switch (profileProvider.status) {
            case ProfileStatus.Loading:
              return Center(child: CircularProgressIndicator());
            case ProfileStatus.Error:
              return Center(child: Text('Error: ${profileProvider.errorMessage}'));
            case ProfileStatus.Loaded:
              final user = profileProvider.userProfile;
              if (user == null) {
                return Center(child: Text('User profile not found.'));
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () => profileProvider.uploadProfilePicture(),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: user.photoURL != null
                            ? NetworkImage(user.photoURL!)
                            : null,
                        child: user.photoURL == null
                            ? Icon(Icons.person, size: 50)
                            : profileProvider.status == ProfileStatus.Loading
                                ? CircularProgressIndicator()
                                : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.displayName ?? 'No Name',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, size: 20),
                          onPressed: () => _showEditNameDialog(context, user.displayName ?? ''),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      user.email ?? 'No Email',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    // Add more profile information here
                  ],
                ),
              );
            default:
              return Center(child: Text('Welcome to your profile!'));
          }
        },
      ),
    );
  }
}