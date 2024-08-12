import 'package:flutter/material.dart';

class Items extends StatelessWidget {


   Items({super.key  , required this.image , required this.title});

   String image;
   String title;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:Colors.red.withOpacity(0.5),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
          horizontal: 5, vertical: 3.5),
      width: MediaQuery.sizeOf(context).width * 0.20,
      height: MediaQuery.sizeOf(context).height * 0.13,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
                child: Image(image: AssetImage(image), alignment: Alignment.center,width: 45,)
            ),
            const Spacer(),
            Text(
              title,
              style:TextStyle(color: Colors.black87)
                  ?.copyWith(
                  fontSize: 11,
                  color: const Color(0xFF000000)),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
