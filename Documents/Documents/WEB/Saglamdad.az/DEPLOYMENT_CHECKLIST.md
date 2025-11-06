# Deployment Checklist / Deploy Siyahısı

## ✅ Tamamlanan Funksiyalar / Completed Features

### 1. Əsas Funksiyalar / Core Features
- ✅ Admin paneli (authentication, dashboard)
- ✅ Məhsul idarəetməsi (əlavə, redaktə, silmə, çoxsaylı rəsimlər)
- ✅ Sosial media linkləri idarəetməsi
- ✅ Haqqında səhifəsi idarəetməsi
- ✅ Əlaqə məlumatları idarəetməsi
- ✅ Hero Section idarəetməsi (background, yazılar, rənglər)
- ✅ Parol dəyişdirmə funksiyası
- ✅ File upload (rəsim və video)
- ✅ Responsive dizayn
- ✅ Real-time product updates

### 2. Təhlükəsizlik / Security
- ✅ JWT authentication
- ✅ Password hashing (bcrypt)
- ✅ Admin-only routes (API protection)
- ✅ Footer admin bölməsi şərti göstərmə
- ✅ Token verification

### 3. UI/UX
- ✅ Modern animasiyalar (Framer Motion)
- ✅ Responsive design (mobil, tablet, desktop)
- ✅ Loading states
- ✅ Error handling
- ✅ Form validations

---

## 🔧 Production üçün Tələb Olunan Addımlar / Required Steps for Production

### 1. Environment Variables / Mühit Dəyişənləri

**Vercel-də əlavə edilməlidir / Must be added in Vercel:**

```bash
# Vercel KV Database
KV_REST_API_URL=https://your-kv-instance.vercel-kv.com
KV_REST_API_TOKEN=your-kv-token

# JWT Secret (TƏHLÜKƏSİZ KEY İSTİFADƏ EDİN!)
JWT_SECRET=your-super-secure-random-secret-key-min-32-chars
```

**⚠️ ƏHƏMİYYƏTLİ / IMPORTANT:**
- `JWT_SECRET` production üçün təsadüfi, uzun və təhlükəsiz olmalıdır (minimum 32 simvol)
- GitHub-a və ya başqa yerdə commit etməyin!
- Vercel-də Environment Variables bölməsindən əlavə edin

### 2. Vercel KV Database Quraşdırması

1. Vercel Dashboard-a daxil olun
2. Project Settings → Storage → Create Database
3. "KV" seçin
4. Database adını verin (məsələn: `saglamdad-kv`)
5. Region seçin (ən yaxını: `iad1` - US East)
6. Create Database
7. Environment variables-ı avtomatik əlavə ediləcək

### 3. Production Build Testi

```bash
# Build test etmək / Test build
npm run build

# Əgər xəta yoxdursa, production serveri işə salın / If no errors, start production server
npm start
```

### 4. Domain Konfiqurasiyası

1. Vercel Project Settings → Domains
2. `saglamdad.az` domain-ini əlavə edin
3. DNS records-ı domain provider-dən konfiqurasiya edin:
   - Type: `CNAME`
   - Name: `@` və ya `www`
   - Value: `cname.vercel-dns.com`

### 5. Default Admin Parolunu Dəyişdirmək

**⚠️ PRODUCTION-ə DEPLOY ETMƏZDƏN ƏVVƏL:**

1. Admin panelə daxil olun (`/admin`)
2. Default credentials:
   - Username: `admin`
   - Password: `admin123`
3. "Ayarlar" tab-ına keçin
4. Parolu güclü bir parolla dəyişdirin (minimum 12 simvol, rəqəm, böyük/kiçik hərf, simvol)

### 6. File Upload Limits

**Vercel-də konfiqurasiya edilməlidir / Must be configured in Vercel:**

- `next.config.js`-də artıq `10mb` limit var
- Vercel Free plan: 10MB limit
- Əgər daha böyük fayllar lazımdırsa, Vercel Pro plan düşünün

### 7. SEO Optimizasiyası (Opsional)

**`app/layout.tsx`-də metadata təkmilləşdirmə:**

```typescript
export const metadata: Metadata = {
  title: "Saglamdad.az - Təbii Bal və Arı Məhsulları",
  description: "Premium keyfiyyət, təbii bal və arı məhsulları. Səhhətiniz üçün ən yaxşısı.",
  keywords: "bal, arı məhsulları, təbii bal, saglamdad, azərbaycan",
  openGraph: {
    title: "Saglamdad.az - Təbii Bal və Arı Məhsulları",
    description: "Premium keyfiyyət, təbii bal və arı məhsulları.",
    url: "https://saglamdad.az",
    siteName: "Saglamdad.az",
    type: "website",
  },
};
```

