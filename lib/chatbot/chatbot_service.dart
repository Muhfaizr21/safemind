import 'chatbot_response.dart';

class ChatbotService {
  static ChatbotResponse getResponse(
    String input,
  ) {
    final text = input.toLowerCase();

  if (
    text.contains('cemas') ||
    text.contains('takut') ||
    text.contains('anxiety') ||
    text.contains('panik') ||
    text.contains('khawatir')
  ) {
    return ChatbotResponse(
      message:
          'Perasaan cemas dan takut bisa muncul ketika pikiran sedang lelah atau terbebani. Cobalah tenangkan diri perlahan, tarik napas dalam, dan fokus pada hal yang bisa Anda kendalikan saat ini.',
    );
  }
    if (text.contains('stres')) {
      return ChatbotResponse(
        message:
            'Stres dapat muncul ketika pikiran dan tubuh terlalu lelah. Cobalah memberi waktu untuk diri sendiri dan lakukan aktivitas yang menenangkan.',
      );
    }
    if (text.contains('pusing')) {
      return ChatbotResponse(
        message:
            'Saya memahami bahwa keadaan ini terasa melelahkan. Terkadang rasa pusing bisa muncul ketika pikiran terlalu penuh atau tubuh kurang beristirahat. Cobalah beri waktu untuk diri sendiri beristirahat dan lakukan aktivitas yang membuat Anda lebih tenang.',
      );
    }
    if (text.contains('bingung')) {
    return ChatbotResponse(
        message:
            'Merasa bingung saat menghadapi masalah adalah hal yang wajar. Tidak perlu memaksa diri menemukan semua jawaban sekaligus. Anda bisa mulai dengan bercerita perlahan kepada orang yang membuat Anda merasa aman dan didengar.',
      );
    }
    if (text.contains('bingung')) {
    return ChatbotResponse(
        message:
            'Merasa bingung saat menghadapi masalah adalah hal yang wajar. Tidak perlu memaksa diri menemukan semua jawaban sekaligus. Anda bisa mulai dengan bercerita perlahan kepada orang yang membuat Anda merasa aman dan didengar.',
      );
    }

    if (text.contains('merasa sendiri')||
        text.contains('kesepian')) {
      return ChatbotResponse(
        message:
            'Perasaan sendiri atau kesepian bisa terasa berat, apalagi ketika sedang menghadapi banyak hal. Anda tidak harus menghadapi semuanya sendirian. Cobalah berbicara dengan orang yang Anda percaya atau lakukan hal kecil yang membuat Anda merasa nyaman.',
      );
    }

  if (
    text.contains('dibully') ||
    text.contains('bully') ||
    text.contains('perundungan') ||
    text.contains('kekerasan') ||
    text.contains('dipukul') ||
    text.contains('diancam') ||
    text.contains('pelecehan') ||
    text.contains('dilecehkan') ||
    text.contains('ditampar') ||
    text.contains('diganggu')
  ) {
    return ChatbotResponse(
      message:
          'Saya turut prihatin atas hal yang Anda alami. Menghadapi situasi seperti itu tentu tidak mudah dan saya peduli dengan apa yang Anda rasakan. Jika Anda masih ingin bercerita, saya siap mendengarkan. Namun jika Anda membutuhkan bantuan lebih lanjut, Anda juga dapat menggunakan menu Laporan agar tim terkait dapat membantu secara aman dan rahasia.',
    );
  }
  if (
    text.contains('mau lapor') ||
    text.contains('ingin lapor') ||
    text.contains('pengen lapor') ||
    text.contains('melaporkan') ||
    text.contains('laporin')
  ) {
    return ChatbotResponse(
      message:
          'Terima kasih sudah berani bercerita. Kalau kamu merasa siap, Klik di sini untuk membuka menu laporan agar tim terkait dapat membantu secara aman dan rahasia.',    );
  }
  if (
    text.contains('menu laporan') ||
    text.contains('fitur laporan') ||
    text.contains('lapornya dimana') ||
    text.contains('lapor dimana') ||
    text.contains('cari laporan')
  ) {
    return ChatbotResponse(
      message:
          'Menu Laporan bisa kamu temukan di halaman utama aplikasi atau Klik di sini. Kamu dapat membukanya untuk membuat laporan atau menceritakan kejadian yang ingin disampaikan. Jika masih bingung, aku juga bisa membantu menjelaskan langkah-langkahnya.',
    );
  }
  if (
  text.contains('cara lapor') ||
  text.contains('gimana lapor') ||
  text.contains('bagaimana melapor') ||
  text.contains('proses laporan') ||
  text.contains('langkah laporan') ||
  text.contains('langkahnya gimana') ||
  text.contains('disiapkan kalo mau lapor') ||
  text.contains('disiapkan kalau mau lapor') ||
  text.contains('disiapin kalo mau lapor') ||
  text.contains('disiapkan kalau ingin lapor') ||
  text.contains('prosesnya gimana')
  ) {
    return ChatbotResponse(
      message:
          'Kalau kamu ingin membuat laporan, kamu bisa mulai dengan menceritakan kejadian yang dialami secara singkat sesuai yang kamu ingat. Jika ada bukti seperti chat atau foto kamu juga bisa menambahkannya, tetapi tidak wajib. Setelah itu kamu dapat membuka menu Laporan dan mengisi cerita sesuai keadaan yang kamu alami.',
    );
  }
  if (
  text.contains('psikolog') ||
  text.contains('profesional') ||
  text.contains('konsultasi') ||
  text.contains('mau konsultasi') ||
  text.contains('bantuan profesional')
) {
  return ChatbotResponse(
    message:
        'Itu keputusan yang baik. Berbicara dengan profesional dapat membantu kamu mendapatkan dukungan dan penanganan yang lebih tepat. Kamu bisa menggunakan menu Konsultasi untuk terhubung dengan bantuan profesional.',
  );
}
  if (
    text.contains('edukasi') ||
    text.contains('tips') ||
    text.contains('belajar') ||
    text.contains('informasi') ||
    text.contains('self care') ||
    text.contains('kesehatan mental')
  ) {
    return ChatbotResponse(
      message:
          'Kalau kamu ingin mencari tips atau belajar lebih banyak tentang kesehatan mental, kamu bisa membuka menu Edukasi. Di sana ada berbagai informasi dan materi yang bisa membantu kamu memahami serta menjaga kesehatan mental dengan lebih baik.',
    );
  }
    return ChatbotResponse(
      message:
          'Aku mungkin belum memahami maksudmu dengan tepat. Kamu bisa coba menjelaskan lagi secara perlahan atau menceritakan apa yang sedang kamu rasakan saat ini.',
    );
  }
}