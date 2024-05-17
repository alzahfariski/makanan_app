import 'package:flutter/material.dart';
import 'package:makanan/models/makan.dart';
import 'package:makanan/screens/makanan_detail.dart';
import 'package:makanan/widgets/makan_item.dart';

class MakananScreen extends StatelessWidget {
  const MakananScreen({
    super.key,
    this.title,
    required this.makanan,
  });

  final String? title;
  final List<Makan> makanan;

  void selectMakan(BuildContext context, Makan makan) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MakananDetailsScreen(
          makan: makan,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Ups .. tidak ada data di sini !',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Pilih kategori lainnya !',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (makanan.isNotEmpty) {
      content = ListView.builder(
        itemCount: makanan.length,
        itemBuilder: (context, index) => MakanItem(
          makan: makanan[index],
          onSelected: (makan) {
            selectMakan(context, makan);
          },
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
