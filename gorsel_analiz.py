import sys
import requests
import base64
import subprocess

# API ANAHTARINI BURAYA YAPIŞTIR
API_KEY = "BURAYA_GROQ_API_ANAHTARINI_YAPISTIR"
resim_yolu = sys.argv[1]

try:
    with open(resim_yolu, "rb") as image_file:
        base64_image = base64.b64encode(image_file.read()).decode('utf-8')
except:
    print("Hata: Resim okunamadı!")
    sys.exit(1)

headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
data = {
    "model": "llama-3.2-11b-vision-preview",
    "messages": [
        {
            "role": "user",
            "content": [
                {"type": "text", "text": "Bu resimde ne var? Ekranda bir hata mesajı varsa ne yazıyor? Detaylıca analiz et ve Türkçe cevap ver."},
                {"type": "image_url", "image_url": {"url": f"data:image/jpeg;base64,{base64_image}"}}
            ]
        }
    ]
}

try:
    res = requests.post("https://api.groq.com/openai/v1/chat/completions", headers=headers, json=data).json()
    if "choices" in res:
        print(res["choices"][0]["message"]["content"])
    else:
        print("API Hatası: " + str(res))
except Exception as e:
    print("Bağlantı Hatası: " + str(e))