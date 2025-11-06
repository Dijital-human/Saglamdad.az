# Domain Konfiqurasiyası / Domain Configuration Guide

## 🔴 404 Xətası Həll Yolları

### Problem: Domain bağlandıqdan sonra 404 xətası

Bu problem adətən aşağıdakı səbəblərdən ola bilər:

---

## 1. DNS Konfiqurasiyası Yoxlaması

### Vercel Dashboard-da:
1. **Settings → Domains**
2. `saglamdad.az` domain-ini tapın
3. **Status** yoxlayın:
   - ✅ **Valid Configuration** - DNS düzgündür
   - ⚠️ **Invalid Configuration** - DNS düzəldilməlidir
   - ⏳ **Pending** - DNS propagasiya gözləyir (24-48 saat)

### Domain Provider-də (məs: Namecheap, GoDaddy):
1. DNS Records yoxlayın:
   - **Type:** `CNAME` və ya `A`
   - **Name:** `@` (root domain) və ya `www`
   - **Value:** Vercel-dən göstərilən dəyər
     - CNAME: `cname.vercel-dns.com`
     - A Record: Vercel IP ünvanları (Vercel-də göstərilir)

2. **DNS Propagasiya:**
   - DNS dəyişiklikləri 24-48 saat çəkə bilər
   - Yoxlamaq üçün: https://dnschecker.org/#A/saglamdad.az

---

## 2. Vercel Domain Konfiqurasiyası

### Addım-addım:

1. **Vercel Dashboard → Proyekt → Settings → Domains**

2. **Domain Əlavə Et:**
   - `saglamdad.az` yazın
   - "Add" klikləyin

3. **DNS Records:**
   - Vercel sizə DNS records göstərəcək
   - Bu records-ı domain provider-də əlavə edin

4. **SSL Sertifikat:**
   - Vercel avtomatik SSL sertifikat yaradacaq
   - 24 saat çəkə bilər

---

## 3. 404 Xətası Həll Yolları

### Problem 1: DNS Propagasiya

**Səbəb:** DNS dəyişiklikləri hələ propagasiya olmayıb

**Həll:**
- 24-48 saat gözləyin
- DNS checker ilə yoxlayın: https://dnschecker.org

---

### Problem 2: Yanlış DNS Records

**Səbəb:** Domain provider-də yanlış DNS records

**Həll:**
1. Vercel Dashboard → Settings → Domains
2. `saglamdad.az` üzərinə klikləyin
3. DNS records-ı yenidən kopyalayın
4. Domain provider-də düzəldin

---

### Problem 3: Vercel Cache

**Səbəb:** Vercel cache-də köhnə konfiqurasiya

**Həll:**
1. Vercel Dashboard → Deployments
2. "Redeploy" klikləyin
3. Və ya yeni commit push edin

---

### Problem 4: Root Directory Problemi

**Səbəb:** Vercel-də Root Directory yanlış təyin edilib

**Həll:**
1. Settings → General
2. Root Directory: **boş** və ya `.` olmalıdır
3. Save → Redeploy

---

## 4. Yoxlama Addımları

### 1. DNS Yoxlaması:
```bash
# Terminal-də:
nslookup saglamdad.az
# və ya
dig saglamdad.az
```

### 2. Browser-də:
- `https://saglamdad.az` - Ana səhifə
- `https://saglamdad.az/admin` - Admin panel
- `https://saglamdad.az/api/products` - API test

### 3. Vercel Logs:
- Vercel Dashboard → Deployments → Logs
- Xətaları yoxlayın

---

## 5. SSL Sertifikat Problemi

### Problem: "Not Secure" və ya SSL xətası

**Həll:**
1. Vercel Dashboard → Settings → Domains
2. SSL status yoxlayın
3. Əgər "Pending"dirsə, 24 saat gözləyin
4. Əgər "Error"dirsə, domain-i silib yenidən əlavə edin

---

## 6. WWW və Non-WWW Redirect

### Vercel avtomatik idarə edir:
- `www.saglamdad.az` → `saglamdad.az` (avtomatik redirect)
- Və ya əksinə (Vercel Settings-də seçə bilərsiniz)

---

## 7. Əgər Hələ Də Problem Varsa

### Vercel Support:
1. Vercel Dashboard → Help → Support
2. Problem təsvir edin
3. Domain və deployment logs göndərin

### Yoxlama Siyahısı:
- [ ] DNS records düzgündür
- [ ] DNS propagasiya tamamlanıb (24-48 saat)
- [ ] SSL sertifikat aktivdir
- [ ] Vercel-də domain status "Valid"
- [ ] Root Directory düzgündür
- [ ] Build uğurlu olub
- [ ] Redeploy edilib

---

## 📞 Dəstək

Əgər problem davam edərsə:
1. Vercel logs yoxlayın
2. Browser console-da xətaları yoxlayın
3. Network tab-da request-ləri yoxlayın
4. DNS checker ilə DNS status yoxlayın

---

**Son yeniləmə:** 2025-11-06

