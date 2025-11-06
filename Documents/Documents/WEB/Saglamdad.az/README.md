# Saglamdad.az

Bal və arı məhsullarının satışı üçün veb saytı.

Website for selling honey and bee products.

## Xüsusiyyətlər / Features

- **Admin Paneli / Admin Panel**: Saytın bütün məzmununu idarə etmək üçün admin paneli
- **Məhsul İdarəetməsi / Product Management**: Məhsulların əlavə edilməsi, redaktəsi və silinməsi
- **Sosial Media Linkləri / Social Media Links**: Instagram, TikTok, Facebook linkləri
- **Haqqında Səhifəsi / About Page**: Admin tərəfindən idarə olunan məzmun
- **Əlaqə Səhifəsi / Contact Page**: Email və telefon əlaqə məlumatları
- **Responsiv Dizayn / Responsive Design**: Mobil, tablet və desktop üçün uyğunlaşdırılmış
- **Animasiyalar / Animations**: Framer Motion ilə modern animasiyalar

## Texnologiyalar / Technologies

- **Next.js 14**: React framework
- **TypeScript**: Type safety
- **Tailwind CSS**: Styling
- **Framer Motion**: Animations
- **Vercel KV**: Database storage
- **bcryptjs**: Password hashing
- **jsonwebtoken**: Authentication

## Quraşdırma / Installation

```bash
# Dependencies quraşdırmaq / Install dependencies
npm install

# Development serveri işə salmaq / Run development server
npm run dev

# Production build / Production build
npm run build
npm start
```

## Vercel KV Konfiqurasiyası / Vercel KV Configuration

1. Vercel-də KV database yaradın / Create KV database in Vercel
2. Environment variables əlavə edin / Add environment variables:
   - `KV_REST_API_URL`
   - `KV_REST_API_TOKEN`
   - `JWT_SECRET` (production üçün təhlükəsiz key istifadə edin)

## İstifadə / Usage

### Admin Paneli / Admin Panel

1. `/admin` səhifəsinə keçin / Navigate to `/admin`
2. Default credentials / Default credentials:
   - Username: `admin`
   - Password: `admin123` (ilk istifadədən sonra dəyişdirin / change after first use)

### Məhsul Əlavə Etmək / Adding Products

1. Admin panelində "Məhsullar" tab-ına keçin / Go to "Products" tab in admin panel
2. Məhsul məlumatlarını doldurun / Fill product information
3. Rəsm URL və video URL (opsional) əlavə edin / Add image URL and video URL (optional)
4. "Əlavə et" düyməsinə basın / Click "Add" button

### Sosial Media Linkləri / Social Media Links

1. Admin panelində "Sosial Media" tab-ına keçin / Go to "Social Media" tab
2. Instagram, TikTok və Facebook linklərini daxil edin / Enter links
3. "Saxla" düyməsinə basın / Click "Save"

## Struktur / Structure

```
├── app/
│   ├── api/              # API routes
│   ├── admin/            # Admin panel page
│   ├── about/            # About page
│   ├── contact/          # Contact page
│   └── page.tsx          # Home page
├── components/           # React components
├── lib/                  # Utility functions
│   ├── db.ts            # Database operations
│   └── auth.ts          # Authentication
└── public/               # Static files
```

## Lisans / License

Bu layihə özəl mülkiyyətdir / This project is private property.

