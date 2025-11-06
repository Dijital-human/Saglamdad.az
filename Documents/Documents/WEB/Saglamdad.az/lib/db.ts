// Database utility for Vercel KV storage
// /az/ Verilənlər bazası utility-si - Vercel KV yaddaş üçün
// /en/ Database utility for Vercel KV storage

import { kv } from "@vercel/kv";
import fs from "fs";
import path from "path";

// /az/ Local development üçün JSON fayllar istifadə edilir
// /en/ JSON files are used for local development
const isLocalDev = !process.env.KV_REST_API_URL;
const dataDir = path.join(process.cwd(), "data");

// /az/ Data folder yoxdursa yaradır
// /en/ Creates data folder if it doesn't exist
if (isLocalDev && !fs.existsSync(dataDir)) {
  fs.mkdirSync(dataDir, { recursive: true });
}

// /az/ JSON fayl yolları
// /en/ JSON file paths
const dataFiles = {
  products: path.join(dataDir, "products.json"),
  socialMedia: path.join(dataDir, "socialMedia.json"),
  about: path.join(dataDir, "about.json"),
  contact: path.join(dataDir, "contact.json"),
  heroSection: path.join(dataDir, "heroSection.json"),
  siteSettings: path.join(dataDir, "siteSettings.json"),
  banners: path.join(dataDir, "banners.json"),
  admin: path.join(dataDir, "admin.json"),
};

// /az/ JSON faylları oxuyur
// /en/ Reads JSON files
function readJSONFile<T>(filePath: string, defaultValue: T): T {
  try {
    if (fs.existsSync(filePath)) {
      const data = fs.readFileSync(filePath, "utf-8");
      return JSON.parse(data) as T;
    }
    return defaultValue;
  } catch (error) {
    console.error(`Error reading ${filePath}:`, error);
    return defaultValue;
  }
}

// /az/ JSON fayllara yazır
// /en/ Writes to JSON files
function writeJSONFile<T>(filePath: string, data: T): void {
  try {
    fs.writeFileSync(filePath, JSON.stringify(data, null, 2), "utf-8");
  } catch (error) {
    console.error(`Error writing ${filePath}:`, error);
    throw error;
  }
}

// /az/ TypeScript interfeysləri - məlumat strukturları
// /en/ TypeScript interfaces - data structures
export interface Product {
  id: string;
  name: string;
  description: string;
  image: string; // Ana rəsm (card üçün)
  images?: string[]; // Əlavə rəsimlər
  video?: string;
  price?: number;
  createdAt: string;
  updatedAt?: string;
}

export interface SocialMedia {
  instagram: string;
  tiktok: string;
  facebook: string;
}

export interface About {
  content: string;
}

export interface Contact {
  email: string;
  phone: string;
}

export interface SiteSettings {
  footerDescription: string; // Footer təsviri / Footer description
}

export interface Banner {
  id: string; // Banner ID
  title?: string; // Banner başlığı (opsional) / Banner title (optional)
  type: "image" | "video" | "link" | "google-adsense" | "none"; // Banner tipi / Banner type
  imageUrl?: string; // Rəsm URL-i / Image URL
  videoUrl?: string; // Video URL-i / Video URL
  linkUrl?: string; // Link URL-i (rəsmə/video-ya klik edəndə) / Link URL (when clicking image/video)
  googleAdSenseCode?: string; // Google AdSense kodu / Google AdSense code
  position: "hero-top" | "hero-bottom" | "products-top" | "products-bottom" | "footer-top"; // Banner yeri / Banner position
  isActive: boolean; // Banner aktivdir? / Is banner active?
  createdAt: string; // Yaradılma tarixi / Creation date
  updatedAt?: string; // Yenilənmə tarixi / Update date
}

export interface HeroSection {
  backgroundColor: string; // Gradient start color
  backgroundColorEnd: string; // Gradient end color
  backgroundImage?: string; // Background image URL
  backgroundVideo?: string; // Background video URL
  backgroundType: "color" | "image" | "video"; // Background type
  title: string; // Hero başlığı / Hero title
  subtitle: string; // Hero alt başlığı / Hero subtitle
  titleColor: string; // Başlıq rəngi / Title color
  subtitleColor: string; // Alt başlıq rəngi / Subtitle color
}

export interface Admin {
  username: string;
  password: string;
}

// /az/ Məhsullar üçün CRUD əməliyyatları
// /en/ CRUD operations for products
export async function getProducts(): Promise<Product[]> {
  try {
    if (isLocalDev) {
      return readJSONFile<Product[]>(dataFiles.products, []);
    }
    const products = await kv.get<Product[]>("products");
    return products || [];
  } catch (error) {
    console.error("Error getting products:", error);
    return [];
  }
}

