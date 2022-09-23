import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_sepeti/cubit/sepet_liste_cubt.dart';
import 'package:yemek_sepeti/cubit/yemek_deyat_cubit.dart';
import 'package:yemek_sepeti/date/shared_preferances.dart';
import 'package:yemek_sepeti/entiti/yemekler.dart';

class YemeklerDetaySayfa extends StatefulWidget {
  Yemek yemek;
  YemeklerDetaySayfa({Key? key, required this.yemek}) : super(key: key);

  @override
  State<YemeklerDetaySayfa> createState() => _YemeklerDetaySayfaState();
}

class _YemeklerDetaySayfaState extends State<YemeklerDetaySayfa> {
  int sepet_tutari = 0;
  int values = 0;

  @override
  Widget build(BuildContext context) {
    var yemek = widget.yemek;

    return Scaffold(
      appBar: AppBar(
        title: Text(yemek.yemek_adi),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
            Text(yemek.yemek_adi),
            Text(
              "${yemek.yemek_fiyat} ₺",
              style: TextStyle(fontSize: 32, color: Colors.red),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (values > 0) {
                        --values;
                        sepet_tutari = urun_toplam(yemek);
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.horizontal_rule)),
                Text("$values", style: TextStyle(fontSize: 32)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        ++values;
                        sepet_tutari = urun_toplam(yemek);
                      });
                    },
                    icon: Icon(Icons.add)),
              ],
            ),
            Text(
              "Toplam Tutar: ${sepet_tutari} ₺",
              style: TextStyle(fontSize: 32, color: Colors.red),
            ),
            ElevatedButton(
                onPressed: () {
                  SepetToplam(sepet_tutari);

                  context
                      .read<YemekDetayCubit>()
                      .SepeteEkle(yemek.yemek_adi, yemek.yemek_fiyat, yemek.yemek_resim_adi, values.toString(), yemek.kullanici_adi);
                },
                child: const Text("sepete ekle"))
          ],
        ),
      ),
    );
  }

  int urun_toplam(Yemek yemek) {
    return (int.parse(yemek.yemek_fiyat) * values);
  }
}
