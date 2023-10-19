import 'package:flutter/material.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';

class MainLawyer extends StatelessWidget {
  const MainLawyer({
    super.key,
    required this.user,
    this.bg = Colors.white,
  });

  final Color bg;
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(16), color: bg),
      padding: const EdgeInsets.all(small),
      margin: const EdgeInsets.symmetric(vertical: small),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 94,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: NetworkImage(
                        user.profileImg != "" && user.profileImg != null
                            ? user.profileImg!
                            : 'https://images.unsplash.com/photo-1605664041952-4a2855d9363b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          space16,
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space8,
                space4,
                Text(
                  user.lastName ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                space4,
                Text(
                  'Хуульч',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                space8,
                Text(
                  "Ажлын туршлага: ${user.experience ?? 0} жил",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          space16,
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: origin),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: gold,
                      size: 15,
                    ),
                    space8,
                    Text(
                      '${user.ratingAvg ?? 0}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
