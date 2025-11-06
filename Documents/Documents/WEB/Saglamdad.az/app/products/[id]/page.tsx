"use client";

// Product Detail Page Component
// /az/ Məhsul detall səhifəsi komponenti
// /en/ Product detail page component

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { motion } from "framer-motion";
import { ArrowLeft, Play, X } from "lucide-react";
import { Product, Contact } from "@/lib/db";

export default function ProductDetailPage() {
  const params = useParams();
  const router = useRouter();
  const [product, setProduct] = useState<Product | null>(null);
  const [contact, setContact] = useState<Contact>({ email: "", phone: "" });
  const [loading, setLoading] = useState(true);
  const [showVideo, setShowVideo] = useState(false);
  const [selectedImageIndex, setSelectedImageIndex] = useState(0);

  useEffect(() => {
    fetchProduct();
    fetchContact();
  }, [params.id]);

  const fetchContact = async () => {
    try {
      const res = await fetch("/api/contact");
      const contactData = await res.json();
      setContact(contactData);
    } catch (error) {
      console.error("Əlaqə məlumatları gətirilə bilmədi:", error);
    }
  };

  const fetchProduct = async () => {
    try {
      const res = await fetch(`/api/products`);
      const products = await res.json();
      const foundProduct = products.find((p: Product) => p.id === params.id);
      setProduct(foundProduct || null);
    } catch (error) {
      console.error("Məhsul məlumatları gətirilə bilmədi:", error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
      </div>
    );
  }

  if (!product) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Məhsul tapılmadı</h1>
          <button
            onClick={() => router.push("/")}
            className="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors"
          >
            Ana səhifəyə qayıt
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary-50 to-white py-8 md:py-16">
      <div className="container mx-auto px-4 max-w-6xl">
        <motion.button
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          onClick={() => router.push("/")}
          className="flex items-center gap-2 text-gray-700 hover:text-primary-600 mb-8 transition-colors"
        >
          <ArrowLeft className="w-5 h-5" />
          Geri qayıt
        </motion.button>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 md:gap-12">
          {/* Məhsul Rəsmi/Video və Əlavə Rəsimlər */}
          <motion.div
            initial={{ opacity: 0, x: -20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.6 }}
            className="relative"
          >
            {/* Ana rəsm/video */}
            <div className="relative aspect-square bg-gray-100 rounded-xl overflow-hidden shadow-2xl mb-6">
              {showVideo ? (
                <div className="relative h-full">
                  <video
                    src={product.video}
                    controls
                    className="w-full h-full object-cover"
                    autoPlay
                    onEnded={() => setShowVideo(false)}
                  />
                  <button
                    onClick={() => {
                      setShowVideo(false);
                      // Video bağlandıqda rəsm seçimini sıfırla
                      setSelectedImageIndex(0);
                    }}
                    className="absolute top-4 right-4 bg-black bg-opacity-50 hover:bg-opacity-70 text-white rounded-full p-2 transition-all z-10"
                    title="Bağla / Close"
                  >
                    <X className="w-5 h-5" />
                  </button>
                </div>
              ) : (
                <img
                  src={
                    selectedImageIndex === -1
                      ? product.image || "/placeholder.jpg"
                      : product.images && product.images.length > 0 && selectedImageIndex > 0
                      ? product.images[selectedImageIndex - 1]
                      : product.image || "/placeholder.jpg"
                  }
                  alt={product.name}
                  className="w-full h-full object-cover"
                  onError={(e) => {
                    const target = e.target as HTMLImageElement;
                    target.src = "";
                    target.parentElement!.innerHTML = `
                      <div class="w-full h-full flex items-center justify-center bg-gray-100">
                        <svg class="w-24 h-24 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                        </svg>
                      </div>
                    `;
                  }}
                />
              )}
            </div>

            {/* Rəsim və video galereyası (modern stil) / Images and video gallery (modern style) */}
            <div className="mt-6">
              <h3 className="text-sm font-semibold text-gray-700 mb-3">
                Rəsimlər və Video / Images and Video
              </h3>
              <div className="grid grid-cols-4 md:grid-cols-5 gap-3">
                {/* Ana rəsm thumbnail */}
                <button
                  onClick={() => {
                    setSelectedImageIndex(0);
                    setShowVideo(false);
                  }}
                  className={`group relative aspect-square rounded-xl overflow-hidden border-2 transition-all duration-300 ${
                    selectedImageIndex === 0 && !showVideo
                      ? "border-primary-600 ring-2 ring-primary-200 shadow-lg scale-105"
                      : "border-gray-200 hover:border-primary-400 hover:shadow-md"
                  }`}
                >
                  <img
                    src={product.image || "/placeholder.jpg"}
                    alt={product.name}
                    className="w-full h-full object-cover transition-transform duration-300 group-hover:scale-110"
                  />
                  {selectedImageIndex === 0 && !showVideo && (
                    <div className="absolute inset-0 bg-primary-600 bg-opacity-10"></div>
                  )}
                </button>

                {/* Əlavə rəsimlər */}
                {product.images && product.images.map((img, index) => (
                  <button
                    key={index}
                    onClick={() => {
                      setSelectedImageIndex(index + 1);
                      setShowVideo(false);
                    }}
                    className={`group relative aspect-square rounded-xl overflow-hidden border-2 transition-all duration-300 ${
                      selectedImageIndex === index + 1 && !showVideo
                        ? "border-primary-600 ring-2 ring-primary-200 shadow-lg scale-105"
                        : "border-gray-200 hover:border-primary-400 hover:shadow-md"
                    }`}
                  >
                    <img
                      src={img}
                      alt={`${product.name} - ${index + 1}`}
                      className="w-full h-full object-cover transition-transform duration-300 group-hover:scale-110"
                    />
                    {selectedImageIndex === index + 1 && !showVideo && (
                      <div className="absolute inset-0 bg-primary-600 bg-opacity-10"></div>
                    )}
                  </button>
                ))}

                {/* Video thumbnail */}
                {product.video && (
                  <button
                    onClick={() => {
                      setShowVideo(true);
                      setSelectedImageIndex(-1);
                    }}
                    className={`group relative aspect-square rounded-xl overflow-hidden border-2 transition-all duration-300 ${
                      showVideo
                        ? "border-primary-600 ring-2 ring-primary-200 shadow-lg scale-105"
                        : "border-gray-200 hover:border-primary-400 hover:shadow-md"
                    }`}
                  >
                    <div className="relative w-full h-full bg-gradient-to-br from-gray-900 to-gray-700">
                      <img
                        src={product.image || "/placeholder.jpg"}
                        alt={`${product.name} - Video`}
                        className="w-full h-full object-cover opacity-60"
                      />
                      <div className="absolute inset-0 flex items-center justify-center">
                        <div className="bg-white bg-opacity-90 rounded-full p-3 group-hover:scale-110 transition-transform shadow-lg">
                          <Play className="w-6 h-6 text-primary-600" fill="currentColor" />
                        </div>
                      </div>
                      {showVideo && (
                        <div className="absolute inset-0 bg-primary-600 bg-opacity-10"></div>
                      )}
                    </div>
                  </button>
                )}
              </div>
            </div>
          </motion.div>

          {/* Məhsul Məlumatları */}
          <motion.div
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            className="flex flex-col justify-center"
          >
            <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-6">
              {product.name}
            </h1>
            
            {product.price && (
              <div className="mb-6">
                <p className="text-3xl md:text-4xl font-bold text-primary-600">
                  {product.price} AZN
                </p>
              </div>
            )}

            <div className="mb-8">
              <h2 className="text-xl font-semibold text-gray-900 mb-4">Məhsul Haqqında</h2>
              <p className="text-gray-700 leading-relaxed whitespace-pre-line">
                {product.description}
              </p>
            </div>

            <div className="flex gap-4">
              {contact.phone && (
                <button
                  onClick={() => {
                    window.location.href = `tel:${contact.phone}`;
                  }}
                  className="flex-1 px-6 py-3 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors font-semibold text-lg"
                >
                  Zəng Et
                </button>
              )}
              {contact.email && (
                <button
                  onClick={() => {
                    window.location.href = `mailto:${contact.email}`;
                  }}
                  className="flex-1 px-6 py-3 bg-gray-200 text-gray-900 rounded-lg hover:bg-gray-300 transition-colors font-semibold text-lg"
                >
                  Məlumat Al
                </button>
              )}
            </div>
          </motion.div>
        </div>
      </div>
    </div>
  );
}

