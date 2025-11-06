"use client";

// Product Card Component
// /az/ Məhsul kartı komponenti - məhsul məlumatlarını göstərir
// /en/ Product card component - displays product information

import { useState } from "react";
import Link from "next/link";
import { motion } from "framer-motion";
import { Play, ArrowRight } from "lucide-react";
import { Product } from "@/lib/db";

interface ProductCardProps {
  product: Product;
}

export default function ProductCard({ product }: ProductCardProps) {
  const [showVideo, setShowVideo] = useState(false);

  return (
    <Link href={`/products/${product.id}`}>
      <motion.div
        className="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition-all duration-300 cursor-pointer group"
        whileHover={{ y: -8, scale: 1.02 }}
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
      >
      <div className="relative aspect-video bg-gray-200">
        {product.video && !showVideo ? (
          <div className="relative h-full">
            <img
              src={product.image || "/placeholder.jpg"}
              alt={product.name}
              className="w-full h-full object-cover"
              onError={(e) => {
                (e.target as HTMLImageElement).style.display = "none";
              }}
            />
            <button
              onClick={() => setShowVideo(true)}
              className="absolute inset-0 flex items-center justify-center bg-black bg-opacity-30 hover:bg-opacity-50 transition-all"
            >
              <div className="bg-white rounded-full p-4 hover:scale-110 transition-transform">
                <Play className="w-8 h-8 text-primary-600" fill="currentColor" />
              </div>
            </button>
          </div>
        ) : product.video && showVideo ? (
          <video
            src={product.video}
            controls
            className="w-full h-full object-cover"
            autoPlay
          />
        ) : (
          <img
            src={product.image || "/placeholder.jpg"}
            alt={product.name}
            className="w-full h-full object-cover"
            onError={(e) => {
              const target = e.target as HTMLImageElement;
              target.src = "";
              target.parentElement!.innerHTML = `
                <div class="w-full h-full flex items-center justify-center bg-gray-100">
                  <svg class="w-16 h-16 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                  </svg>
                </div>
              `;
            }}
          />
        )}
      </div>
        <div className="p-6">
          <h3 className="text-xl font-bold text-gray-900 mb-2 group-hover:text-primary-600 transition-colors">
            {product.name}
          </h3>
          <p className="text-gray-600 line-clamp-3 mb-4">{product.description}</p>
          <div className="flex items-center justify-between mt-4">
            {product.price && (
              <p className="text-primary-600 font-bold text-2xl">
                {product.price} AZN
              </p>
            )}
            <div className="flex items-center text-primary-600 font-semibold group-hover:translate-x-2 transition-transform">
              <span className="text-sm">Ətraflı</span>
              <ArrowRight className="w-5 h-5 ml-1" />
            </div>
          </div>
        </div>
      </motion.div>
    </Link>
  );
}

