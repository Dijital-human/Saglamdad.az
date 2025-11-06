# Yaddaş Sistemi / Storage System

## Admin Panelə Daxil Olmaq

### URL Strukturu
- **Subdomain YOX** - Sadəcə route istifadə olunur
- Production: `https://saglamdad.az/admin`
- Local: `http://localhost:3000/admin`

### Giriş Məlumatları
- **İstifadəçi adı:** `admin`
- **Şifrə:** `admin123` (ilk istifadədən sonra mütləq dəyişdirin!)

### Autentifikasiya
- JWT token istifadə olunur
- Token 7 gün etibarlıdır
- Browser localStorage-də saxlanılır

---

## Yaddaş Sistemi

### Production (Vercel)
- **Yaddaş:** Vercel KV (cloud database)
- **Format:** Key-value storage
- **Avantajlar:**
  - Sürətli
  - Scalable
  - Vercel-də native dəstək
  - Free tier mövcuddur

### Local Development
- **Yaddaş:** JSON fayllar
- **Yer:** `data/` folder
- **Fayllar:**
  - `data/products.json` - Məhsullar
  - `data/socialMedia.json` - Sosial media linkləri
  - `data/about.json` - Haqqında məzmunu
  - `data/contact.json` - Əlaqə məlumatları
  - `data/admin.json` - Admin məlumatları

### JSON Fayl Strukturu

#### products.json
```json
[
  {
    "id": "1234567890",
    "name": "Təbii Bal",
    "description": "Premium keyfiyyətli bal",
    "image": "https://example.com/image.jpg",
    "video": "https://example.com/video.mp4",
    "price": 25.50,
    "createdAt": "2025-01-07T10:00:00.000Z"
  }
]
```

#### socialMedia.json
```json
{
  "instagram": "https://instagram.com/saglamdad",
  "tiktok": "https://tiktok.com/@saglamdad",
  "facebook": "https://facebook.com/saglamdad"
}
```

#### about.json
```json
{
  "content": "Haqqımızda məzmunu buraya yazılır..."
}
```

#### contact.json
```json
{
  "email": "info@saglamdad.az",
  "phone": "+994501234567"
}
```

#### admin.json
```json
{
  "username": "admin",
  "password": "$2a$10$rOzJUS9gYq5Q5Y5Y5Y5Y5e5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y"
}
```

---

## Avtomatik Seçim

Sistem avtomatik olaraq yaddaş metodunu seçir:
- Əgər `KV_REST_API_URL` environment variable varsa → Vercel KV istifadə edir
- Əgər yoxdursa → JSON fayllar istifadə edir

---

## Qeyd

- JSON fayllar `.gitignore`-dədir, git-ə commit olunmur
- Production-da Vercel KV istifadə olunacaq
- Local development-da JSON fayllar istifadə olunur və server yenidən başladıqda da qalır

