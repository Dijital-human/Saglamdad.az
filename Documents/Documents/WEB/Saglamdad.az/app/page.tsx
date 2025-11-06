"use client";

// Home Page Component
// /az/ Ana səhifə komponenti - məhsullar və sosial media linkləri
// /en/ Home page component - products and social media links

import { useEffect, useState } from "react";
import { motion } from "framer-motion";
import ProductCard from "@/components/ProductCard";
import SocialMediaLinks from "@/components/SocialMediaLinks";
import { Product, SocialMedia, HeroSection, Banner } from "@/lib/db";
import BannerComponent from "@/components/Banner";

export default function Home() {
  const [products, setProducts] = useState<Product[]>([]);
  const [socialMedia, setSocialMedia] = useState<SocialMedia>({
    instagram: "",
    tiktok: "",
    facebook: "",
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
  const [banners, setBanners] = useState<Banner[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchData();
    // /az/ Hər 5 saniyədə bir məhsulları və banner-ləri yeniləyir (real-time update)
    // /en/ Refreshes products and banners every 5 seconds (real-time update)
    const interval = setInterval(() => {
      fetchProducts();
      fetchBanners();
    }, 5000);

    return () => clearInterval(interval);
  }, []);

  const fetchProducts = async () => {
    try {
      const productsRes = await fetch("/api/products");
      const productsData = await productsRes.json();
      setProducts(productsData);
    } catch (error) {
      console.error("Error fetching products:", error);
    }
  };

  // /az/ Banner-ləri fetch et
  // /en/ Fetch banners
  const fetchBanners = async () => {
    try {
      const bannersRes = await fetch("/api/banners");
      const bannersData = await bannersRes.json();
      setBanners(bannersData);
    } catch (error) {
      console.error("Error fetching banners:", error);
    }
  };

  const fetchData = async () => {
    try {
      const [productsRes, socialRes, heroRes, bannersRes] = await Promise.all([
        fetch("/api/products"),
        fetch("/api/social-media"),
        fetch("/api/hero-section"),
        fetch("/api/banners"),
      ]);

      const productsData = await productsRes.json();
      const socialData = await socialRes.json();
      const heroData = await heroRes.json();
      const bannersData = await bannersRes.json();

      setProducts(productsData);
      setSocialMedia(socialData);
      setHeroSection(heroData);
      setBanners(bannersData);
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };

  // /az/ Banner-i mövqeyə görə tap (yalnız aktiv banner-lər)
  // /en/ Find banner by position (only active banners)
  const getBannerByPosition = (position: Banner["position"]): Banner | null => {
    const banner = banners.find((b) => b.position === position && b.isActive);
    // /az/ Debug üçün console.log (production-da silinə bilər)
    // /en/ Console.log for debugging (can be removed in production)
    if (process.env.NODE_ENV === "development") {
      console.log(`Banner search for position "${position}":`, {
        totalBanners: banners.length,
        activeBanners: banners.filter((b) => b.isActive).length,
        foundBanner: banner ? "Found" : "Not found",
      });
    }
    return banner || null;
  };

  return (
    <div className="min-h-screen">
      {/* Hero Top Banner */}
      {getBannerByPosition("hero-top") && (
        <div className="container mx-auto px-4 py-4">
          <BannerComponent banner={getBannerByPosition("hero-top")!} />
        </div>
      )}

      {/* Hero Section */}
      <section
        className="relative py-20 md:py-32 overflow-hidden"
        style={{
          background:
            heroSection.backgroundType === "video"
              ? `linear-gradient(to bottom right, ${heroSection.backgroundColor}, ${heroSection.backgroundColorEnd})`
              : heroSection.backgroundType === "image" && heroSection.backgroundImage
              ? `linear-gradient(to bottom right, ${heroSection.backgroundColor}, ${heroSection.backgroundColorEnd}), url(${heroSection.backgroundImage})`
              : `linear-gradient(to bottom right, ${heroSection.backgroundColor}, ${heroSection.backgroundColorEnd})`,
          backgroundSize: heroSection.backgroundType === "image" ? "cover" : "auto",
          backgroundPosition: "center",
          backgroundRepeat: "no-repeat",
        }}
      >
        {/* Background Video */}
        {heroSection.backgroundType === "video" && heroSection.backgroundVideo && (
          <div className="absolute inset-0 z-0">
            <video
              autoPlay
              loop
              muted
              playsInline
              className="w-full h-full object-cover opacity-50"
            >
              <source src={heroSection.backgroundVideo} type="video/mp4" />
            </video>
            <div className="absolute inset-0 bg-black bg-opacity-20"></div>
          </div>
        )}

        {/* Background Image Overlay */}
        {heroSection.backgroundType === "image" && heroSection.backgroundImage && (
          <div className="absolute inset-0 z-0">
            <div
              className="w-full h-full opacity-30"
              style={{
                backgroundImage: `url(${heroSection.backgroundImage})`,
                backgroundSize: "cover",
                backgroundPosition: "center",
              }}
            ></div>
          </div>
        )}

        <div className="container mx-auto px-4 relative z-10">
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8 }}
            className="text-center max-w-3xl mx-auto"
          >
            <h1 
              className="text-4xl md:text-6xl font-bold mb-6"
              style={{ color: heroSection.titleColor }}
            >
              {heroSection.title || "Təbii Bal və Arı Məhsulları"}
            </h1>
            <p 
              className="text-xl md:text-2xl mb-8"
              style={{ color: heroSection.subtitleColor }}
            >
              {heroSection.subtitle || "Premium keyfiyyət, təbii məhsullar. Səhhətiniz üçün ən yaxşısı"}
            </p>
            <SocialMediaLinks socialMedia={socialMedia} />
          </motion.div>
        </div>
      </section>

      {/* Hero Bottom Banner */}
      {getBannerByPosition("hero-bottom") && (
        <div className="container mx-auto px-4 py-4">
          <BannerComponent banner={getBannerByPosition("hero-bottom")!} />
        </div>
      )}

      {/* Products Section */}
      <section className="py-16 md:py-24 bg-white">
        {/* Products Top Banner */}
        {getBannerByPosition("products-top") && (
          <div className="container mx-auto px-4 mb-12">
            <BannerComponent banner={getBannerByPosition("products-top")!} />
          </div>
        )}
        <div className="container mx-auto px-4">
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ duration: 0.6 }}
            className="text-center mb-12"
          >
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              Məhsullarımız
            </h2>
            <p className="text-gray-600 max-w-2xl mx-auto">
              Təbii və keyfiyyətli bal məhsulları ilə səhhətinizi qoruyun
            </p>
          </motion.div>

          {loading ? (
            <div className="flex justify-center items-center py-20">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
            </div>
          ) : products.length === 0 ? (
            <div className="text-center py-20">
              <p className="text-gray-500 text-lg">Hələ məhsul əlavə olunmayıb</p>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              {products.map((product, index) => (
                <motion.div
                  key={product.id}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.5, delay: index * 0.1 }}
                >
                  <ProductCard product={product} />
                </motion.div>
              ))}
            </div>
          )}

          {/* Products Bottom Banner */}
          {getBannerByPosition("products-bottom") && (
            <div className="container mx-auto px-4 mt-12">
              <BannerComponent banner={getBannerByPosition("products-bottom")!} />
            </div>
          )}
        </div>
      </section>

      {/* Footer Top Banner */}
      {getBannerByPosition("footer-top") && (
        <div className="container mx-auto px-4 py-4">
          <BannerComponent banner={getBannerByPosition("footer-top")!} />
        </div>
      )}
    </div>
  );
}

