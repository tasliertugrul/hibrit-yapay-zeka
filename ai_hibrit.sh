#!/bin/bash

# API ANAHTARINI BURAYA YAPIŞTIR
API_KEY="BURAYA_GROQ_API_ANAHTARINI_YAPISTIR"
CACHE_FILE="ai_cache.json"

if [ ! -f "$CACHE_FILE" ]; then echo "{}" > "$CACHE_FILE"; fi

while true; do
    SECIM=$(zenity --list --title="Hibrit Yapay Zeka" --text="Bir işlem seçin:" --column="İşlem" "Metin Sohbeti (Hafif Bash)" "Görsel Analiz (Python Köprüsü)" --width=400 --height=250)
    
    if [ $? -ne 0 ]; then break; fi

    if [ "$SECIM" == "Metin Sohbeti (Hafif Bash)" ]; then
        SORU=$(zenity --entry --title="Sohbet" --text="Bir mesaj yaz...")
        if [ -z "$SORU" ]; then continue; fi
        SORU_KEY=$(echo "$SORU" | tr '[:upper:]' '[:lower:]')
        CEVAP=$(jq -r --arg key "$SORU_KEY" '.[$key] // empty' "$CACHE_FILE")

        if [ -n "$CEVAP" ]; then
            zenity --info --title="⚡ Yerel Hafıza (0 Gecikme)" --text="$CEVAP" --width=500
        else
            (
                RESPONSE=$(curl -s -X POST "https://api.groq.com/openai/v1/chat/completions" \
                    -H "Authorization: Bearer $API_KEY" -H "Content-Type: application/json" \
                    -d "{\"model\": \"llama-3.3-70b-versatile\", \"messages\": [{\"role\": \"system\", \"content\": \"Hangi dilde yazılırsa o dilde cevap ver.\"}, {\"role\": \"user\", \"content\": \"$SORU\"}]}")
                YENI_CEVAP=$(echo "$RESPONSE" | jq -r '.choices[0].message.content // "Hata!"')
                jq --arg key "$SORU_KEY" --arg val "$YENI_CEVAP" '.[$key] = $val' "$CACHE_FILE" > tmp.json && mv tmp.json "$CACHE_FILE"
                echo "$YENI_CEVAP"
            ) | zenity --text-info --title="☁️ Bulut Yanıtı" --width=600 --height=400
        fi

    elif [ "$SECIM" == "Görsel Analiz (Python Köprüsü)" ]; then
        RESIM=$(zenity --file-selection --title="Bir Resim Seç" --file-filter="Resimler | *.png *.jpg *.jpeg")
        if [ -z "$RESIM" ]; then continue; fi
        SONUC=$(python3 gorsel_analiz.py "$RESIM")
        zenity --info --title="👁️ Görsel Analiz Sonucu" --text="$SONUC" --width=600 --height=400
    fi
done