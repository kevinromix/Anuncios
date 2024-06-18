import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/money_format.dart';
import 'package:flutter_app/models/electronic.dart';
import 'package:flutter_app/screens/detalle/detalle_electronic.dart';

Card customCard(Electronic electronic, {required BuildContext context}) {
  return Card(
    elevation: 3,
    child: Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(minHeight: 120),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => Detalle(electronic: electronic)),
            ),
          );
        },
        titleAlignment: ListTileTitleAlignment.center,
        leading: Image.asset(
          'assets/${electronic.image1}.jpg',
          fit: BoxFit.cover,
          width: 100,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                electronic.model,
                softWrap: false,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(
              formatCurrency
                  .format(double.parse(electronic.price.replaceAll("\$", ""))),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
        subtitle: Text(
          electronic.description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        isThreeLine: true,
      ),
    ),
  );
}
