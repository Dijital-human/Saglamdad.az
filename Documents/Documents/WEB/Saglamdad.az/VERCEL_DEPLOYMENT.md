# Vercel Deployment Guide / Vercel Yerləşdirmə Təlimatı

## ✅ Proyekt Hazırlığı

### 1. Kod Status
- ✅ `package.json` düzgün formatda
- ✅ `next` paketi `dependencies`-də var (14.2.33)
- ✅ `package-lock.json` mövcuddur
- ✅ Node.js 22.x konfiqurasiyası var
- ✅ Build lokalda uğurlu işləyir
- ✅ TypeScript xətaları yoxdur
- ✅ `passwordHash` problemi YOXDUR (kodda `password` istifadə olunur)

### 2. Fayl Strukturu
```
Saglamdad.az/
├── package.json          ✅ Root-da
├── next.config.js       ✅ Root-da
├── tsconfig.json        ✅ Root-da
├── app/                 ✅ Next.js App Router
├── components/          ✅ React komponentləri
├── lib/                 ✅ Utility funksiyalar
└── public/              ✅ Static fayllar
```

---

## 🚀 Vercel Dashboard-da Deployment

### Addım 1: Proyekti Sil və Yenidən Yarat (RECOMMENDED)

**Bu addım bütün cache və konfiqurasiya problemlərini həll edir.**

1. **Vercel Dashboard → Proyekti Sil**
   - https://vercel.com → daxil olun
   - `Dijital-human/Saglamdad.az` proyektini açın
   - "Settings" → "General" → aşağıda "Delete Project"
   - "Delete" təsdiqləyin

2. **Yeni Proyekt Yarat**
   - Vercel Dashboard → "Add New..." → "Project"
   - GitHub repository-ni seçin: `Dijital-human/Saglamdad.az`
   - "Import" klikləyin

3. **Konfiqurasiya (VACIB!)**
   - **Framework Preset:** Next.js (avtomatik seçilməlidir)
   - **Root Directory:** BOŞ BURAXIN (default = repository root)
   - **Build Command:** `npm run build` (default)
   - **Output Directory:** `.next` (default)
   - **Install Command:** `npm install` (default)
   - **Node.js Version:** 22.x (avtomatik `package.json`-dan oxunacaq)

4. **Deploy**
   - "Deploy" klikləyin
   - Build uğurlu olmalıdır

---

### Addım 2: Environment Variables (Production üçün)

1. **Settings → Environment Variables**
   - `JWT_SECRET` əlavə edin (production üçün güclü random string)
   - `KV_REST_API_URL` əlavə edin (Vercel KV yaratdıqdan sonra)
   - `KV_REST_API_TOKEN` əlavə edin (Vercel KV yaratdıqdan sonra)

2. **Vercel KV Database**
   - Vercel Dashboard → "Storage" → "Create Database" → "KV"
   - Database adı: `saglamdad-kv`
   - Region seçin
   - "Create" → "Connect" (credentials avtomatik əlavə olunacaq)

---

## ⚠️ Problem Həlləri

### Problem 1: "Next.js versiyası aşkarlanmadı"

**Səbəb:** Root Directory yanlış təyin edilib

**Həll:**
1. Vercel Dashboard → Settings → General
2. Root Directory: boş buraxın və ya `.` yazın
3. Save → Redeploy

---

### Problem 2: "npm error code ENOENT - package.json tapılmadı"

**Səbəb:** Root Directory yanlış path-də

**Həll:**
1. Root Directory: boş buraxın (default)
2. Əgər subdirectory-dədirsə, düzgün path-i yazın
3. Save → Redeploy

---

### Problem 3: "passwordHash xüsusiyyəti yoxdur"

**Səbəb:** Vercel cache-də köhnə build qalıqları

**Həll:**
1. Proyekti silib yenidən yaradın (yuxarıda Addım 1)
2. Və ya: Deployments → "Clear Build Cache" → Redeploy

**Qeyd:** Kodda `passwordHash` YOXDUR - yalnız `password` istifadə olunur. Bu problem Vercel cache-dəndir.

---

## 📋 Yoxlama Siyahısı

### Vercel Dashboard-da:
- [ ] Root Directory: boş və ya `.`
- [ ] Framework Preset: Next.js
- [ ] Node.js Version: 22.x
- [ ] Build Command: `npm run build`
- [ ] Output Directory: `.next`

### Environment Variables:
- [ ] `JWT_SECRET` (production üçün)
- [ ] `KV_REST_API_URL` (Vercel KV üçün)
- [ ] `KV_REST_API_TOKEN` (Vercel KV üçün)

### Deployment:
- [ ] Build uğurlu
- [ ] Sayt işləyir
- [ ] Admin panel işləyir (/admin)

---

## 🎯 Deployment Sonrası

1. **Admin Panelə Daxil Olun**
   - URL: `https://your-domain.vercel.app/admin`
   - Username: `admin`
   - Password: `admin123` (ilk daxil olandan sonra dəyişdirin!)

2. **Parolu Dəyişdirin**
   - Admin panel → "Təhlükəsizlik" → Parol dəyişdirin

3. **Məzmunu Doldurun**
   - Məhsullar əlavə edin
   - Sosial media linkləri
   - Haqqında məzmunu
   - Əlaqə məlumatları
   - Hero section konfiqurasiya edin

---

## 📞 Problem Olarsa

1. **Vercel Logs Yoxlayın**
   - Deployments → Son deployment → "Logs"

2. **Build Logları**
   - "Build Logs" bölməsində xətaları yoxlayın

3. **Environment Variables**
   - Düzgün əlavə edilib?

4. **Root Directory**
   - Yenidən yoxlayın - boş və ya `.` olmalıdır

---

**Status:** ✅ Production üçün hazırdır
**Son yeniləmə:** 2025-11-06

