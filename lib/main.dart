
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController namaController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF536DFE),
              Color(0xFF7C4DFF),
              Color(0xFFB388FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Consumer<UserProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 35),

                    const Icon(
                      Icons.account_circle_rounded,
                      color: Colors.white,
                      size: 85,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'My Personal Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),


                    const SizedBox(height: 40),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Halo, Pengguna!',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF303F9F),
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Silakan masukkan nama kamu untuk disimpan.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 25),

                          const Text(
                            'Nama Pengguna',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 10),

                          TextField(
                            controller: namaController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText: 'Contoh: Galuh Pauline',
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Color(0xFF536DFE),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF3F4FF),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF536DFE),
                                    Color(0xFF7C4DFF),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ElevatedButton.icon(
                                onPressed: provider.isLoading
                                    ? null
                                    : () async {
                                        await provider.saveName(
                                          namaController.text,
                                        );
                                        FocusScope.of(context).unfocus();
                                      },
                                icon: const Icon(Icons.save_rounded),
                                label: const Text(
                                  'Simpan Nama',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  disabledBackgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    if (provider.isLoading)
                      const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    else
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.95),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.verified_user_rounded,
                              color: Color(0xFF536DFE),
                              size: 40,
                            ),

                            const SizedBox(height: 12),

                            const Text(
                              'Profil Tersimpan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF303F9F),
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              provider.nama.isEmpty
                                  ? 'Belum ada nama yang disimpan'
                                  : provider.nama,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF7C4DFF),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              provider.nama.isEmpty
                                  ? 'Silakan masukkan nama kamu terlebih dahulu.'
                                  : 'Nama berhasil disimpan di perangkat ini.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
