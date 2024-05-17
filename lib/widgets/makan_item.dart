import 'package:flutter/material.dart';
import 'package:makanan/widgets/makan_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:makanan/models/makan.dart';

class MakanItem extends StatelessWidget {
  const MakanItem({
    super.key,
    required this.makan,
    required this.onSelected,
  });

  final Makan makan;

  final void Function(Makan makan) onSelected;

  String get complexityText {
    return makan.complexity.name[0].toUpperCase() +
        makan.complexity.name.substring(1);
  }

  String get affordabilityText {
    return makan.affordability.name[0].toUpperCase() +
        makan.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelected(makan);
        },
        child: Stack(
          children: [
            Hero(
              tag: makan.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(makan.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      makan.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MakanItemTrait(
                          icon: Icons.schedule,
                          label: '${makan.duration} min',
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MakanItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MakanItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
