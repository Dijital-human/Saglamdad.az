"use client";

// Admin Dashboard Component
// /az/ Admin paneli komponenti - bütün idarə funksiyaları
// /en/ Admin dashboard component - all management functions

import { useState, useEffect } from "react";
import { motion } from "framer-motion";
import { 
  Package, 
  Globe, 
  FileText, 
  Mail, 
  Phone, 
  LogOut,
  Plus,
  Trash2,
  Edit,
  Save,
  X,
  Image as ImageIcon,
  Video,
  Palette,
  Settings,
  Lock,
  Megaphone
} from "lucide-react";
import { Product, SocialMedia, About, Contact, HeroSection, SiteSettings, Banner } from "@/lib/db";

interface AdminDashboardProps {
  onLogout: () => void;
}

export default function AdminDashboard({ onLogout }: AdminDashboardProps) {
  const [activeTab, setActiveTab] = useState<"products" | "social" | "about" | "contact" | "hero" | "banner" | "settings">("products");
  const [products, setProducts] = useState<Product[]>([]);
  const [socialMedia, setSocialMedia] = useState<SocialMedia>({ instagram: "", tiktok: "", facebook: "" });
  const [about, setAbout] = useState<About>({ content: "" });
  const [contact, setContact] = useState<Contact>({ email: "", phone: "" });
  const [siteSettings, setSiteSettings] = useState<SiteSettings>({
    footerDescription: "Təbii bal və arı məhsullarının satışı",
  });
  const [banners, setBanners] = useState<Banner[]>([]);
  const [bannerForm, setBannerForm] = useState<Partial<Banner>>({
    title: "",
    type: "none",
    position: "hero-bottom",
    isActive: false,
  });
  const [heroSection, setHeroSection] = useState<HeroSection>({
    backgroundColor: "#fefce8",
    backgroundColorEnd: "#fef9c3",
    backgroundType: "color",
    title: "Təbii Bal və Arı Məhsulları",
    subtitle: "Premium keyfiyyət, təbii məhsullar. Səhhətiniz üçün ən yaxşısı",
    titleColor: "#111827",
    subtitleColor: "#374151",
  });
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  
  // Product form state
  const [productForm, setProductForm] = useState<Partial<Product>>({
    name: "",
    description: "",
    image: "",
    images: [],
    video: "",
    price: 0,
  });
  const [editingProductId, setEditingProductId] = useState<string | null>(null);
  const [uploadingImage, setUploadingImage] = useState(false);
  const [uploadingVideo, setUploadingVideo] = useState(false);
  const [uploadingImages, setUploadingImages] = useState(false);
  const [uploadingBannerImage, setUploadingBannerImage] = useState(false);
  const [uploadingBannerVideo, setUploadingBannerVideo] = useState(false);
  const [editingBannerId, setEditingBannerId] = useState<string | null>(null);
  
  // Password change form state
  const [passwordForm, setPasswordForm] = useState({
    currentPassword: "",
    newPassword: "",
    confirmPassword: "",
  });
  const [changingPassword, setChangingPassword] = useState(false);

  useEffect(() => {
    fetchAllData();
  }, []);

  const fetchAllData = async () => {
    try {
      const [productsRes, socialRes, aboutRes, contactRes, heroRes, siteSettingsRes, bannersRes] = await Promise.all([
        fetch("/api/products"),
        fetch("/api/social-media"),
        fetch("/api/about"),
        fetch("/api/contact"),
        fetch("/api/hero-section"),
        fetch("/api/site-settings"),
        fetch("/api/banners"),
      ]);

      setProducts(await productsRes.json());
      setSocialMedia(await socialRes.json());
      setAbout(await aboutRes.json());
      setContact(await contactRes.json());
      setHeroSection(await heroRes.json());
      setSiteSettings(await siteSettingsRes.json());
      setBanners(await bannersRes.json());
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };

  // /az/ Auth token almaq üçün helper funksiya
  // /en/ Helper function to get auth token
  const getAuthHeaders = () => {
    const token = localStorage.getItem("adminToken");
    return {
      "Content-Type": "application/json",
      Authorization: `Bearer ${token}`,
    };
  };

  // /az/ Məhsulları yaddaşda saxla
  // /en/ Save products to storage
  const handleSaveProducts = async (productsToSave?: Product[]) => {
    setSaving(true);
    try {
      const productsToStore = productsToSave || products;
      const res = await fetch("/api/products", {
        method: "POST",
        headers: getAuthHeaders(),
        body: JSON.stringify(productsToStore),
      });
      if (res.ok) {
        // Alert yalnız əllə çağırılanda (manual save)
        if (!productsToSave) {
          alert("Məhsullar saxlanıldı / Products saved");
        }
      }
    } catch (error) {
      alert("Xəta baş verdi / Error occurred");
    } finally {
      setSaving(false);
    }
  };

  // /az/ Ana rəsm yükləmə funksiyası (card üçün)
  // /en/ Main image upload function (for card)
  const handleImageUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setUploadingImage(true);
    try {
      const formData = new FormData();
      formData.append("file", file);
      formData.append("type", "image");

      const token = localStorage.getItem("adminToken");
      const res = await fetch("/api/upload", {
        method: "POST",
        headers: {
          Authorization: `Bearer ${token}`,
        },
        body: formData,
      });

      const data = await res.json();

      if (res.ok) {
        setProductForm({ ...productForm, image: data.url });
      } else {
        alert(data.error || "Rəsm yüklənə bilmədi");
      }
    } catch (error) {
      alert("Xəta baş verdi");
    } finally {
      setUploadingImage(false);
    }
  };

  // /az/ Çoxsaylı rəsm yükləmə funksiyası
  // /en/ Multiple images upload function
  const handleMultipleImagesUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (!files || files.length === 0) return;

    setUploadingImages(true);
    try {
      const uploadPromises = Array.from(files).map(async (file) => {
        const formData = new FormData();
        formData.append("file", file);
        formData.append("type", "image");

        const token = localStorage.getItem("adminToken");
        const res = await fetch("/api/upload", {
          method: "POST",
          headers: {
            Authorization: `Bearer ${token}`,
          },
          body: formData,
        });

        const data = await res.json();
        if (res.ok) {
          return data.url;
        }
        return null;
      });

      const uploadedUrls = (await Promise.all(uploadPromises)).filter((url) => url !== null) as string[];
      const currentImages = productForm.images || [];
      setProductForm({ ...productForm, images: [...currentImages, ...uploadedUrls] });
    } catch (error) {
      alert("Xəta baş verdi");
    } finally {
      setUploadingImages(false);
    }
  };

  // /az/ Video yükləmə funksiyası
  // /en/ Video upload function
  const handleVideoUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setUploadingVideo(true);
    try {
      const formData = new FormData();
      formData.append("file", file);
      formData.append("type", "video");

      const token = localStorage.getItem("adminToken");
      const res = await fetch("/api/upload", {
        method: "POST",
        headers: {
          Authorization: `Bearer ${token}`,
        },
        body: formData,
      });

      const data = await res.json();

      if (res.ok) {
        setProductForm({ ...productForm, video: data.url });
      } else {
        alert(data.error || "Video yüklənə bilmədi / Failed to upload video");
      }
    } catch (error) {
      alert("Xəta baş verdi / Error occurred");
    } finally {
      setUploadingVideo(false);
    }
  };

  const handleAddProduct = () => {
    // /az/ Validation - rəsm məcburidir
    // /en/ Validation - image is required
    if (!productForm.image) {
      alert("Zəhmət olmasa ana rəsm yükləyin");
      return;
    }

    if (!productForm.name || !productForm.description) {
      alert("Məhsul adı və təsvir məcburidir");
      return;
    }

    const newProduct: Product = {
      id: Date.now().toString(),
      name: productForm.name || "",
      description: productForm.description || "",
      image: productForm.image || "",
      images: productForm.images || [],
      video: productForm.video,
      price: productForm.price,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };
    const updatedProducts = [...products, newProduct];
    setProducts(updatedProducts);
    setProductForm({ name: "", description: "", image: "", images: [], video: "", price: 0 });
    // /az/ Yaddaşda saxla (yeni məhsul ilə birlikdə)
    // /en/ Save to storage (with new product)
    handleSaveProducts(updatedProducts);
  };

  // /az/ Məhsul redaktə etmə funksiyası
  // /en/ Product edit function
  const handleEditProduct = (product: Product) => {
    if (product && product.id) {
      setEditingProductId(product.id);
      setProductForm({
        name: product.name,
        description: product.description,
        image: product.image,
        images: product.images || [],
        video: product.video,
        price: product.price,
      });
      // Scroll to form
      window.scrollTo({ top: 0, behavior: "smooth" });
    } else {
      // Cancel edit
      setEditingProductId(null);
      setProductForm({ name: "", description: "", image: "", images: [], video: "", price: 0 });
    }
  };

  // /az/ Məhsul yeniləmə funksiyası
  // /en/ Product update function
  const handleUpdateProduct = () => {
    if (!editingProductId) return;

    if (!productForm.image) {
      alert("Zəhmət olmasa ana rəsm yükləyin");
      return;
    }

    if (!productForm.name || !productForm.description) {
      alert("Məhsul adı və təsvir məcburidir");
      return;
    }

    const updatedProducts = products.map((p) =>
      p.id === editingProductId
        ? {
            ...p,
            name: productForm.name || "",
            description: productForm.description || "",
            image: productForm.image || "",
            images: productForm.images || [],
            video: productForm.video,
            price: productForm.price,
            updatedAt: new Date().toISOString(),
          }
        : p
    );

    setProducts(updatedProducts);
    setEditingProductId(null);
    setProductForm({ name: "", description: "", image: "", images: [], video: "", price: 0 });
    // /az/ Yaddaşda saxla (yenilənmiş məhsulları birbaşa göndər)
    // /en/ Save to storage (send updated products directly)
    handleSaveProducts(updatedProducts);
  };

  // /az/ Rəsm silmə funksiyası
  // /en/ Remove image function
  const handleRemoveImage = (index: number) => {
    const currentImages = productForm.images || [];
    setProductForm({ ...productForm, images: currentImages.filter((_, i) => i !== index) });
  };

  const handleDeleteProduct = async (id: string) => {
    if (confirm("Məhsulu silmək istəyirsiniz?")) {
      try {
        const res = await fetch(`/api/products/${id}`, {
          method: "DELETE",
          headers: getAuthHeaders(),
        });
        if (res.ok) {
          const updatedProducts = products.filter((p) => p.id !== id);
          setProducts(updatedProducts);
          // /az/ Yaddaşdan da silinir (yenilənmiş siyahını göndər)
          // /en/ Also deleted from storage (send updated list)
          await handleSaveProducts(updatedProducts);
        }
      } catch (error) {
        alert("Xəta baş verdi");
      }
    }
  };

  const handleSaveSocialMedia = async () => {
    setSaving(true);
    try {
      const res = await fetch("/api/social-media", {
        method: "POST",
        headers: getAuthHeaders(),
        body: JSON.stringify(socialMedia),
      });
      if (res.ok) {
        alert("Sosial media linkləri saxlanıldı");
      }
    } catch (error) {
      alert("Xəta baş verdi");
    } finally {
      setSaving(false);
    }
  };

  const handleSaveAbout = async () => {
    setSaving(true);
    try {
      const res = await fetch("/api/about", {
        method: "POST",
        headers: getAuthHeaders(),
        body: JSON.stringify(about),
      });
      if (res.ok) {
        alert("Haqqında məzmunu saxlanıldı");
      }
    } catch (error) {
      alert("Xəta baş verdi");
    } finally {
      setSaving(false);
    }
  };

  const handleSaveContact = async () => {
    setSaving(true);
    try {
      await Promise.all([
        fetch("/api/contact", {
          method: "POST",
          headers: getAuthHeaders(),
          body: JSON.stringify(contact),
        }),
        fetch("/api/site-settings", {
          method: "POST",
          headers: getAuthHeaders(),
          body: JSON.stringify(siteSettings),
        }),
      ]);
      alert("Əlaqə məlumatları və footer təsviri saxlanıldı / Contact info and footer description saved");
    } catch (error) {
      alert("Xəta baş verdi / Error occurred");
    } finally {
      setSaving(false);
    }
  };

  const handleSaveSiteSettings = async () => {
    setSaving(true);
    try {
      const res = await fetch("/api/site-settings", {
        method: "POST",
        headers: getAuthHeaders(),
        body: JSON.stringify(siteSettings),
      });
      if (res.ok) {
        alert("Site settings saxlanıldı / Site settings saved");
      }
    } catch (error) {
      alert("Xəta baş verdi / Error occurred");
    } finally {
      setSaving(false);
    }
  };

  // /az/ Banner rəsm yükləmə funksiyası
  // /en/ Banner image upload function
  const handleBannerImageUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setUploadingBannerImage(true);
    try {
      const formData = new FormData();
      formData.append("file", file);
      formData.append("type", "image");

      const token = localStorage.getItem("adminToken");
      const res = await fetch("/api/upload", {
        method: "POST",
        headers: {
          Authorization: `Bearer ${token}`,
        },
        body: formData,
      });

      const data = await res.json();

      if (res.ok) {
        setBannerForm({ ...bannerForm, imageUrl: data.url, type: "image" });
      } else {
        alert(data.error || "Rəsm yüklənə bilmədi");
      }
    } catch (error) {
      alert("Xəta baş verdi");
    } finally {
      setUploadingBannerImage(false);
    }
  };

  // /az/ Banner video yükləmə funksiyası
  // /en/ Banner video upload function
  const handleBannerVideoUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setUploadingBannerVideo(true);
    try {
      const formData = new FormData();
      formData.append("file", file);
      formData.append("type", "video");

      const token = localStorage.getItem("adminToken");
      const res = await fetch("/api/upload", {
        method: "POST",
        headers: {
          Authorization: `Bearer ${token}`,
        },
        body: formData,
      });

      const data = await res.json();

      if (res.ok) {
        setBannerForm({ ...bannerForm, videoUrl: data.url, type: "video" });
      } else {
        alert(data.error || "Video yüklənə bilmədi");
      }
    } catch (error) {
      alert("Xəta baş verdi");
    } finally {
      setUploadingBannerVideo(false);
    }
  };

  // /az/ Banner əlavə etmə funksiyası
  // /en/ Add banner function
  const handleAddBanner = () => {
    if (!bannerForm.position || bannerForm.type === "none") {
      alert("Zəhmət olmasa banner yeri və tipini seçin");
      return;
    }

    if (bannerForm.type === "image" && !bannerForm.imageUrl) {
      alert("Zəhmət olmasa rəsm yükləyin");
      return;
    }

    if (bannerForm.type === "video" && !bannerForm.videoUrl) {
      alert("Zəhmət olmasa video yükləyin");
      return;
    }

    if (bannerForm.type === "google-adsense" && !bannerForm.googleAdSenseCode) {
      alert("Zəhmət olmasa Google AdSense kodunu daxil edin");
      return;
    }

    const newBanner: Banner = {
      id: Date.now().toString(),
      title: bannerForm.title || "",
      type: bannerForm.type || "image",
      imageUrl: bannerForm.imageUrl,
      videoUrl: bannerForm.videoUrl,
      linkUrl: bannerForm.linkUrl,
      googleAdSenseCode: bannerForm.googleAdSenseCode,
      position: bannerForm.position || "hero-bottom",
      isActive: bannerForm.isActive || false,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };

    const updatedBanners = [...banners, newBanner];
    setBanners(updatedBanners);
    setBannerForm({ title: "", type: "none", position: "hero-bottom", isActive: false });
    handleSaveBanners(updatedBanners);
  };

  // /az/ Banner redaktə etmə funksiyası
  // /en/ Edit banner function
  const handleEditBanner = (banner: Banner) => {
    setEditingBannerId(banner.id);
    setBannerForm({
      title: banner.title,
      type: banner.type,
      imageUrl: banner.imageUrl,
      videoUrl: banner.videoUrl,
      linkUrl: banner.linkUrl,
      googleAdSenseCode: banner.googleAdSenseCode,
      position: banner.position,
      isActive: banner.isActive,
    });
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  // /az/ Banner yeniləmə funksiyası
  // /en/ Update banner function
  const handleUpdateBanner = () => {
    if (!editingBannerId) return;

    if (!bannerForm.position || bannerForm.type === "none") {
      alert("Zəhmət olmasa banner yeri və tipini seçin");
      return;
    }

    const updatedBanners = banners.map((b) =>
      b.id === editingBannerId
        ? {
            ...b,
            title: bannerForm.title || "",
            type: bannerForm.type || "image",
            imageUrl: bannerForm.imageUrl,
            videoUrl: bannerForm.videoUrl,
            linkUrl: bannerForm.linkUrl,
            googleAdSenseCode: bannerForm.googleAdSenseCode,
            position: bannerForm.position || "hero-bottom",
            isActive: bannerForm.isActive || false,
            updatedAt: new Date().toISOString(),
          }
        : b
    );

    setBanners(updatedBanners);
    setEditingBannerId(null);
    setBannerForm({ title: "", type: "none", position: "hero-bottom", isActive: false });
    handleSaveBanners(updatedBanners);
  };

  // /az/ Banner silmə funksiyası
  // /en/ Delete banner function
  const handleDeleteBanner = (id: string) => {
    if (confirm("Banner-i silmək istəyirsiniz?")) {
      const updatedBanners = banners.filter((b) => b.id !== id);
      setBanners(updatedBanners);
      handleSaveBanners(updatedBanners);
    }
  };

  // /az/ Banner-ləri yaddaşda saxla
  // /en/ Save banners to storage
  const handleSaveBanners = async (bannersToSave?: Banner[]) => {
    setSaving(true);
    try {
      const bannersToStore = bannersToSave || banners;
      const res = await fetch("/api/banners", {
        method: "POST",
        headers: getAuthHeaders(),
        body: JSON.stringify(bannersToStore),
      });
      if (res.ok) {
        if (!bannersToSave) {
          alert("Banner-lər saxlanıldı / Banners saved");
        }
      }
    } catch (error) {
      alert("Xəta baş verdi / Error occurred");
    } finally {
      setSaving(false);
    }
  };

  // /az/ Parol dəyişdirmə funksiyası
  // /en/ Change password function
  const handleChangePassword = async () => {
    if (!passwordForm.currentPassword || !passwordForm.newPassword || !passwordForm.confirmPassword) {
      alert("Zəhmət olmasa bütün sahələri doldurun / Please fill all fields");
      return;
    }

    if (passwordForm.newPassword.length < 6) {
      alert("Yeni parol ən azı 6 simvol olmalıdır / New password must be at least 6 characters");
      return;
    }

    if (passwordForm.newPassword !== passwordForm.confirmPassword) {
      alert("Yeni parol və təsdiq parolu uyğun deyil / New password and confirm password do not match");
      return;
    }

    setChangingPassword(true);
    try {
      const res = await fetch("/api/auth/change-password", {
        method: "POST",
        headers: getAuthHeaders(),
        body: JSON.stringify({
          currentPassword: passwordForm.currentPassword,
          newPassword: passwordForm.newPassword,
        }),
      });

      const data = await res.json();

      if (res.ok) {
        alert("Parol uğurla dəyişdirildi / Password changed successfully");
        setPasswordForm({
          currentPassword: "",
          newPassword: "",
          confirmPassword: "",
        });
      } else {
        alert(data.error || "Parol dəyişdirilə bilmədi / Failed to change password");
      }
    } catch (error) {
      alert("Xəta baş verdi / Error occurred");
    } finally {
      setChangingPassword(false);
    }
  };

  // /az/ Hero section background upload funksiyaları
  // /en/ Hero section background upload functions
  const handleHeroImageUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setSaving(true);
    try {
      const formData = new FormData();
      formData.append("file", file);
      formData.append("type", "image");

      const token = localStorage.getItem("adminToken");
      const res = await fetch("/api/upload", {
        method: "POST",
        headers: {
          Authorization: `Bearer ${token}`,
        },
        body: formData,
      });

      const data = await res.json();

      if (res.ok) {
        setHeroSection({ ...heroSection, backgroundImage: data.url });
      } else {
        alert(data.error || "Rəsm yüklənə bilmədi");
      }
    } catch (error) {
      alert("Xəta baş verdi");
    } finally {
      setSaving(false);
    }
  };

  const handleHeroVideoUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setSaving(true);
    try {
      const formData = new FormData();
      formData.append("file", file);
      formData.append("type", "video");

      const token = localStorage.getItem("adminToken");
      const res = await fetch("/api/upload", {
        method: "POST",
        headers: {
          Authorization: `Bearer ${token}`,
        },
        body: formData,
      });

      const data = await res.json();

      if (res.ok) {
        setHeroSection({ ...heroSection, backgroundVideo: data.url });
      } else {
        alert(data.error || "Video yüklənə bilmədi");
      }
    } catch (error) {
      alert("Xəta baş verdi");
    } finally {
      setSaving(false);
    }
  };

  const handleSaveHeroSection = async () => {
    setSaving(true);
    try {
      const res = await fetch("/api/hero-section", {
        method: "POST",
        headers: getAuthHeaders(),
        body: JSON.stringify(heroSection),
      });
      if (res.ok) {
        alert("Hero section saxlanıldı");
      }
    } catch (error) {
      alert("Xəta baş verdi");
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="bg-white shadow-sm border-b">
        <div className="container mx-auto px-4 py-4 flex justify-between items-center">
          <h1 className="text-2xl font-bold text-gray-900">Admin Paneli</h1>
          <button
            onClick={onLogout}
            className="flex items-center gap-2 px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors"
          >
            <LogOut className="w-4 h-4" />
            Çıxış
          </button>
        </div>
      </div>

      <div className="container mx-auto px-4 py-8">
        {/* Tabs */}
        <div className="flex flex-wrap gap-2 mb-8">
          <TabButton
            active={activeTab === "products"}
            onClick={() => setActiveTab("products")}
            icon={Package}
            label="Məhsullar"
          />
          <TabButton
            active={activeTab === "social"}
            onClick={() => setActiveTab("social")}
            icon={Globe}
            label="Sosial Media"
          />
          <TabButton
            active={activeTab === "about"}
            onClick={() => setActiveTab("about")}
            icon={FileText}
            label="Haqqında"
          />
          <TabButton
            active={activeTab === "contact"}
            onClick={() => setActiveTab("contact")}
            icon={Mail}
            label="Əlaqə"
          />
          <TabButton
            active={activeTab === "hero"}
            onClick={() => setActiveTab("hero")}
            icon={Palette}
            label="Hero Section"
          />
          <TabButton
            active={activeTab === "banner"}
            onClick={() => setActiveTab("banner")}
            icon={Megaphone}
            label="Reklam Banerləri"
          />
          <TabButton
            active={activeTab === "settings"}
            onClick={() => setActiveTab("settings")}
            icon={Settings}
            label="Ayarlar"
          />
        </div>

        {/* Content */}
        <div className="bg-white rounded-lg shadow-lg p-6">
          {activeTab === "products" && (
            <ProductsTab
              products={products}
              productForm={productForm}
              setProductForm={setProductForm}
              onAdd={handleAddProduct}
              onUpdate={handleUpdateProduct}
              onEdit={handleEditProduct}
              onDelete={handleDeleteProduct}
              onRemoveImage={handleRemoveImage}
              saving={saving}
              editingProductId={editingProductId}
              onImageUpload={handleImageUpload}
              onMultipleImagesUpload={handleMultipleImagesUpload}
              onVideoUpload={handleVideoUpload}
              uploadingImage={uploadingImage}
              uploadingImages={uploadingImages}
              uploadingVideo={uploadingVideo}
            />
          )}

          {activeTab === "social" && (
            <SocialMediaTab
              socialMedia={socialMedia}
              setSocialMedia={setSocialMedia}
              onSave={handleSaveSocialMedia}
              saving={saving}
            />
          )}

          {activeTab === "about" && (
            <AboutTab
              about={about}
              setAbout={setAbout}
              onSave={handleSaveAbout}
              saving={saving}
            />
          )}

          {activeTab === "contact" && (
            <ContactTab
              contact={contact}
              setContact={setContact}
              siteSettings={siteSettings}
              setSiteSettings={setSiteSettings}
              onSave={handleSaveContact}
              saving={saving}
            />
          )}

          {activeTab === "hero" && (
            <HeroSectionTab
              heroSection={heroSection}
              setHeroSection={setHeroSection}
              onSave={handleSaveHeroSection}
              onImageUpload={handleHeroImageUpload}
              onVideoUpload={handleHeroVideoUpload}
              saving={saving}
            />
          )}

          {activeTab === "banner" && (
            <BannerTab
              banners={banners}
              bannerForm={bannerForm}
              setBannerForm={setBannerForm}
              onAdd={handleAddBanner}
              onUpdate={handleUpdateBanner}
              onEdit={handleEditBanner}
              onDelete={handleDeleteBanner}
              onImageUpload={handleBannerImageUpload}
              onVideoUpload={handleBannerVideoUpload}
              onCancelEdit={() => {
                setEditingBannerId(null);
                setBannerForm({ title: "", type: "none", position: "hero-bottom", isActive: false });
              }}
              saving={saving}
              editingBannerId={editingBannerId}
              uploadingBannerImage={uploadingBannerImage}
              uploadingBannerVideo={uploadingBannerVideo}
            />
          )}

          {activeTab === "settings" && (
            <SettingsTab
              passwordForm={passwordForm}
              setPasswordForm={setPasswordForm}
              onChangePassword={handleChangePassword}
              changingPassword={changingPassword}
            />
          )}
        </div>
      </div>
    </div>
  );
}

