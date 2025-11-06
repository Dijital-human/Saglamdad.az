# 🚀 Final Deployment Steps / Son Deploy Addımları

## ✅ Sayt Hazırdır! / Website is Ready!

Bütün funksiyalar tamamlanıb və işləyir. Aşağıdakı addımları izləyərək saytı production-a deploy edə bilərsiniz.

---

## 📋 Qalan Addımlar (5 Addım) / Remaining Steps (5 Steps)

### 1. ⚠️ TƏCİLİ / URGENT - Environment Variables

**Vercel-də əlavə edilməlidir / Must be added in Vercel:**

1. Vercel Dashboard → Project → Settings → Environment Variables
2. Aşağıdakı dəyişənləri əlavə edin:

```bash
KV_REST_API_URL=https://your-kv-instance.vercel-kv.com
KV_REST_API_TOKEN=your-kv-token
JWT_SECRET=your-super-secure-random-secret-key-min-32-chars
```

**JWT_SECRET yaratmaq üçün:**
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

**⚠️ ƏHƏMİYYƏTLİ:**
- `JWT_SECRET` production üçün təsadüfi, uzun və təhlükəsiz olmalıdır (minimum 32 simvol)
- GitHub-a commit etməyin!
- Vercel-də Environment Variables bölməsindən əlavə edin

---

### 2. Vercel KV Database Quraşdırması

1. **Vercel Dashboard** → Project → **Storage** → **Create Database**
2. **Type:** KV seçin
3. **Database Name:** `saglamdad-kv`
4. **Region:** Seçin (məsələn: `iad1` - US East)
5. **Create Database** düyməsinə basın
6. Environment variables avtomatik əlavə olunacaq (`KV_REST_API_URL` və `KV_REST_API_TOKEN`)

---

### 3. GitHub Repository və Vercel Deploy

```bash
# 1. Git repository yaradın
git init
git add .
git commit -m "Saglamdad.az - Production ready"

# 2. GitHub-a push edin
git remote add origin https://github.com/yourusername/saglamdad.az.git
git branch -M main
git push -u origin main
```

**Vercel-də Deploy:**
1. Vercel.com → **Add New Project**
2. GitHub repository-ni seçin
3. **Framework:** Next.js (avtomatik tanınacaq)
4. **Environment Variables** əlavə edin (1-ci addımdan)
5. **Deploy** düyməsinə basın

---

### 4. Domain Konfiqurasiyası

1. **Vercel Project** → **Settings** → **Domains**
2. `saglamdad.az` domain-ini əlavə edin
3. **DNS Records** (domain provider-dən konfiqurasiya edin):
   - **Type:** `CNAME`
   - **Name:** `@` (root) və ya `www`
   - **Value:** Vercel-dən göstərilən `cname.vercel-dns.com` və ya oxşar

---

### 5. Post-Deployment (Deploy-dən Sonra)

**DƏRHAL ETMƏLİSİNİZ:**

1. ✅ **Admin Panelə Daxil Olun**
   - URL: `https://saglamdad.az/admin`
   - Username: `admin`
   - Password: `admin123`

2. ✅ **Parolu Dəyişdirin**
   - "Ayarlar" tab → "Parol Dəyişdir"
   - Güclü parol daxil edin (minimum 12 simvol, rəqəm, böyük/kiçik hərf)

3. ✅ **Məzmunu Doldurun**
   - Məhsullar əlavə edin
   - Sosial media linkləri əlavə edin
   - Haqqında məzmunu yazın
   - Əlaqə məlumatlarını daxil edin
   - Hero Section-u konfiqurasiya edin

4. ✅ **Reklam Banerləri (Google AdSense)**
   - Google AdSense-dən reklam kodu alın
   - Admin panel → "Reklam Banerləri" → Banner əlavə edin
   - **Nəzər:** Google AdSense script artıq layout-də yüklənib (`ca-pub-8163629613496922`)
   - Yalnız `<ins>` tag-ini admin paneldə yapışdırın

---

## ✅ Tamamlanan Funksiyalar / Completed Features

### Core Features
- ✅ Admin paneli (authentication, dashboard, parol dəyişdirmə)
- ✅ Məhsul idarəetməsi (əlavə, redaktə, silmə, çoxsaylı rəsimlər, video)
- ✅ Sosial media linkləri idarəetməsi
- ✅ Haqqında səhifəsi idarəetməsi
- ✅ Əlaqə məlumatları idarəetməsi
- ✅ Hero Section idarəetməsi (background, yazılar, rənglər)
- ✅ **Reklam Banerləri** (Google AdSense + Manual banners)
- ✅ File upload (rəsim və video)
- ✅ Real-time updates
- ✅ Responsive dizayn (mobil, tablet, desktop)
- ✅ Modern animasiyalar (Framer Motion)
- ✅ SEO metadata təkmilləşdirməsi
- ✅ 404 səhifəsi
- ✅ Error handling

### Security
- ✅ JWT authentication
- ✅ Password hashing (bcrypt)
- ✅ Admin-only routes (API protection)
- ✅ Footer admin bölməsi şərti göstərmə
- ✅ Token verification

### Google AdSense
- ✅ Google AdSense script global olaraq yüklənir (`app/layout.tsx`)
- ✅ Banner sistemində Google AdSense dəstəyi
- ✅ Manual banner-lər (rəsm, video, link)
- ✅ Banner-lər yalnız aktivdirsə görünür
- ✅ Banner-lər dizayna təsir etmir

---

## 📝 Qeydlər / Notes

### Google AdSense
- **Script yüklənib:** `app/layout.tsx`-də (`ca-pub-8163629613496922`)
- **Admin paneldə:** Yalnız `<ins>` tag-ini yapışdırın
- **Yayımlandıqdan sonra:** Reklamlar avtomatik görünəcək

### Local vs Production
- **Local Development:** JSON fayllar (`data/` folder)
- **Production:** Vercel KV (environment variables ilə)
- **File Upload:** `public/uploads/` folder-də saxlanılır

---

## 🆘 Problem Həlləri / Troubleshooting

### Build xətası
```bash
npm run build
```
Xətaları yoxlayın və düzəldin.

### API xətası
- Vercel logs: Project → Deployments → Logs
- Environment variables düzgün əlavə edilib?
- KV database yaradılıb?

### Banner-lər görünmür
- Admin panel → "Reklam Banerləri" → "Aktivdir" checkbox-ı işarələnib?
- Browser Console (F12) yoxlayın
- Real-time yenilənmə: 10 saniyə gözləyin

### File upload işləmir
- `public/uploads/` folder yoxdursa yaradın
- Vercel-də file size limits yoxlayın (10MB limit)

---

## ✅ Yekun Status / Final Status

**Sayt:** ✅ Production üçün tam hazırdır!

**Qalan işlər:**
1. ⚠️ Environment variables əlavə etmək (Vercel-də) - 5 dəqiqə
2. Vercel KV database yaratmaq - 2 dəqiqə
3. GitHub-a push və deploy etmək - 10 dəqiqə
4. Domain konfiqurasiya etmək - 5 dəqiqə
5. Post-deployment (parol dəyişdirmə, məzmun) - 10 dəqiqə

**Təxmini vaxt:** 30-40 dəqiqə

---

## 🎉 Uğurlar! / Good Luck!

Saytınız production üçün tam hazırdır. Deploy addımlarını izləyin və saytınızı yayımlayın!

**Son yeniləmə:** 2025-01-07
**Status:** ✅ READY FOR PRODUCTION DEPLOYMENT


