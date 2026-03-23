import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import '../../homeScreen/ui/homeScreen.dart';
import '../../orderHistoryScreen/ui/orderHistoryScreen.dart';
import '../../sosScreen/ui/sosScreen.dart';
import '../../walletScreen/ui/WalletScreen.dart';

class MainBottomBar extends StatefulWidget {
  const MainBottomBar({super.key});

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {
  int _currentIndex = 0;

  final List<String> _titles = [
    'Home',
    'Wallet',
    'Order History',
    'SOS',
  ];

  final List<Widget> _pages = const [
    HomeScreen(),
    WalletScreen(),
    OrderHistoryScreen(),
    SosScreen(),
  ];

  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Icon
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF086B48).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.exit_to_app_rounded,
                    size: 36,
                    color: Color(0xFF086B48),
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                const Text(
                  'Exit App',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // Message
                const Text(
                  'Are you sure you want to exit the application?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 24),

                // Buttons
                Row(
                  children: [
                    // No Button
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(
                            color: Color(0xFF086B48),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () =>
                            Navigator.of(context).pop(false),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFF086B48),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Yes Button
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF086B48),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () =>
                            Navigator.of(context).pop(true),
                        child: const Text(
                          'Exit',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
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
      },
    ) ??
        false;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // If not on Home tab, go to Home instead of exiting
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        }

        // Show exit dialog
        return await _showExitDialog(context);
      },
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorResource.buttonBackground,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorResource.white,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            _buildItem(
              label: 'Home',
              selectedIcon: AppIcons.home,
              unselectedIcon: AppIcons.inActiveHome,
              index: 0,
            ),
            _buildItem(
              label: 'Wallet',
              selectedIcon: AppIcons.activeWallet,
              unselectedIcon: AppIcons.inActiveWallet,
              index: 1,
            ),
            _buildItem(
              label: 'Order History',
              selectedIcon: AppIcons.inActiveHistory,
              unselectedIcon: AppIcons.inActiveHistory,
              index: 2,
            ),
            _buildItem(
              label: 'SOS',
              selectedIcon: AppIcons.inActiveSos,
              unselectedIcon: AppIcons.inActiveSos,
              index: 3,
            ),
          ],
        ),
      ),
    );
  }


  BottomNavigationBarItem _buildItem({
    required String label,
    required String selectedIcon,
    required String unselectedIcon,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        _currentIndex == index ? selectedIcon : unselectedIcon,
        height: 24,
        width: 24,
      ),
      label: label,
    );
  }
}