### 8. Error Handling (Opsional)

**Global error handling üçün:**

- `app/error.tsx` - Global error boundary
- `app/not-found.tsx` - 404 səhifəsi

### 9. Analytics və Monitoring (Opsional)

**Ölçmə və monitoring üçün:**

- Vercel Analytics (Vercel-də aktivləşdirin)
- Google Analytics (opsional)
- Sentry (error tracking, opsional)

### 10. Backup və Recovery

**Məlumatların backup-i üçün:**

- Vercel KV-də məlumatlar avtomatik backup olunur
- Əlavə olaraq, admin panelindən məlumatları export edə bilərsiniz
- JSON faylları local development üçün `data/` folder-də saxlanılır

---

## 📋 Pre-Deployment Checklist / Deploy Öncəsi Yoxlama Siyahısı

### Təhlükəsizlik / Security
- [ ] JWT_SECRET environment variable təhlükəsiz random key ilə təyin edilib
- [ ] Default admin parolu production-da dəyişdirilib
- [ ] `.env` faylı `.gitignore`-da var
- [ ] API routes-larda authentication yoxlanılır
- [ ] File upload size limits konfiqurasiya edilib

### Konfiqurasiya / Configuration
- [ ] Vercel KV database yaradılıb və konfiqurasiya edilib
- [ ] Environment variables Vercel-də əlavə edilib
- [ ] Domain konfiqurasiya edilib
- [ ] `next.config.js` production üçün hazırdır

### Test / Testing
- [ ] `npm run build` uğurla işləyir
- [ ] Local-da production build test edilib
- [ ] Admin paneli işləyir
- [ ] Məhsul əlavə etmə/silme işləyir
- [ ] File upload işləyir
- [ ] Responsive dizayn test edilib (mobil, tablet, desktop)

### Məzmun / Content
- [ ] Hero section məzmunu doldurulub
- [ ] Haqqında səhifəsi məzmunu doldurulub
- [ ] Əlaqə məlumatları düzgündür
- [ ] Sosial media linkləri düzgündür
- [ ] Ən azı bir məhsul əlavə edilib

### Performance / Performans
- [ ] Rəsimlər optimizasiya edilib (WebP formatı tövsiyə olunur)
- [ ] Video faylları optimal ölçüdədir
- [ ] Loading states işləyir

---

## 🚀 Deployment Addımları / Deployment Steps

### 1. GitHub-a Push

```bash
git init
git add .
git commit -m "Initial commit - Saglamdad.az website"
git branch -M main
git remote add origin https://github.com/yourusername/saglamdad.az.git
git push -u origin main
```

### 2. Vercel-də Deploy

1. Vercel.com-a daxil olun
2. "Add New Project" klik edin
3. GitHub repository-ni seçin
4. Project Settings:
   - Framework Preset: Next.js
   - Root Directory: `./`
   - Build Command: `npm run build`
   - Output Directory: `.next`
5. Environment Variables əlavə edin (yuxarıda göstərildiyi kimi)
6. "Deploy" klik edin

### 3. Domain Əlavə Etmək

1. Vercel Project → Settings → Domains
2. `saglamdad.az` əlavə edin
3. DNS records-ı domain provider-dən konfiqurasiya edin

### 4. Post-Deployment

1. Admin panelə daxil olun (`https://saglamdad.az/admin`)
2. Default parolu dəyişdirin
3. Məzmunu doldurun (məhsullar, sosial media, haqqında, əlaqə)
4. Hero section-u konfiqurasiya edin

---

## ✅ Deployment Sonrası Yoxlama / Post-Deployment Verification

- [ ] Sayt `https://saglamdad.az` ünvanında açılır
- [ ] Admin paneli işləyir (`/admin`)
- [ ] Məhsullar görünür
- [ ] Sosial media linkləri işləyir
- [ ] File upload işləyir
- [ ] Responsive dizayn işləyir
- [ ] Footer admin bölməsi yalnız login olanda görünür
- [ ] Parol dəyişdirmə işləyir

---

## 📞 Dəstək / Support

Əgər problem yaranarsa:
1. Vercel logs-ı yoxlayın (Project → Deployments → Logs)
2. Browser console-da xətaları yoxlayın
3. Network tab-da API request-ləri yoxlayın

---

**Son yeniləmə / Last updated:** 2025-01-07
**Status:** ✅ Production üçün hazırdır / Ready for production

