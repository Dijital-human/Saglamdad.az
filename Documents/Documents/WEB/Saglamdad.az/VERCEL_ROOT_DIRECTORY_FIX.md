# Vercel Root Directory Problemi Həll Yolu

## 🔴 Problem: `/vercel/path0/package.json` tapılmır

Bu xəta Vercel-də **Root Directory** konfiqurasiyası problemi olduğunu göstərir.

---

## ✅ Həll Yolu (VACIB!)

### Addım 1: Vercel Dashboard-da Root Directory Düzəltmə

1. **Vercel Dashboard → Proyektinizi Açın**
   - https://vercel.com → daxil olun
   - `Dijital-human/Saglamdad.az` proyektini seçin

2. **Settings → General**
   - "Settings" tab → "General" bölməsi

3. **Root Directory Təyin Edin**
   - "Root Directory" bölməsini tapın
   - "Edit" klikləyin
   - **Dəyəri tamamilə silin** (boş buraxın) və ya `.` (nöqtə) yazın
   - **"Save"** klikləyin

4. **Build & Development Settings**
   - "Build & Development Settings" bölməsinə gedin
   - Root Directory: **boş** və ya `.` olduğuna əmin olun
   - Framework Preset: **Next.js** (avtomatik seçilməlidir)
   - Build Command: `npm run build`
   - Output Directory: `.next`
   - Install Command: `npm install`

5. **Redeploy**
   - "Deployments" tab → "Redeploy"
   - Və ya yeni commit avtomatik deploy başlayacaq

---

## 🔄 Alternativ: Proyekti Sil və Yenidən Yarat

Əgər yuxarıdakı addımlar işləmirsə:

### 1. Proyekti Sil
- Vercel Dashboard → proyektinizi açın
- "Settings" → "General" → aşağıda "Delete Project"
- "Delete" təsdiqləyin

### 2. Yeni Proyekt Yarat
- Vercel Dashboard → "Add New..." → "Project"
- GitHub repository: `Dijital-human/Saglamdad.az`
- "Import" klikləyin

### 3. Konfiqurasiya (VACIB!)
- **Framework Preset:** Next.js (avtomatik seçilməlidir)
- **Root Directory:** BOŞ BURAXIN (default = repository root)
- **Build Command:** `npm run build` (default)
- **Output Directory:** `.next` (default)
- **Install Command:** `npm install` (default)
- **Node.js Version:** 22.x (avtomatik `package.json`-dan oxunacaq)

### 4. Deploy
- "Deploy" klikləyin
- Build uğurlu olmalıdır

---

## 📋 Yoxlama Siyahısı

Deploy zamanı loglarda görünməlidir:

```
✓ Cloning repository
✓ Found package.json
✓ Installing dependencies
✓ Building...
✓ Compiled successfully
```

Əgər yenə də xəta alırsınız:
- Root Directory **boş** və ya `.` olmalıdır
- Əgər başqa bir şey varsa (məs: `src/`, `app/`, `frontend/`), **silin**

---

## ⚠️ Vacib Qeydlər

1. **Root Directory boş olmalıdır** - `package.json` repository root-dadır
2. **Framework Preset Next.js olmalıdır** - avtomatik seçilməlidir
3. **Build Command:** `npm run build` (default)
4. **Output Directory:** `.next` (default)

---

## 🎯 Nəticə

Root Directory düzgün təyin olunduqdan sonra:
- ✅ `package.json` tapılacaq
- ✅ Dependencies quraşdırılacaq
- ✅ Build uğurlu olacaq
- ✅ Sayt işləyəcək

---

**Status:** ✅ Düzəlişlər edildi, yalnız Vercel Dashboard-da Root Directory düzəltmək lazımdır