export async function getProduct(id: string): Promise<Product | null> {
  try {
    const products = await getProducts();
    return products.find((p) => p.id === id) || null;
  } catch (error) {
    console.error("Error getting product:", error);
    return null;
  }
}

export async function saveProducts(products: Product[]): Promise<void> {
  try {
    if (isLocalDev) {
      writeJSONFile(dataFiles.products, products);
      return;
    }
    await kv.set("products", products);
  } catch (error) {
    console.error("Error saving products:", error);
    throw error;
  }
}

export async function addProduct(product: Product): Promise<void> {
  const products = await getProducts();
  products.push(product);
  await saveProducts(products);
}

export async function updateProduct(id: string, updates: Partial<Product>): Promise<void> {
  const products = await getProducts();
  const index = products.findIndex((p) => p.id === id);
  if (index !== -1) {
    products[index] = { ...products[index], ...updates };
    await saveProducts(products);
  }
}

export async function deleteProduct(id: string): Promise<void> {
  const products = await getProducts();
  const filtered = products.filter((p) => p.id !== id);
  await saveProducts(filtered);
}

// /az/ Sosial media linkləri üçün əməliyyatlar
// /en/ Operations for social media links
export async function getSocialMedia(): Promise<SocialMedia> {
  try {
    if (isLocalDev) {
      return readJSONFile<SocialMedia>(dataFiles.socialMedia, { instagram: "", tiktok: "", facebook: "" });
    }
    const social = await kv.get<SocialMedia>("socialMedia");
    return social || { instagram: "", tiktok: "", facebook: "" };
  } catch (error) {
    console.error("Error getting social media:", error);
    return { instagram: "", tiktok: "", facebook: "" };
  }
}

export async function saveSocialMedia(socialMedia: SocialMedia): Promise<void> {
  try {
    if (isLocalDev) {
      writeJSONFile(dataFiles.socialMedia, socialMedia);
      return;
    }
    await kv.set("socialMedia", socialMedia);
  } catch (error) {
    console.error("Error saving social media:", error);
    throw error;
  }
}

// /az/ Haqqında məzmunu üçün əməliyyatlar
// /en/ Operations for about content
export async function getAbout(): Promise<About> {
  try {
    if (isLocalDev) {
      return readJSONFile<About>(dataFiles.about, { content: "" });
    }
    const about = await kv.get<About>("about");
    return about || { content: "" };
  } catch (error) {
    console.error("Error getting about:", error);
    return { content: "" };
  }
}

export async function saveAbout(about: About): Promise<void> {
  try {
    if (isLocalDev) {
      writeJSONFile(dataFiles.about, about);
      return;
    }
    await kv.set("about", about);
  } catch (error) {
    console.error("Error saving about:", error);
    throw error;
  }
}

// /az/ Əlaqə məlumatları üçün əməliyyatlar
// /en/ Operations for contact information
export async function getContact(): Promise<Contact> {
  try {
    if (isLocalDev) {
      return readJSONFile<Contact>(dataFiles.contact, { email: "", phone: "" });
    }
    const contact = await kv.get<Contact>("contact");
    return contact || { email: "", phone: "" };
  } catch (error) {
    console.error("Error getting contact:", error);
    return { email: "", phone: "" };
  }
}

export async function saveContact(contact: Contact): Promise<void> {
  try {
    if (isLocalDev) {
      writeJSONFile(dataFiles.contact, contact);
      return;
    }
    await kv.set("contact", contact);
  } catch (error) {
    console.error("Error saving contact:", error);
    throw error;
  }
}

// /az/ Admin məlumatları üçün əməliyyatlar
// /en/ Operations for admin data
export async function getAdmin(): Promise<Admin> {
  try {
    if (isLocalDev) {
      const admin = readJSONFile<Admin | null>(dataFiles.admin, null);
      if (!admin) {
        // /az/ Default admin yaradılır (parol: admin123)
        // /en/ Default admin is created (password: admin123)
        // /az/ Parol hash: admin123 üçün bcrypt hash
        // /en/ Password hash: bcrypt hash for admin123
        const defaultAdmin: Admin = {
          username: "admin",
          password: "$2a$10$Upipw945jkcncPSxQxpdA.35iQLMGC2NvischUa/hRT5leNeYR2SC",
        };
        writeJSONFile(dataFiles.admin, defaultAdmin);
        return defaultAdmin;
      }
      return admin;
    }
    const admin = await kv.get<Admin>("admin");
    if (!admin) {
      // /az/ Default admin yaradılır (parol sonradan dəyişdirilməlidir)
      // /en/ Default admin is created (password should be changed later)
      const defaultAdmin: Admin = {
        username: "admin",
        password: "$2a$10$rOzJUS9gYq5Q5Y5Y5Y5Y5e5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y",
      };
      await saveAdmin(defaultAdmin);
      return defaultAdmin;
    }
    return admin;
  } catch (error) {
    console.error("Error getting admin:", error);
    return { username: "admin", password: "" };
  }
}

