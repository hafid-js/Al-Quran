import 'package:alquran/app/contants/color.dart';
import 'package:alquran/app/data/models/juz.dart' hide Surah;
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            'Al Quran Apps',
            style: TextStyle(
              color: controller.isDark.isTrue ? appWhite : appPurpleDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.SEARCH),
            icon: Icon(Icons.search),
            color: appWhite,
          ),
        ],
      ),

      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  "Assalamualaikum",
                  style: TextStyle(
                    fontSize: 18,
                    color: controller.isDark.isTrue ? appWhite : appPurpleDark,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [appPurpleLight1, appPurpleDark],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.LAST_READ),
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -30,
                            right: 0,
                            child: Opacity(
                              opacity: 0.5,
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Image.asset(
                                  "assets/images/alquran2.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_rounded,
                                      color: appWhite,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Terakhir dibaca",
                                      style: TextStyle(color: appWhite),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                Text(
                                  "Al Fatihah",
                                  style: TextStyle(
                                    color: appWhite,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "Juz 1 | Ayat 5",
                                  style: TextStyle(color: appWhite),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              TabBar(
                indicatorColor: appPurpleDark,
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 1.0,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                    child: Text(
                      "Surah",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Juz",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Bookmark",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<List<Surah>>(
                      future: controller.getAllSurah(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return Center(child: Text('Tidak ada data'));
                        }
                        return ListView.separated(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Surah surah = snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(
                                  Routes.DETAIL_SURAH,
                                  arguments: surah,
                                );
                              },

                              leading: Obx(
                                () => Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        controller.isDark.isTrue
                                            ? "assets/images/list.png"
                                            : "assets/images/list.png",
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${surah.nomor}",
                                      style: TextStyle(
                                        color: appPurpleDark,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              title: Obx(
                                () => Text(
                                  surah.namaLatin,
                                  style: TextStyle(
                                    color: controller.isDark.isTrue
                                        ? appWhite
                                        : appPurpleDark,
                                    inherit: false,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                '${surah.tempatTurun} | ${surah.jumlahAyat} Ayat',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              trailing: Obx(
                                () => Text(
                                  surah.nama,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: controller.isDark.isTrue
                                        ? appWhite
                                        : appPurpleDark,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                            height: 1,
                          ),
                        );
                      },
                    ),
                    FutureBuilder<List<Juz>>(
                      future: controller.getAllJuz(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return Center(child: Text('Tidak ada data'));
                        }
                        return ListView.separated(
                          padding: EdgeInsets.only(top: 8),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Juz detailJuz = snapshot.data![index];
                            final keys = detailJuz.surahs!.items.keys.toList()
                              ..sort();

                            final ayatList = detailJuz.ayahs!;

                            final firstSurah = int.parse(keys.first);
                            final lastSurah = int.parse(keys.last);

                            final firstAyah = ayatList.firstWhere(
                              (a) => a.surah!.number == firstSurah,
                            );
                            final lastAyah = ayatList.lastWhere(
                              (a) => a.surah!.number == lastSurah,
                            );

                            return ListTile(
                              onTap: () {
                                Get.toNamed(
                                  Routes.DETAIL_JUZ,
                                  arguments: detailJuz.number,
                                );
                              },
                              leading: Obx(
                                () => Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        controller.isDark.isTrue
                                            ? "assets/images/list.png"
                                            : "assets/images/list.png",
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        color: appPurpleDark,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                  ),
                                ),
                              ),),
                              title: Obx(
                                () => Text(
                                  "Juz ${index + 1}",
                                  style: TextStyle(
                                    color: controller.isDark.isTrue
                                        ? appWhite
                                        : appPurpleDark,
                                    inherit: false,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              isThreeLine: true,
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                "Mulai Dari ${detailJuz.surahs!.items[keys.first]!.englishName} - ${firstAyah.numberInSurah} ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Sampai ${detailJuz.surahs!.items[keys.last]!.englishName} - ${lastAyah.numberInSurah}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                            height: 1,
                          ),
                        );
                      },
                    ),
                    GetBuilder<HomeController>(builder: (c) {
                      return FutureBuilder<List<Map<String, dynamic>>>(
                      future: c.getBookmark(),
                      builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if(snapshot.data!.isEmpty) {
                        return Center(
                          child: Text("Bookmark tidak tersedia."),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data = snapshot.data![index];
                        return ListTile(
                          onTap: () {
                            print(index);
                          },
                          leading: CircleAvatar(child: Text("${index + 1}"),),
                          title: Text("${data['surah']}"),
                          subtitle: Text("Ayat ${data['ayat']} - via ${data['via']}"),
                        );
                      });
                    },);
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeThemeMode(),
        child: Obx(
          () => Icon(
            Icons.color_lens,
            color: controller.isDark.isTrue ? appPurpleDark : appWhite,
          ),
        ),
      ),
    );
  }
}
