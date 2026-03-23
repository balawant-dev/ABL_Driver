
import 'package:abldriver/presentaion/walletScreen/provider/walletProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettlementHistoryClass extends StatefulWidget {
  const SettlementHistoryClass({super.key});

  @override
  State<SettlementHistoryClass> createState() =>
      _SettlementHistoryClassState();
}

class _SettlementHistoryClassState extends State<SettlementHistoryClass> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WalletProvider>(context, listen: false).fetchwalletData();
    });
  }
  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return "";
    final dt = DateTime.parse(date);
    return "${dt.day}-${dt.month}-${dt.year}";
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
        builder: (context, provider, child) {
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }


          final orders =
              provider.walletGetModel?.settlementHistory ?? [];

          if (orders.isEmpty) {
            return Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/upcommingBooking.gif",
                  height: 220,
                ),
              ),
            );
          }
          return  Column(
            children: [
              _tableHeader(),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final item = orders[index];

                  return _tableRow(
                    date: _formatDate(item.createdAt),
                    amount: item.amountRequested ?? 0, // ✅ int
                    status: item.status ?? "",
                  );
                },
              ),

            ],
          );
        }
    );


  }

  // ---------------- HEADER ----------------

  Widget _tableHeader() {
    return Container(
      height: 40, // ✅ changed
      decoration: BoxDecoration(
        color: const Color(0xFFA8D5C2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        children: [
          _HeaderItem(title: "Date"),
          _VerticalDivider(),
          _HeaderItem(title: "Amount"),
          _VerticalDivider(),
          _HeaderItem(title: "Status"),
        ],
      ),
    );
  }


  // ---------------- ROW ----------------

  Widget _tableRow({
    required String date,
    required int amount,
    required String status,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            _RowItem(text: date),
            const _VerticalDivider(),
            _RowItem(text: "₹$amount", isBold: true),
            const _VerticalDivider(),
            _RowItem(
              text: status,
              color: _statusColor(status),
              isBold: true,
            ),

          ],
        ),
      ),
    );
  }

  // ---------------- STATUS COLOR ----------------

  Color _statusColor(String status) {
    switch (status) {
      case "Settled":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}

// ---------------- HEADER ITEM ----------------

class _HeaderItem extends StatelessWidget {
  final String title;
  const _HeaderItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ---------------- ROW ITEM ----------------

class _RowItem extends StatelessWidget {
  final String text;
  final bool isBold;
  final Color? color;

  const _RowItem({
    required this.text,
    this.isBold = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: color ?? Colors.black,
          ),
        ),
      ),
    );
  }
}

// ---------------- VERTICAL DIVIDER ----------------

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: double.infinity,
      color: const Color(0xFF0F6B50),
    );
  }
}