export async function saveAdmin(admin: Admin): Promise<void> {
  try {
    if (isLocalDev) {
      writeJSONFile(dataFiles.admin, admin);
      return;
    }
    await kv.set("admin", admin);
  } catch (error) {
    console.error("Error saving admin:", error);
    throw error;
  }
}

// /az/ Hero section üçün əməliyyatlar
// /en/ Operations for hero section
export async function getHeroSection(): Promise<HeroSection> {
  try {
    const defaultHero: HeroSection = {
      backgroundColor: "#fefce8",
      backgroundColorEnd: "#fef9c3",
      backgroundType: "color",
      title: "Təbii Bal və Arı Məhsulları",
      subtitle: "Premium keyfiyyət, təbii məhsullar. Səhhətiniz üçün ən yaxşısı",
      titleColor: "#111827", // gray-900
      subtitleColor: "#374151", // gray-700
    };
    
    if (isLocalDev) {
      return readJSONFile<HeroSection>(dataFiles.heroSection, defaultHero);
    }
    const hero = await kv.get<HeroSection>("heroSection");
    return hero || defaultHero;
  } catch (error) {
    console.error("Error getting hero section:", error);
    return {
      backgroundColor: "#fefce8",
      backgroundColorEnd: "#fef9c3",
      backgroundType: "color",
      title: "Təbii Bal və Arı Məhsulları",
      subtitle: "Premium keyfiyyət, təbii məhsullar. Səhhətiniz üçün ən yaxşısı",
      titleColor: "#111827",
      subtitleColor: "#374151",
    };
  }
}

export async function saveHeroSection(heroSection: HeroSection): Promise<void> {
  try {
    if (isLocalDev) {
      writeJSONFile(dataFiles.heroSection, heroSection);
      return;
    }
    await kv.set("heroSection", heroSection);
  } catch (error) {
    console.error("Error saving hero section:", error);
    throw error;
  }
}

// /az/ Site settings üçün əməliyyatlar
// /en/ Operations for site settings
export async function getSiteSettings(): Promise<SiteSettings> {
  try {
    const defaultSettings: SiteSettings = {
      footerDescription: "Təbii bal və arı məhsullarının satışı",
    };
    
    if (isLocalDev) {
      return readJSONFile<SiteSettings>(dataFiles.siteSettings, defaultSettings);
    }
    const settings = await kv.get<SiteSettings>("siteSettings");
    return settings || defaultSettings;
  } catch (error) {
    console.error("Error getting site settings:", error);
    return {
      footerDescription: "Təbii bal və arı məhsullarının satışı",
    };
  }
}

export async function saveSiteSettings(settings: SiteSettings): Promise<void> {
  try {
    if (isLocalDev) {
      writeJSONFile(dataFiles.siteSettings, settings);
      return;
    }
    await kv.set("siteSettings", settings);
  } catch (error) {
    console.error("Error saving site settings:", error);
    throw error;
  }
}

// /az/ Banner üçün əməliyyatlar
// /en/ Operations for banners
export async function getBanners(): Promise<Banner[]> {
  try {
    if (isLocalDev) {
      return readJSONFile<Banner[]>(dataFiles.banners, []);
    }
    const banners = await kv.get<Banner[]>("banners");
    return banners || [];
  } catch (error) {
    console.error("Error getting banners:", error);
    return [];
  }
}

export async function saveBanners(banners: Banner[]): Promise<void> {
  try {
    if (isLocalDev) {
      writeJSONFile(dataFiles.banners, banners);
      return;
    }
    await kv.set("banners", banners);
  } catch (error) {
    console.error("Error saving banners:", error);
    throw error;
  }
}

export async function getBannerByPosition(position: Banner["position"]): Promise<Banner | null> {
  try {
    const banners = await getBanners();
    return banners.find((b) => b.position === position && b.isActive) || null;
  } catch (error) {
    console.error("Error getting banner by position:", error);
    return null;
  }
}
