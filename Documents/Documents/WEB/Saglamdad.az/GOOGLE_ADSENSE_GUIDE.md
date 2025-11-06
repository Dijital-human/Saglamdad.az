# Google AdSense-dən Reklam Almaq - Təlimat / Google AdSense Guide

## 📋 Məzmun / Content
1. [Google AdSense Hesabı Açmaq](#1-google-adsense-hesabı-açmaq)
2. [Saytınızı Təsdiqləmək](#2-saytınızı-təsdiqləmək)
3. [Reklam Kodu Almaq](#3-reklam-kodu-almaq)
4. [Admin Paneldən Banner Əlavə Etmək](#4-admin-paneldən-banner-əlavə-etmək)

---

## 1. Google AdSense Hesabı Açmaq / Create Google AdSense Account

### Addımlar / Steps:

1. **Google AdSense Səhifəsinə Daxil Olun**
   - https://www.google.com/adsense/start/ səhifəsinə keçin
   - Google hesabınızla daxil olun (əgər yoxdursa, yaradın)

2. **Hesab Məlumatlarını Doldurun**
   - Ölkə/Region: Azərbaycan
   - Ödəniş məlumatları: Bank hesabı və ya PayPal
   - Telefon nömrəsi və ünvan

3. **Hesabı Aktivləşdirin**
   - Google hesabınızı təsdiqləyin
   - Email ünvanınızı yoxlayın

---

## 2. Saytınızı Təsdiqləmək / Verify Your Website

### Təcili Tələblər / Important Requirements:

✅ **Saytın hazır olması lazımdır:**
- Saytınız yayımlanmalıdır (live)
- Məzmun olmalıdır (məhsullar, haqqında, əlaqə)
- 18+ yaş məzmunu olmamalıdır
- Privacy Policy səhifəsi olmalıdır

✅ **Saytın struktur tələbləri:**
- Responsive dizayn (mobil, tablet, desktop)
- Navbar və Footer
- Ən azı 10-15 səhifə məzmunu

### Təsdiqləmə Addımları / Verification Steps:

1. **Saytınızı Google AdSense-ə Əlavə Edin**
   - AdSense dashboard-da "Sites" bölməsinə keçin
   - "Add site" düyməsinə basın
   - Sayt URL-ni daxil edin: `https://saglamdad.az`

2. **Verification Code Əlavə Edin**
   - Google bir verification kodu verəcək
   - Bu kodu saytınızın `<head>` bölməsinə əlavə edin
   - **Nəzər:** Bu kodu `app/layout.tsx` faylına əlavə etməlisiniz
   - **Vacib:** Google AdSense script artıq `app/layout.tsx`-də əlavə edilib (ca-pub-8163629613496922)

3. **Təsdiqləməni Gözləyin**
   - AdSense saytınızı yoxlayacaq (1-3 gün)
   - Email ilə bildiriş alacaqsınız

---

## 3. Reklam Kodu Almaq / Get Ad Code

### Reklam Formatları / Ad Formats:

1. **Display Ads (Banner Reklamlar)**
   - 300x250 (Medium Rectangle)
   - 728x90 (Leaderboard)
   - 970x250 (Billboard)

2. **Responsive Ads (Avtomatik Ölçü)**
   - Saytın ölçüsünə uyğunlaşır
   - **Tövsiyə olunan:** Responsive ads

### Kod Almaq / Get Code:

1. **AdSense Dashboard-a Daxil Olun**
   - https://www.google.com/adsense/start/

2. **"Ads" → "By ad unit" bölməsinə keçin**

3. **"Create ad unit" düyməsinə basın**

4. **Reklam Növünü Seçin:**
   - Ad unit name: "Saglamdad Homepage Banner" (məsələn)
   - Ad type: **"Responsive"** (tövsiyə olunan)
   - Ad size: "Responsive" seçin

5. **"Create" düyməsinə basın**

6. **Kodu Kopyalayın:**
   - HTML kodunu kopyalayın
   - Bu kod belə görünəcək:
   ```html
   <ins class="adsbygoogle"
        style="display:block"
        data-ad-client="ca-pub-8163629613496922"
        data-ad-slot="XXXXXXXXXX"
        data-ad-format="auto"
        data-full-width-responsive="true"></ins>
   <script>
        (adsbygoogle = window.adsbygoogle || []).push({});
   </script>
   ```
   - **Nəzər:** `<script>` tag-i lazım deyil, çünki script artıq layout-də yüklənib
   - Yalnız `<ins>` tag-ini kopyalayın və admin paneldə yapışdırın

---

## 4. Admin Paneldən Banner Əlavə Etmək / Add Banner from Admin Panel

### Addımlar / Steps:

1. **Admin Paneline Daxil Olun**
   - URL: `https://saglamdad.az/admin`
   - Username: `admin`
   - Password: (parolunuz)

2. **"Reklam Banerləri" Tab-ına Keçin**
   - Sol menyuda "Reklam Banerləri" tab-ına klik edin

3. **Yeni Banner Əlavə Edin:**
   - **Banner Tipi:** "Google AdSense" seçin
   - **Banner Yeri:** Seçin (məsələn: "Hero Section Altı")
   - **Google AdSense Kodu:** Google-dan aldığınız HTML kodunu bura yapışdırın
   - **Aktivdir:** Checkbox-ı işarələyin ✅

4. **"Əlavə et" Düyməsinə Basın**

5. **Ana Səhifəyə Qayıdın**
   - Banner görünəcək (10 saniyə daxilində)

---

## ⚠️ Vacib Qeydlər / Important Notes

### Pul Qazanmaq / Earning Money:

- **CPC (Cost Per Click):** Hər klik üçün qazanc
- **CPM (Cost Per Mille):** 1000 görüntüləmə üçün qazanc
- **Qazanc:** Mövzu və auditoriyadan asılıdır
- **Minimum ödəniş:** $100 (ABŞ dolları)

### Tövsiyələr / Recommendations:

1. **Çox banner əlavə etməyin**
   - Hər səhifədə 2-3 banner kifayətdir
   - Çox banner istifadəçi təcrübəsini pisləşdirir

2. **Banner yerləri:**
   - Hero Section altı (ən yaxşı)
   - Məhsullar altı (yaxşı)
   - Footer yuxarısı (yaxşı)

3. **Məzmunun keyfiyyəti:**
   - Keyfiyyətli məzmun = daha çox trafik = daha çox qazanc
   - SEO optimallaşdırma vacibdir

4. **Google AdSense Qaydaları:**
   - Öz reklamlarınıza klik etməyin ❌
   - Dostlarınızdan klik istəməyin ❌
   - Bot istifadə etməyin ❌
   - Bu qaydalara riayət etməyənlər ban edilir!

---

## 📞 Kömək / Help

- **Google AdSense Dəstəyi:** https://support.google.com/adsense
- **AdSense Forum:** https://support.google.com/adsense/community
- **AdSense Policies:** https://support.google.com/adsense/answer/48182

---

## ✅ Checklist / Yoxlama Siyahısı

- [ ] Google AdSense hesabı açılıb
- [ ] Sayt təsdiqlənib
- [ ] Reklam kodu alınıb
- [ ] Admin paneldən banner əlavə edilib
- [ ] "Aktivdir" checkbox-ı işarələnib
- [ ] Ana səhifədə banner görünür
- [ ] Responsive dizaynda işləyir

---

**Uğurlar! / Good Luck!** 🚀