// /az/ Tab düyməsi komponenti
// /en/ Tab button component
function TabButton({ active, onClick, icon: Icon, label }: { active: boolean; onClick: () => void; icon: any; label: string }) {
  return (
    <button
      onClick={onClick}
      className={`flex items-center gap-2 px-4 py-2 rounded-lg transition-colors ${
        active
          ? "bg-primary-600 text-white"
          : "bg-gray-200 text-gray-700 hover:bg-gray-300"
      }`}
    >
      <Icon className="w-5 h-5" />
      <span>{label}</span>
    </button>
  );
}

// /az/ Məhsullar tab komponenti
// /en/ Products tab component
function ProductsTab({
  products,
  productForm,
  setProductForm,
  onAdd,
  onUpdate,
  onEdit,
  onDelete,
  onRemoveImage,
  saving,
  editingProductId,
  onImageUpload,
  onMultipleImagesUpload,
  onVideoUpload,
  uploadingImage,
  uploadingImages,
  uploadingVideo,
}: {
  products: Product[];
  productForm: Partial<Product>;
  setProductForm: (form: Partial<Product>) => void;
  onAdd: () => void;
  onUpdate: () => void;
  onEdit: (product: Product) => void;
  onDelete: (id: string) => void;
  onRemoveImage: (index: number) => void;
  saving: boolean;
  editingProductId: string | null;
  onImageUpload: (e: React.ChangeEvent<HTMLInputElement>) => void;
  onMultipleImagesUpload: (e: React.ChangeEvent<HTMLInputElement>) => void;
  onVideoUpload: (e: React.ChangeEvent<HTMLInputElement>) => void;
  uploadingImage: boolean;
  uploadingImages: boolean;
  uploadingVideo: boolean;
}) {
  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">Məhsullar / Products</h2>
      
      {/* Add/Edit Product Form */}
      <div className="border rounded-lg p-4 bg-gray-50">
        <h3 className="font-semibold mb-4">
          {editingProductId ? "Məhsulu redaktə et / Edit Product" : "Yeni məhsul əlavə et / Add New Product"}
        </h3>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium mb-1">
              Məhsul adı <span className="text-red-500">*</span>
            </label>
            <input
              type="text"
              placeholder="Məhsul adı"
              value={productForm.name}
              onChange={(e) => setProductForm({ ...productForm, name: e.target.value })}
              className="w-full px-4 py-2 border rounded-lg"
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium mb-1">
              Qiymət (AZN) <span className="text-red-500">*</span>
            </label>
            <input
              type="number"
              placeholder="Qiymət (AZN)"
              value={productForm.price || ""}
              onChange={(e) => setProductForm({ ...productForm, price: parseFloat(e.target.value) || 0 })}
              className="w-full px-4 py-2 border rounded-lg"
              required
            />
          </div>

          <div className="md:col-span-2">
            <label className="block text-sm font-medium mb-1">
              Təsvir <span className="text-red-500">*</span>
            </label>
            <textarea
              placeholder="Təsvir"
              value={productForm.description}
              onChange={(e) => setProductForm({ ...productForm, description: e.target.value })}
              className="w-full px-4 py-2 border rounded-lg"
              rows={4}
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium mb-1">
              Ana Rəsm (Card üçün) <span className="text-red-500">*</span> / Main Image (for Card) <span className="text-red-500">*</span>
            </label>
            <input
              type="file"
              accept="image/jpeg,image/jpg,image/png,image/webp"
              onChange={onImageUpload}
              disabled={uploadingImage}
              className="w-full px-4 py-2 border rounded-lg file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-primary-50 file:text-primary-700 hover:file:bg-primary-100 disabled:opacity-50"
              required
            />
            {uploadingImage && (
              <p className="text-sm text-gray-500 mt-1">Yüklənir... / Uploading...</p>
            )}
            {productForm.image && !uploadingImage && (
              <div className="mt-2">
                <img
                  src={productForm.image}
                  alt="Preview"
                  className="w-32 h-32 object-cover rounded-lg border"
                />
                <p className="text-sm text-green-600 mt-1">Rəsm yükləndi / Image uploaded</p>
              </div>
            )}
          </div>

          <div>
            <label className="block text-sm font-medium mb-1">
              Əlavə Rəsimlər (bir neçə seçə bilərsiniz) / Additional Images (multiple selection)
            </label>
            <input
              type="file"
              accept="image/jpeg,image/jpg,image/png,image/webp"
              onChange={onMultipleImagesUpload}
              disabled={uploadingImages}
              multiple
              className="w-full px-4 py-2 border rounded-lg file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-primary-50 file:text-primary-700 hover:file:bg-primary-100 disabled:opacity-50"
            />
            {uploadingImages && (
              <p className="text-sm text-gray-500 mt-1">Yüklənir... / Uploading...</p>
            )}
            {productForm.images && productForm.images.length > 0 && !uploadingImages && (
              <div className="mt-2 grid grid-cols-4 gap-2">
                {productForm.images.map((img, index) => (
                  <div key={index} className="relative">
                    <img
                      src={img}
                      alt={`Additional ${index + 1}`}
                      className="w-24 h-24 object-cover rounded-lg border"
                    />
                    <button
                      onClick={() => onRemoveImage(index)}
                      className="absolute top-0 right-0 bg-red-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-xs hover:bg-red-600"
                      title="Sil / Remove"
                    >
                      ×
                    </button>
                  </div>
                ))}
              </div>
            )}
          </div>

          <div>
            <label className="block text-sm font-medium mb-1">
              Video (opsional) / Video (optional)
            </label>
            <input
              type="file"
              accept="video/mp4,video/webm,video/ogg"
              onChange={onVideoUpload}
              disabled={uploadingVideo}
              className="w-full px-4 py-2 border rounded-lg file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-primary-50 file:text-primary-700 hover:file:bg-primary-100 disabled:opacity-50"
            />
            {uploadingVideo && (
              <p className="text-sm text-gray-500 mt-1">Yüklənir... / Uploading...</p>
            )}
            {productForm.video && !uploadingVideo && (
              <div className="mt-2">
                <video
                  src={productForm.video}
                  className="w-32 h-32 object-cover rounded-lg border"
                  controls
                />
                <p className="text-sm text-green-600 mt-1">Video yükləndi / Video uploaded</p>
              </div>
            )}
          </div>

          {editingProductId ? (
            <div className="md:col-span-2 flex gap-2">
              <button
                onClick={onUpdate}
                disabled={saving || uploadingImage || uploadingImages || uploadingVideo || !productForm.name || !productForm.description || !productForm.image}
                className="flex-1 flex items-center justify-center gap-2 px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                <Save className="w-5 h-5" />
                {saving ? "Yenilənir... / Updating..." : "Yenilə / Update"}
              </button>
              <button
                onClick={() => {
                  setProductForm({ name: "", description: "", image: "", images: [], video: "", price: 0 });
                  onEdit({} as Product);
                }}
                className="px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600"
              >
                Ləğv et / Cancel
              </button>
            </div>
          ) : (
            <button
              onClick={onAdd}
              disabled={saving || uploadingImage || uploadingImages || uploadingVideo || !productForm.name || !productForm.description || !productForm.image}
              className="flex items-center justify-center gap-2 px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 disabled:cursor-not-allowed md:col-span-2"
            >
              <Plus className="w-5 h-5" />
              {saving ? "Saxlanılır... / Saving..." : "Əlavə et / Add"}
            </button>
          )}
        </div>
      </div>

      {/* Products List */}
      <div className="space-y-4">
        <h3 className="font-semibold">Mövcud məhsullar / Existing Products</h3>
        {products.length === 0 ? (
          <p className="text-gray-500">Məhsul yoxdur / No products</p>
        ) : (
          <div className="space-y-3">
            {products.map((product) => (
              <div key={product.id} className="border rounded-lg p-4 flex justify-between items-start gap-4">
                <div className="flex-1">
                  <div className="flex items-center gap-2 mb-2">
                    {product.image && (
                      <img
                        src={product.image}
                        alt={product.name}
                        className="w-16 h-16 object-cover rounded-lg border"
                      />
                    )}
                    <div>
                      <h4 className="font-semibold">{product.name}</h4>
                      {product.price && <p className="text-primary-600 font-bold">{product.price} AZN</p>}
                    </div>
                  </div>
                  <p className="text-sm text-gray-600 line-clamp-2">{product.description}</p>
                  {product.images && product.images.length > 0 && (
                    <p className="text-xs text-gray-500 mt-1">
                      {product.images.length} əlavə rəsm / {product.images.length} additional images
                    </p>
                  )}
                </div>
                <div className="flex gap-2">
                  <button
                    onClick={() => onEdit(product)}
                    className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors"
                    title="Redaktə et / Edit"
                  >
                    <Edit className="w-5 h-5" />
                  </button>
                  <button
                    onClick={() => onDelete(product.id)}
                    className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                    title="Sil / Delete"
                  >
                    <Trash2 className="w-5 h-5" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}

// /az/ Sosial media tab komponenti
// /en/ Social media tab component
function SocialMediaTab({
  socialMedia,
  setSocialMedia,
  onSave,
  saving,
}: {
  socialMedia: SocialMedia;
  setSocialMedia: (social: SocialMedia) => void;
  onSave: () => void;
  saving: boolean;
}) {
  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">Sosial Media Linkləri</h2>
      <div className="space-y-4">
        <div>
          <label className="block text-sm font-medium mb-2">Instagram URL</label>
          <input
            type="url"
            value={socialMedia.instagram}
            onChange={(e) => setSocialMedia({ ...socialMedia, instagram: e.target.value })}
            className="w-full px-4 py-2 border rounded-lg"
            placeholder="https://instagram.com/..."
          />
        </div>
        <div>
          <label className="block text-sm font-medium mb-2">TikTok URL</label>
          <input
            type="url"
            value={socialMedia.tiktok}
            onChange={(e) => setSocialMedia({ ...socialMedia, tiktok: e.target.value })}
            className="w-full px-4 py-2 border rounded-lg"
            placeholder="https://tiktok.com/@..."
          />
        </div>
        <div>
          <label className="block text-sm font-medium mb-2">Facebook URL</label>
          <input
            type="url"
            value={socialMedia.facebook}
            onChange={(e) => setSocialMedia({ ...socialMedia, facebook: e.target.value })}
            className="w-full px-4 py-2 border rounded-lg"
            placeholder="https://facebook.com/..."
          />
        </div>
        <button
          onClick={onSave}
          disabled={saving}
          className="flex items-center gap-2 px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50"
        >
          <Save className="w-5 h-5" />
          {saving ? "Saxlanılır..." : "Saxla"}
        </button>
      </div>
    </div>
  );
}

// /az/ Haqqında tab komponenti
// /en/ About tab component
function AboutTab({
  about,
  setAbout,
  onSave,
  saving,
}: {
  about: About;
  setAbout: (about: About) => void;
  onSave: () => void;
  saving: boolean;
}) {
  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">Haqqında Məzmunu</h2>
      <div>
        <label className="block text-sm font-medium mb-2">Məzmun</label>
        <textarea
          value={about.content}
          onChange={(e) => setAbout({ content: e.target.value })}
          className="w-full px-4 py-2 border rounded-lg"
          rows={10}
          placeholder="Haqqında məzmununu buraya yazın"
        />
      </div>
      <button
        onClick={onSave}
        disabled={saving}
        className="flex items-center gap-2 px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50"
      >
        <Save className="w-5 h-5" />
        {saving ? "Saxlanılır..." : "Saxla"}
      </button>
    </div>
  );
}

// /az/ Əlaqə tab komponenti
// /en/ Contact tab component
function ContactTab({
  contact,
  setContact,
  siteSettings,
  setSiteSettings,
  onSave,
  saving,
}: {
  contact: Contact;
  setContact: (contact: Contact) => void;
  siteSettings: SiteSettings;
  setSiteSettings: (settings: SiteSettings) => void;
  onSave: () => void;
  saving: boolean;
}) {
  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">Əlaqə Məlumatları / Contact Information</h2>
      <div className="space-y-6">
        {/* Əlaqə Məlumatları / Contact Information */}
        <div className="border rounded-lg p-4 bg-gray-50">
          <h3 className="font-semibold mb-4">Əlaqə Məlumatları / Contact Information</h3>
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium mb-2">Email</label>
              <input
                type="email"
                value={contact.email}
                onChange={(e) => setContact({ ...contact, email: e.target.value })}
                className="w-full px-4 py-2 border rounded-lg"
                placeholder="info@saglamdad.az"
              />
            </div>
            <div>
              <label className="block text-sm font-medium mb-2">Telefon / Phone</label>
              <input
                type="tel"
                value={contact.phone}
                onChange={(e) => setContact({ ...contact, phone: e.target.value })}
                className="w-full px-4 py-2 border rounded-lg"
                placeholder="+994 XX XXX XX XX"
              />
            </div>
          </div>
        </div>

        {/* Footer Təsviri / Footer Description */}
        <div className="border rounded-lg p-4 bg-gray-50">
          <h3 className="font-semibold mb-4">Footer Təsviri / Footer Description</h3>
          <div>
            <label className="block text-sm font-medium mb-2">
              Footer-də görünən mətn / Text shown in footer
            </label>
            <textarea
              value={siteSettings.footerDescription}
              onChange={(e) => setSiteSettings({ ...siteSettings, footerDescription: e.target.value })}
              className="w-full px-4 py-2 border rounded-lg"
              rows={3}
              placeholder="Təbii bal və arı məhsullarının satışı"
            />
            <p className="text-xs text-gray-500 mt-1">
              Bu mətn Footer-də &quot;Saglamdad.az&quot; başlığının altında görünəcək / This text will appear below &quot;Saglamdad.az&quot; in the footer
            </p>
          </div>
        </div>

        <button
          onClick={onSave}
          disabled={saving}
          className="flex items-center gap-2 px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 w-full"
        >
          <Save className="w-5 h-5" />
          {saving ? "Saxlanılır... / Saving..." : "Saxla / Save"}
        </button>
      </div>
    </div>
  );
}

// /az/ Hero section tab komponenti
// /en/ Hero section tab component
function HeroSectionTab({
  heroSection,
  setHeroSection,
  onSave,
  onImageUpload,
  onVideoUpload,
  saving,
}: {
  heroSection: HeroSection;
  setHeroSection: (hero: HeroSection) => void;
  onSave: () => void;
  onImageUpload: (e: React.ChangeEvent<HTMLInputElement>) => void;
  onVideoUpload: (e: React.ChangeEvent<HTMLInputElement>) => void;
  saving: boolean;
}) {
  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">Hero Section / Hero Bölməsi</h2>
      <div className="space-y-6">
        {/* Yazılar / Text Content */}
        <div className="border rounded-lg p-4 bg-gray-50">
          <h3 className="font-semibold mb-4">Yazılar / Text Content</h3>
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium mb-2">
                Başlıq <span className="text-red-500">*</span> / Title <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                value={heroSection.title}
                onChange={(e) =>
                  setHeroSection({ ...heroSection, title: e.target.value })
                }
                className="w-full px-4 py-2 border rounded-lg"
                placeholder="Təbii Bal və Arı Məhsulları"
              />
            </div>
            <div>
              <label className="block text-sm font-medium mb-2">
                Alt Başlıq / Subtitle
              </label>
              <textarea
                value={heroSection.subtitle}
                onChange={(e) =>
                  setHeroSection({ ...heroSection, subtitle: e.target.value })
                }
                className="w-full px-4 py-2 border rounded-lg"
                rows={3}
                placeholder="Premium keyfiyyət, təbii məhsullar. Səhhətiniz üçün ən yaxşısı"
              />
            </div>
          </div>
        </div>

        {/* Yazı Rəngləri / Text Colors */}
        <div className="border rounded-lg p-4 bg-gray-50">
          <h3 className="font-semibold mb-4">Yazı Rəngləri / Text Colors</h3>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium mb-2">
                Başlıq Rəngi / Title Color
              </label>
              <div className="flex gap-2">
                <input
                  type="color"
                  value={heroSection.titleColor}
                  onChange={(e) =>
                    setHeroSection({ ...heroSection, titleColor: e.target.value })
                  }
                  className="w-16 h-10 border rounded cursor-pointer"
                />
                <input
                  type="text"
                  value={heroSection.titleColor}
                  onChange={(e) =>
                    setHeroSection({ ...heroSection, titleColor: e.target.value })
                  }
                  className="flex-1 px-4 py-2 border rounded-lg"
                  placeholder="#111827"
                />
              </div>
              <div className="mt-2 p-3 rounded-lg border" style={{ backgroundColor: heroSection.backgroundColor }}>
                <h4 style={{ color: heroSection.titleColor }} className="text-xl font-bold">
                  {heroSection.title || "Başlıq / Title"}
                </h4>
              </div>
            </div>
            <div>
              <label className="block text-sm font-medium mb-2">
                Alt Başlıq Rəngi / Subtitle Color
              </label>
              <div className="flex gap-2">
                <input
                  type="color"
                  value={heroSection.subtitleColor}
                  onChange={(e) =>
                    setHeroSection({ ...heroSection, subtitleColor: e.target.value })
                  }
                  className="w-16 h-10 border rounded cursor-pointer"
                />
                <input
                  type="text"
                  value={heroSection.subtitleColor}
                  onChange={(e) =>
                    setHeroSection({ ...heroSection, subtitleColor: e.target.value })
                  }
                  className="flex-1 px-4 py-2 border rounded-lg"
                  placeholder="#374151"
                />
              </div>
              <div className="mt-2 p-3 rounded-lg border" style={{ backgroundColor: heroSection.backgroundColor }}>
                <p style={{ color: heroSection.subtitleColor }} className="text-base">
                  {heroSection.subtitle || "Alt başlıq / Subtitle"}
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* Background Settings */}
        <div className="border rounded-lg p-4 bg-gray-50">
          <h3 className="font-semibold mb-4">Background / Fon</h3>
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium mb-2">
                Background Tipi / Background Type
              </label>
          <select
            value={heroSection.backgroundType}
            onChange={(e) =>
              setHeroSection({
                ...heroSection,
                backgroundType: e.target.value as "color" | "image" | "video",
              })
            }
            className="w-full px-4 py-2 border rounded-lg"
          >
            <option value="color">Rəng</option>
            <option value="image">Rəsm</option>
            <option value="video">Video</option>
          </select>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium mb-2">
              Başlanğıc Rəng
            </label>
            <div className="flex gap-2">
              <input
                type="color"
                value={heroSection.backgroundColor}
                onChange={(e) =>
                  setHeroSection({ ...heroSection, backgroundColor: e.target.value })
                }
                className="w-16 h-10 border rounded"
              />
              <input
                type="text"
                value={heroSection.backgroundColor}
                onChange={(e) =>
                  setHeroSection({ ...heroSection, backgroundColor: e.target.value })
                }
                className="flex-1 px-4 py-2 border rounded-lg"
                placeholder="#fefce8"
              />
            </div>
          </div>

          <div>
            <label className="block text-sm font-medium mb-2">
              Son Rəng
            </label>
            <div className="flex gap-2">
              <input
                type="color"
                value={heroSection.backgroundColorEnd}
                onChange={(e) =>
                  setHeroSection({ ...heroSection, backgroundColorEnd: e.target.value })
                }
                className="w-16 h-10 border rounded"
              />
              <input
                type="text"
                value={heroSection.backgroundColorEnd}
                onChange={(e) =>
                  setHeroSection({ ...heroSection, backgroundColorEnd: e.target.value })
                }
                className="flex-1 px-4 py-2 border rounded-lg"
                placeholder="#fef9c3"
              />
            </div>
          </div>
        </div>

        {heroSection.backgroundType === "image" && (
          <div>
            <label className="block text-sm font-medium mb-2">
              Background Rəsm
            </label>
            <input
              type="file"
              accept="image/jpeg,image/jpg,image/png,image/webp"
              onChange={onImageUpload}
              disabled={saving}
              className="w-full px-4 py-2 border rounded-lg file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-primary-50 file:text-primary-700 hover:file:bg-primary-100 disabled:opacity-50"
            />
            {heroSection.backgroundImage && (
              <div className="mt-2">
                <img
                  src={heroSection.backgroundImage}
                  alt="Background preview"
                  className="w-full h-48 object-cover rounded-lg border"
                />
              </div>
            )}
          </div>
        )}

        {heroSection.backgroundType === "video" && (
          <div>
            <label className="block text-sm font-medium mb-2">
              Background Video
            </label>
            <input
              type="file"
              accept="video/mp4,video/webm,video/ogg"
              onChange={onVideoUpload}
              disabled={saving}
              className="w-full px-4 py-2 border rounded-lg file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-primary-50 file:text-primary-700 hover:file:bg-primary-100 disabled:opacity-50"
            />
            {heroSection.backgroundVideo && (
              <div className="mt-2">
                <video
                  src={heroSection.backgroundVideo}
                  className="w-full h-48 object-cover rounded-lg border"
                  controls
                />
              </div>
            )}
          </div>
        )}
          </div>
        </div>

        <button
          onClick={onSave}
          disabled={saving}
          className="flex items-center justify-center gap-2 px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 w-full"
        >
          <Save className="w-5 h-5" />
          {saving ? "Saxlanılır... / Saving..." : "Saxla / Save"}
        </button>
      </div>
    </div>
  );
}

