import 'package:abldriver/widget/custom_App_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/notificationProvider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}
class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<NotificationProvider>(context, listen: false).fetchCmsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notifications'),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          final notifications =
              provider.notiFicationGetModel?.data?.notifications ?? [];
          if (notifications.isEmpty) {
            return const Center(
              child: Text("No Notific ations Found"),
            );
          }
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                child: ListTile(
                  onTap: () async {
                    await Provider.of<NotificationProvider>(
                      context,
                      listen: false,
                    ).updateNotification();
                    await Provider.of<NotificationProvider>(
                      context,
                      listen: false,
                    ).fetchCmsData();
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      notification.image ?? "",
                    ),
                  ),
                  title: Text(
                    notification.title ?? "",
                    style: TextStyle(
                      fontWeight: notification.isRead == true
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(notification.body ?? ""),
                  trailing: notification.isRead == false
                      ? const Icon(
                    Icons.circle,
                    size: 10,
                    color: Colors.red,
                  )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}