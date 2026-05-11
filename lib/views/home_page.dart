import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../app/routes/app_routes.dart';
import '../app/theme/app_color.dart';
import '../controllers/country_controller.dart';
import '../services/storage_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.find<CountryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   surfaceTintColor: Colors.transparent,

      //   title: Text(
      //     "Countries",
      //     style: TextStyle(fontWeight: bold, color: base),
      //   ),
      // ),


      appBar: AppBar(
  elevation: 0,
  centerTitle: true,
  backgroundColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,

  leadingWidth: 70,

  leading: Padding(
    padding: const EdgeInsets.only(left: 16),
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: base.withValues(alpha: 0.08),
        border: Border.all(
          color: base.withValues(alpha: 0.1),
        ),
      ),

      child: const Icon(
        Icons.person,
        color: base,
        size: 22,
      ),
    ),
  ),

  title: Text(
    "Countries",
    style: TextStyle(
      fontWeight: bold,
      color: base,
    ),
  ),

  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 16),

      child: GestureDetector(
        onTap: () async {
          await StorageService.logout();

          Get.offAllNamed(Routes.login);
        },

        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.red.withValues(alpha: 0.12),

            border: Border.all(
              color: Colors.red.withValues(alpha: 0.15),
            ),
          ),

          child: Row(
            children: [
              Icon(
                Icons.logout_rounded,
                size: 18,
                color: Colors.redAccent,
              ),

              SizedBox(width: 6),

              Text(
                "Logout",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: semiBold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
),

      body: controller.obx(
        /// ================= SUCCESS =================
        (countries) {
          return RefreshIndicator(
            onRefresh: controller.fetchCountries,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: countries!.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final country = countries[index];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: base.withValues(alpha: 0.08),
                    border: Border.all(color: base.withValues(alpha: 0.1)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black.withValues(alpha: 0.15),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      /// FLAG
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                         child: Image.network(
                          country.flag,
                          width: 75,
                          height: 55,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 75,
                              height: 55,
                              color: Colors.white12,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.flag,
                                color: base,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 14),

                      /// TEXT
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              country.officialName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: base,
                                fontWeight: bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.white70,
                                  ),
                                ),

                                const SizedBox(width: 4),

                                Expanded(
                                  child: Text(
                                    country.capitals.isNotEmpty
                                        ? country.capitals.join(", ")
                                        : "-",
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },

        /// ================= LOADING =================
        onLoading: ListView.separated(
          padding: const EdgeInsets.all(16),

          itemCount: 10,

          separatorBuilder: (_, _) => const SizedBox(height: 16),

          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.white10,

              highlightColor: Colors.white24,

              child: Container(
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),

                  color: Colors.white12,
                ),

                child: Row(
                  children: [
                    Container(
                      width: 75,
                      height: 55,

                      decoration: BoxDecoration(
                        color: base,

                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Container(
                            height: 16,
                            width: double.infinity,

                            decoration: BoxDecoration(
                              color: base,

                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Container(
                            height: 14,
                            width: 140,

                            decoration: BoxDecoration(
                              color: base,

                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        /// ================= EMPTY =================
        onEmpty: Center(
          child: Text(
            "No countries found",
            style: TextStyle(color: base),
          ),
        ),

        /// ================= ERROR =================
        onError: (error) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    "Failed to load countries",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: semiBold,
                      color: base,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    error ?? "Unknown error",

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      height: 1.5,
                      fontSize: 14,
                      color: textSecondary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: controller.fetchCountries,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: primary,
                      ),

                      child: Text(
                        "Try Again",

                        style: TextStyle(
                          color: base,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