// /az/ Banner tab komponenti
// /en/ Banner tab component
function BannerTab({
  banners,
  bannerForm,
  setBannerForm,
  onAdd,
  onUpdate,
  onEdit,
  onDelete,
  onImageUpload,
  onVideoUpload,
  onCancelEdit,
  saving,
  editingBannerId,
  uploadingBannerImage,
  uploadingBannerVideo,
}: {
  banners: Banner[];
  bannerForm: Partial<Banner>;
  setBannerForm: (form: Partial<Banner>) => void;
  onAdd: () => void;
  onUpdate: () => void;
  onEdit: (banner: Banner) => void;
  onDelete: (id: string) => void;
  onImageUpload: (e: React.ChangeEvent<HTMLInputElement>) => void;
  onVideoUpload: (e: React.ChangeEvent<HTMLInputElement>) => void;
  onCancelEdit: () => void;
  saving: boolean;
  editingBannerId: string | null;
  uploadingBannerImage: boolean;
  uploadingBannerVideo: boolean;
}) {
  const positionLabels: Record<Banner["position"], string> = {
    "hero-top": "Hero Section Yuxarısı / Above Hero Section",
    "hero-bottom": "Hero Section Altı / Below Hero Section",
    "products-top": "Məhsullar Yuxarısı / Above Products",
    "products-bottom": "Məhsullar Altı / Below Products",
    "footer-top": "Footer Yuxarısı / Above Footer",
  };

  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">Reklam Banerləri / Advertisement Banners</h2>

      {/* Add/Edit Banner Form */}
      <div className="border rounded-lg p-4 bg-gray-50">
        <h3 className="font-semibold mb-4">
          {editingBannerId ? "Banner Redaktə Et / Edit Banner" : "Yeni Banner Əlavə Et / Add New Banner"}
        </h3>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium mb-1">
              Banner Başlığı (opsional) / Banner Title (optional)
            </label>
            <input
              type="text"
              placeholder="Banner başlığı / Banner title"
              value={bannerForm.title || ""}
              onChange={(e) => setBannerForm({ ...bannerForm, title: e.target.value })}
              className="w-full px-4 py-2 border rounded-lg"
            />
          </div>

          <div>
            <label className="block text-sm font-medium mb-1">
              Banner Yeri <span className="text-red-500">*</span> / Banner Position <span className="text-red-500">*</span>
            </label>
            <select
              value={bannerForm.position || "hero-bottom"}
              onChange={(e) => setBannerForm({ ...bannerForm, position: e.target.value as Banner["position"] })}
              className="w-full px-4 py-2 border rounded-lg"
            >
              <option value="hero-top">Hero Section Yuxarısı / Above Hero</option>
              <option value="hero-bottom">Hero Section Altı / Below Hero</option>
              <option value="products-top">Məhsullar Yuxarısı / Above Products</option>
              <option value="products-bottom">Məhsullar Altı / Below Products</option>
              <option value="footer-top">Footer Yuxarısı / Above Footer</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium mb-1">
              Banner Tipi <span className="text-red-500">*</span> / Banner Type <span className="text-red-500">*</span>
            </label>
            <select
              value={bannerForm.type || "none"}
              onChange={(e) => {
                const newType = e.target.value as Banner["type"];
                setBannerForm({
                  ...bannerForm,
                  type: newType,
                  imageUrl: newType === "image" ? bannerForm.imageUrl : undefined,
                  videoUrl: newType === "video" ? bannerForm.videoUrl : undefined,
                  googleAdSenseCode: newType === "google-adsense" ? bannerForm.googleAdSenseCode : undefined,
                });
              }}
              className="w-full px-4 py-2 border rounded-lg"
            >
              <option value="none">Banner yox / No Banner</option>
              <option value="image">Rəsm / Image</option>
              <option value="video">Video</option>
              <option value="link">Sadə Link / Simple Link</option>
              <option value="google-adsense">Google AdSense / Google AdSense</option>
            </select>
          </div>

          {bannerForm.type === "link" && (
            <div>
              <label className="block text-sm font-medium mb-1">
                Link URL <span className="text-red-500">*</span> / Link URL <span className="text-red-500">*</span>
              </label>
              <input
                type="url"
                placeholder="https://example.com"
                value={bannerForm.linkUrl || ""}
                onChange={(e) => setBannerForm({ ...bannerForm, linkUrl: e.target.value })}
                className="w-full px-4 py-2 border rounded-lg"
              />
            </div>
          )}

          {bannerForm.type === "google-adsense" && (
            <div className="md:col-span-2">
              <label className="block text-sm font-medium mb-1">
                Google AdSense Kodu <span className="text-red-500">*</span> / Google AdSense Code <span className="text-red-500">*</span>
              </label>
              <textarea
                placeholder="Google AdSense kodunu bura yapışdırın / Paste Google AdSense code here"
                value={bannerForm.googleAdSenseCode || ""}
                onChange={(e) => setBannerForm({ ...bannerForm, googleAdSenseCode: e.target.value })}
                className="w-full px-4 py-2 border rounded-lg font-mono text-sm"
                rows={8}
              />
              <p className="text-xs text-gray-500 mt-1">
                Google AdSense-dən aldığınız reklam kodunu (HTML) bura yapışdırın / Paste the ad code (HTML) from Google AdSense here
              </p>
            </div>
          )}

          {bannerForm.type === "image" && (
            <>
              <div>
                <label className="block text-sm font-medium mb-1">
                  Rəsm <span className="text-red-500">*</span> / Image <span className="text-red-500">*</span>
                </label>
                <input
                  type="file"
                  accept="image/jpeg,image/jpg,image/png,image/webp"
                  onChange={onImageUpload}
                  disabled={uploadingBannerImage}
                  className="w-full px-4 py-2 border rounded-lg file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-primary-50 file:text-primary-700 hover:file:bg-primary-100 disabled:opacity-50"
                />
                {uploadingBannerImage && (
                  <p className="text-sm text-gray-500 mt-1">Yüklənir... / Uploading...</p>
                )}
                {bannerForm.imageUrl && !uploadingBannerImage && (
                  <div className="mt-2">
                    <img
                      src={bannerForm.imageUrl}
                      alt="Banner preview"
                      className="w-full h-32 object-cover rounded-lg border"
                    />
                  </div>
                )}
              </div>
              <div>
                <label className="block text-sm font-medium mb-1">
                  Link URL (rəsmə klik edəndə) / Link URL (when clicking image)
                </label>
                <input
                  type="url"
                  placeholder="https://example.com (opsional / optional)"
                  value={bannerForm.linkUrl || ""}
                  onChange={(e) => setBannerForm({ ...bannerForm, linkUrl: e.target.value })}
                  className="w-full px-4 py-2 border rounded-lg"
                />
              </div>
            </>
          )}

          {bannerForm.type === "video" && (
            <>
              <div>
                <label className="block text-sm font-medium mb-1">
                  Video <span className="text-red-500">*</span> / Video <span className="text-red-500">*</span>
                </label>
                <input
                  type="file"
                  accept="video/mp4,video/webm,video/ogg"
                  onChange={onVideoUpload}
                  disabled={uploadingBannerVideo}
                  className="w-full px-4 py-2 border rounded-lg file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-primary-50 file:text-primary-700 hover:file:bg-primary-100 disabled:opacity-50"
                />
                {uploadingBannerVideo && (
                  <p className="text-sm text-gray-500 mt-1">Yüklənir... / Uploading...</p>
                )}
                {bannerForm.videoUrl && !uploadingBannerVideo && (
                  <div className="mt-2">
                    <video
                      src={bannerForm.videoUrl}
                      className="w-full h-32 object-cover rounded-lg border"
                      controls
                    />
                  </div>
                )}
              </div>
              <div>
                <label className="block text-sm font-medium mb-1">
                  Link URL (video-ya klik edəndə) / Link URL (when clicking video)
                </label>
                <input
                  type="url"
                  placeholder="https://example.com (opsional / optional)"
                  value={bannerForm.linkUrl || ""}
                  onChange={(e) => setBannerForm({ ...bannerForm, linkUrl: e.target.value })}
                  className="w-full px-4 py-2 border rounded-lg"
                />
              </div>
            </>
          )}

          <div className="md:col-span-2">
            <label className="flex items-center gap-2">
              <input
                type="checkbox"
                checked={bannerForm.isActive || false}
                onChange={(e) => setBannerForm({ ...bannerForm, isActive: e.target.checked })}
                className="w-4 h-4"
              />
              <span className="text-sm font-medium">Aktivdir / Is Active</span>
            </label>
          </div>

          {editingBannerId ? (
            <div className="md:col-span-2 flex gap-2">
              <button
              onClick={onUpdate}
              disabled={
                saving ||
                uploadingBannerImage ||
                uploadingBannerVideo ||
                !bannerForm.position ||
                bannerForm.type === "none" ||
                (bannerForm.type === "google-adsense" && !bannerForm.googleAdSenseCode)
              }
                className="flex-1 flex items-center justify-center gap-2 px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                <Save className="w-5 h-5" />
                {saving ? "Yenilənir... / Updating..." : "Yenilə / Update"}
              </button>
              <button
                onClick={onCancelEdit}
                className="px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600"
              >
                Ləğv et / Cancel
              </button>
            </div>
          ) : (
            <button
              onClick={onAdd}
              disabled={
                saving ||
                uploadingBannerImage ||
                uploadingBannerVideo ||
                !bannerForm.position ||
                bannerForm.type === "none" ||
                (bannerForm.type === "google-adsense" && !bannerForm.googleAdSenseCode)
              }
              className="flex items-center justify-center gap-2 px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 disabled:cursor-not-allowed md:col-span-2"
            >
              <Plus className="w-5 h-5" />
              {saving ? "Saxlanılır... / Saving..." : "Əlavə et / Add"}
            </button>
          )}
        </div>
      </div>

      {/* Banners List */}
      <div className="space-y-4">
        <h3 className="font-semibold">Mövcud Banner-lər / Existing Banners</h3>
        {banners.length === 0 ? (
          <p className="text-gray-500">Banner yoxdur / No banners</p>
        ) : (
          <div className="space-y-3">
            {banners.map((banner) => (
              <div key={banner.id} className="border rounded-lg p-4 flex justify-between items-start gap-4">
                <div className="flex-1">
                  <div className="flex items-center gap-2 mb-2">
                    {banner.type === "image" && banner.imageUrl && (
                      <img
                        src={banner.imageUrl}
                        alt={banner.title || "Banner"}
                        className="w-24 h-16 object-cover rounded-lg border"
                      />
                    )}
                    {banner.type === "video" && banner.videoUrl && (
                      <video
                        src={banner.videoUrl}
                        className="w-24 h-16 object-cover rounded-lg border"
                      />
                    )}
                    <div>
                      <h4 className="font-semibold">{banner.title || "Banner"}</h4>
                      <p className="text-sm text-gray-600">{positionLabels[banner.position]}</p>
                      <p className="text-xs text-gray-500">
                        Tip: {banner.type === "image" ? "Rəsm" : banner.type === "video" ? "Video" : banner.type === "google-adsense" ? "Google AdSense" : "Link"} / 
                        Type: {banner.type}
                      </p>
                      {banner.type === "google-adsense" && (
                        <p className="text-xs text-gray-400 mt-1 line-clamp-2">
                          {banner.googleAdSenseCode?.substring(0, 50) || ""}...
                        </p>
                      )}
                      <p className={`text-xs mt-1 ${banner.isActive ? "text-green-600" : "text-gray-400"}`}>
                        {banner.isActive ? "Aktiv / Active" : "Aktiv deyil / Inactive"}
                      </p>
                    </div>
                  </div>
                </div>
                <div className="flex gap-2">
                  <button
                    onClick={() => onEdit(banner)}
                    className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors"
                    title="Redaktə et / Edit"
                  >
                    <Edit className="w-5 h-5" />
                  </button>
                  <button
                    onClick={() => onDelete(banner.id)}
                    className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                    title="Sil / Delete"
                  >
                    <Trash2 className="w-5 h-5" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}

// /az/ Ayarlar tab komponenti
// /en/ Settings tab component
function SettingsTab({
  passwordForm,
  setPasswordForm,
  onChangePassword,
  changingPassword,
}: {
  passwordForm: { currentPassword: string; newPassword: string; confirmPassword: string };
  setPasswordForm: (form: { currentPassword: string; newPassword: string; confirmPassword: string }) => void;
  onChangePassword: () => void;
  changingPassword: boolean;
}) {
  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">Ayarlar / Settings</h2>
      
      {/* Parol Dəyişdirmə / Change Password */}
      <div className="border rounded-lg p-6 bg-gray-50">
        <div className="flex items-center gap-2 mb-4">
          <Lock className="w-5 h-5 text-primary-600" />
          <h3 className="text-xl font-semibold">Parol Dəyişdir / Change Password</h3>
        </div>
        
        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium mb-2">
              Cari Parol <span className="text-red-500">*</span> / Current Password <span className="text-red-500">*</span>
            </label>
            <input
              type="password"
              value={passwordForm.currentPassword}
              onChange={(e) =>
                setPasswordForm({ ...passwordForm, currentPassword: e.target.value })
              }
              className="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-primary-600 focus:border-transparent"
              placeholder="Cari parolunuzu daxil edin / Enter your current password"
            />
          </div>

          <div>
            <label className="block text-sm font-medium mb-2">
              Yeni Parol <span className="text-red-500">*</span> / New Password <span className="text-red-500">*</span>
            </label>
            <input
              type="password"
              value={passwordForm.newPassword}
              onChange={(e) =>
                setPasswordForm({ ...passwordForm, newPassword: e.target.value })
              }
              className="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-primary-600 focus:border-transparent"
              placeholder="Yeni parol (ən azı 6 simvol) / New password (at least 6 characters)"
              minLength={6}
            />
            <p className="text-xs text-gray-500 mt-1">
              Minimum 6 simvol / Minimum 6 characters
            </p>
          </div>

          <div>
            <label className="block text-sm font-medium mb-2">
              Yeni Parol (Təsdiq) <span className="text-red-500">*</span> / Confirm New Password <span className="text-red-500">*</span>
            </label>
            <input
              type="password"
              value={passwordForm.confirmPassword}
              onChange={(e) =>
                setPasswordForm({ ...passwordForm, confirmPassword: e.target.value })
              }
              className="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-primary-600 focus:border-transparent"
              placeholder="Yeni parolu yenidən daxil edin / Re-enter new password"
              minLength={6}
            />
          </div>

          <button
            onClick={onChangePassword}
            disabled={
              changingPassword ||
              !passwordForm.currentPassword ||
              !passwordForm.newPassword ||
              !passwordForm.confirmPassword ||
              passwordForm.newPassword !== passwordForm.confirmPassword
            }
            className="flex items-center justify-center gap-2 px-6 py-3 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors w-full"
          >
            <Lock className="w-5 h-5" />
            {changingPassword ? "Dəyişdirilir... / Changing..." : "Parolu Dəyişdir / Change Password"}
          </button>
        </div>
      </div>
    </div>
  );
}

