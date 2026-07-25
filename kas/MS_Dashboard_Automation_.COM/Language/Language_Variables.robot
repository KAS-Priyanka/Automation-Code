
*** Settings ***
Library    SeleniumLibrary
Library    Process
Library    Collections
Library    String


*** Variables ***

${BASE_URL}   https://dashboard.mysellercentral.com
@{LANG_BLOCK_LIST}
...    Korean
...    Tamil
...    Kannada
...    Malayalam
...    Telugu
...    Gujarati
...    Punjabi
...    Urdu

&{LANG_CODES}
...    English=en
...    Hindi=hi
...    Spanish=es
...    French=fr
...    German=de
...    Italian=it
...    Korean=kr
...    Tamil=ta
...    Kannada=ka
...    Malayalam=mal
...    Telugu=te
...    Bangla=ba
...    Assamese=as
...    Marathi=mr
...    Gujarati=gu
...    Punjabi=pa
...    Urdu=ur

&{LANG_ALPHABETS}
...    English=[A-Za-z]
...    Hindi=[\u0900-\u097F]
...    Spanish=[A-Za-z\u00C1\u00C9\u00CD\u00D3\u00DA\u00E1\u00E9\u00ED\u00F3\u00FA\u00D1\u00F1\u00DC\u00FC]
...    French=[A-Za-z\u00C0-\u00FF]
...    German=[A-Za-z\u00C4\u00D6\u00DC\u00E4\u00F6\u00FC\u00DF]
...    Italian=[A-Za-z\u00C0-\u00FF]
...    Korean=[\uAC00-\uD7AF]
...    Tamil=[\u0B80-\u0BFF]
...    Kannada=[\u0C80-\u0CFF]
...    Malayalam=[\u0D00-\u0D7F]
...    Telugu=[\u0C00-\u0C7F]
...    Bangla=[\u0980-\u09FF]
...    Assamese=[\u0980-\u09FF]
...    Marathi=[\u0900-\u097F]
...    Gujarati=[\u0A80-\u0AFF]
...    Punjabi=[\u0A00-\u0A7F]
...    Urdu=[\u0600-\u06FF]

&{LANG_ALPHABETS1}
...    English=[A-Za-z]
...    Hindi=[ऀ-ॿ]
...    Spanish=[A-Za-zÁÉÍÓÚáéíóúÑñÜü]
...    French=[A-Za-zÀ-ÿ]
...    German=[A-Za-zÄÖÜäöüß]
...    Italian=[A-Za-zÀ-ÿ]
...    Korean=[가-힣]
...    Tamil=[஀-௿]
...    Kannada=[ಀ-೿]
...    Malayalam=[ഀ-ൿ]
...    Telugu=[ఀ-౿]
...    Bangla=[ঀ-৿]
...    Assamese=[ঀ-৿]
...    Marathi=[ऀ-ॿ]
...    Gujarati=[઀-૿]
...    Punjabi=[਀-੿]
...    Urdu=[؀-ۿ]


#---shipped--
&{SHIPPED}
...    English=Order
...    Hindi=ऑर्डर
...    Spanish=Pedidos
...    French=Commande
...    German=Bestellung
...    Italian=Ordine
...    Korean=주문
...    Tamil=ஆர்டர்
...    Kannada=ಆರ್ಡರ್
...    Malayalam=ഓർഡർ
...    Telugu=ఆర్డర్
...    Bangla=অর্ডার
...    Assamese=অর্ডাৰ
...    Marathi=ऑर्डर
...    Gujarati=ઓર્ડર
...    Punjabi=ਆਰਡਰ
...    Urdu=آرڈر



