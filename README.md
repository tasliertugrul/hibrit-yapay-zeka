# hibrit-yapay-zeka
düşük sistemler için yapay zeka
# 🧠 Hibrit Yapay Zeka (Ultra Hafif)

Eski ve düşük donanımlı Linux bilgisayarlar için geliştirilmiş, **Bash ve Python** mimarisini birleştiren yapay zeka asistanı.

## ✨ Özellikler
- **Metin Sohbeti:** Sadece Bash kullanır. İnanılmaz hafiftir, bilgisayarı yormaz.
- **Görsel Analiz:** Bir resmi analiz etmek istediğinizde arka planda küçük bir Python köprüsü devreye girer.
- **Yerel Hafıza:** Aynı sorulara anında (0 gecikme) cevap verir.

## 🚀 Nasıl Çalıştırılır?
1. Sisteminizde gerekli araçları kurun:
   `sudo apt install curl jq zenity python3-requests`
2. `ai_hibrit.sh` ve `gorsel_analiz.py` dosyalarını indirin.
3. Her iki dosyanın içindeki `API_KEY` kısmına kendi Groq API anahtarınızı yapıştırın.
4. Terminali açıp şu komutu çalıştırın:
   `chmod +x ai_hibrit.sh && ./ai_hibrit.sh`