import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const RadioApp());

const streamUrl = 'https://i.klikhost.com/8140/1';
const motto = 'Media Shilaturahmi Menggugah Inspirasi Ihwan Sejati';

class RadioApp extends StatelessWidget {
  const RadioApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RADIO DEWI ANJANI',
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff087443)), useMaterial3: true),
    home: const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final player = AudioPlayer();
  bool loading = false;
  bool playing = false;
  int tab = 0;

  Future<void> toggleRadio() async {
    if (loading) return;
    setState(() => loading = true);
    try {
      if (playing) {
        await player.pause();
        playing = false;
      } else {
        await player.setUrl(streamUrl);
        // Jangan menunggu stream selesai; cukup mulai pemutaran agar indikator
        // loading segera berhenti dan tombol menampilkan status pause.
        unawaited(player.play());
        playing = true;
      }
    } catch (_) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Streaming belum dapat diputar. Periksa koneksi internet dan coba lagi.')),
      );
      playing = false;
    }
    if (mounted) setState(() => loading = false);
  }

  @override
  void dispose() { player.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final pages = [
      homeContent(),
      const SchedulePage(),
      const ProfilePage(),
      const ContactPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff087443),
        foregroundColor: Colors.white,
        title: const Text('RADIO DEWI ANJANI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        centerTitle: true,
      ),
      body: pages[tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.radio), label: 'Radio'),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Jadwal'),
          NavigationDestination(icon: Icon(Icons.info_outline), label: 'Profil'),
          NavigationDestination(icon: Icon(Icons.call), label: 'Kontak'),
        ],
      ),
    );
  }

  Widget homeContent() => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(colors: [Color(0xff087443), Color(0xff16a36a)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(children: [
          ClipOval(
            child: Image.asset('assets/logo_radio.jpg', width: 150, height: 150, fit: BoxFit.cover),
          ),
          SizedBox(height: 10),
          Text('RADIO DEWI ANJANI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22)),
          Text('FM 104.6 MHz • Lombok Timur', style: TextStyle(color: Colors.white, fontSize: 15)),
          SizedBox(height: 12),
          Text(motto, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
        ]),
      ),
      const SizedBox(height: 22),
      const Center(child: Text('SIARAN LANGSUNG', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.4))),
      const SizedBox(height: 14),
      Center(
        child: InkWell(
          onTap: toggleRadio,
          borderRadius: BorderRadius.circular(60),
          child: CircleAvatar(
            radius: 48,
            backgroundColor: const Color(0xff087443),
            child: loading
              ? const CircularProgressIndicator(color: Colors.white)
              : Icon(playing ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white, size: 62),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Center(child: Text(loading ? 'Menghubungkan...' : playing ? 'Sedang Memutar Radio' : 'Tekan untuk Mendengarkan', style: const TextStyle(fontWeight: FontWeight.w600))),
      const SizedBox(height: 24),
      const InfoTile(icon: Icons.access_time, title: 'Jam Siaran', subtitle: 'Setiap hari, pukul 05.00–23.00 WITA'),
      const InfoTile(icon: Icons.location_on, title: 'Studio', subtitle: 'Komplek Kampus Universitas Islam Hamzanwadi NW Anjani, Lombok Timur'),
      const InfoTile(icon: Icons.language, title: 'Website', subtitle: 'www.radiodewianjani.my.id'),
    ],
  );
}

class InfoTile extends StatelessWidget {
  final IconData icon; final String title; final String subtitle;
  const InfoTile({super.key, required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(leading: Icon(icon, color: const Color(0xff087443)), title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(subtitle)));
}

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  static const schedule = [
    ['05:00–06:00', 'Siroh Islam (Siraman Rohani)'],
    ['06:30–08:00', 'Dewi Anjani Menyapa'],
    ['08:00–09:30', 'Majlis Hamzanwadi'],
    ['09:30–10:00', 'Lakaq Sasak'],
    ['10:00–12:00', 'Salam Dangdut'],
    ['13:00–14:00', 'Tembang Kenangan'],
    ['14:00–15:00', 'SIRASI (Silaturrahmi Siang)'],
    ['16:00–17:30', 'PILPEN (Pilihan Pendengar)'],
    ['18:30–19:30', 'DAI (Dakwah Agama Islam)'],
    ['20:00–22:00', 'CINTA (Cerita Diantara Kita)'],
    ['22:00–23:00', 'Renungan Malam'],
  ];
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('JADWAL SIARAN HARIAN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    const SizedBox(height: 10),
    ...schedule.map((s) => Card(child: ListTile(leading: const Icon(Icons.schedule, color: Color(0xff087443)), title: Text(s[1]), subtitle: Text(s[0])))),
    const SizedBox(height: 12),
    const Text('PROGRAM MINGGUAN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    const SizedBox(height: 8),
    const InfoTile(icon: Icons.event, title: 'Ahad', subtitle: '09.00–11.00 Panggung Ceria • 16.00–17.30 Voice Religi • 19.00–20.00 Hizib Nahdlatul Wathan'),
    const InfoTile(icon: Icons.event, title: 'Selasa', subtitle: '19.00–22.00 Tanya Jawab Agama Islam'),
    const InfoTile(icon: Icons.event, title: 'Kamis', subtitle: '19.00–20.00 Al-Barzanji'),
    const InfoTile(icon: Icons.event, title: 'Jumat', subtitle: '07.00–10.00 Majlis Dakwah Hamzanwadi • 14.00–15.30 Podcast Santri • 16.00–17.30 Language Club'),
  ]);
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: const [
    Text('PROFIL RADIO', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    SizedBox(height: 12),
    Text('Radio Dewi Anjani FM 104.6 MHz merupakan radio komunitas dan dakwah yang hadir untuk menyampaikan informasi, pendidikan, dakwah Islam, hiburan positif, serta melestarikan budaya lokal.'),
    SizedBox(height: 14),
    InfoTile(icon: Icons.business, title: 'Badan Usaha', subtitle: 'PT. Radio Bio Perdana Jaya'),
    InfoTile(icon: Icons.calendar_today, title: 'Berdiri', subtitle: '13 November 2001'),
    InfoTile(icon: Icons.school, title: 'Pengelola', subtitle: 'Yayasan Ponpes Syaikh Zainuddin Nahdlatul Wathan Anjani, Lombok Timur'),
    InfoTile(icon: Icons.campaign, title: 'Motto', subtitle: motto),
  ]);
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  Future<void> open(String value) async { final uri = Uri.parse(value); await launchUrl(uri, mode: LaunchMode.externalApplication); }
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('HUBUNGI RADIO DEWI ANJANI', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
    const SizedBox(height: 12),
    const InfoTile(icon: Icons.phone, title: 'Telepon Kantor', subtitle: '+62 817-5760-897'),
    const InfoTile(icon: Icons.email, title: 'Email', subtitle: 'dewianjani1046@gmail.com'),
    const InfoTile(icon: Icons.web, title: 'Website', subtitle: 'www.radiodewianjani.my.id'),
    const SizedBox(height: 12),
    FilledButton.icon(onPressed: () => open('https://wa.me/6287793292112'), icon: const Icon(Icons.chat), label: const Text('Hubungi melalui WhatsApp')),
    OutlinedButton.icon(onPressed: () => open('https://www.radiodewianjani.my.id'), icon: const Icon(Icons.language), label: const Text('Kunjungi Website')),
  ]);
}