&{FULFILMENT}
...    English=Fulfilment
...    Hindi=पूर्ति
...    Spanish=Cumplimiento
...    French=Exécution des commandes
...    German=Abwicklung
...    Italian=Evasione 
...    Korean=주문 처리
...    Tamil=ஆர்டர் நிறைவேற்றம்
...    Kannada=ಆರ್ಡರ್ ಪೂರ್ಣಗೊಳಿಸುವಿಕೆ
...    Malayalam=ഓർഡർ പൂർത്തീകരണം
...    Telugu=ఆర్డర్ పూర్తి
...    Bangla=অর্ডার সম্পন্ন
...    Assamese=অৰ্ডাৰ সম্পূৰ্ণ
...    Marathi=पूर्णता
...    Gujarati=ઓર્ડર પૂર્ણતા
...    Urdu=آرڈر کی تکمیل
...    Punjabi=ਆਰਡਰ ਪੂਰਾ ਕਰਨਾ


&{QUANTITY}
...    English=Quantity
...    Spanish=Cantidad
...    Hindi=मात्रा
...    Korean=수량
...    German=Menge
...    French=Quantité
...    Italian=Quantità
...    Tamil=அளவு
...    Kannada=ಪ್ರಮಾಣ
...    Malayalam=അളവ്
...    Telugu=పరిమాణం
...    Bangla=পরিমাণ
...    Assamese=পৰিমাণ
...    Marathi=प्रमाण
...    Gujarati=જથ્થો
...    Urdu=مقدار
...    Punjabi=ਮਾਤਰਾ

&{UNITS}
...    English=Units
...    Spanish=Unidades
...    Hindi=इकाइयाँ
...    Korean=단위
...    German=Einheiten
...    French=Unités
...    Italian=Unità
...    Tamil=அலகுகள்
...    Kannada=ಘಟಕಗಳು
...    Malayalam=യൂണിറ്റുകൾ
...    Telugu=యూనిట్లు
...    Bangla=একক
...    Assamese=একক
...    Marathi=युनिट्स
...    Gujarati=એકમો
...    Punjabi=ਇਕਾਈਆਂ
...    Urdu=یونٹس

&{CARRIER}
...    English=Carrier
...    Spanish=Transportista
...    Hindi=कैरियर
...    Korean=캐리어  
...    German=Versanddienstleister
...    French=Transporteur
...    Italian=Corriere
...    Tamil=கூரியர்
...    Kannada=ಕೂರಿಯರ್
...    Malayalam=കൂരിയർ
...    Telugu=కొరియర్
...    Bangla=কুরিয়ার
...    Assamese=কুৰিয়াৰ
...    Marathi=वाहक
...    Gujarati=કુરિયર
...    Punjabi=ਕੂਰੀਅਰ
...    Urdu=کورئیر


&{SUBMIT}
...    English=Submit
...    Spanish=Enviar
...    Hindi=सबमिट
...    Korean=제출
...    German=Einreichen
...    French=Envoyer
...    Italian=Invia
...    Tamil=சமர்ப்பி
...    Kannada=ಸಲ್ಲಿಸಿ
...    Malayalam=സമർപ്പിക്കുക
...    Telugu=సమర్పించండి
...    Bangla=জমা দিন
...    Assamese=জমা দিয়ক
...    Marathi=सबमिट
...    Gujarati=સબમિટ કરો
...    Punjabi=ਜਮ੍ਹਾ ਕਰੋ
...    Urdu=جمع کریں

&{INVENTORY_HEALTH_DICT}
...    English=Inventory Health
...    Spanish=Salud del inventario
...    Hindi=इन्वेंट्री हेल्थ
...    Korean=재고 상태
...    German=Lagerzustand
...    French=Santé de l’inventaire
...    Italian=Salute dell’inventario
...    Tamil=இன்வென்டரி நிலை
...    Kannada=ಇನ್ವೆಂಟರಿ ಸ್ಥಿತಿ
...    Malayalam=ഇൻവെന്ററി നില
...    Telugu=ఇన్వెంటరీ స్థితి
...    Bangla=ইনভেন্টরি অবস্থা
...    Assamese=ইনভেন্টৰি অৱস্থা
...    Marathi=इन्व्हेंटरी स्थिती
...    Gujarati=ઇન્વેન્ટરી સ્થિતિ
...    Punjabi=ਇਨਵੈਂਟਰੀ ਸਥਿਤੀ 
...    Urdu = انوینٹری ہیلتھ