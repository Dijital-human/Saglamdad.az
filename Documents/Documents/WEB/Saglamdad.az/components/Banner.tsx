"use client";

// Banner Component
// /az/ Reklam banner komponenti
// /en/ Advertisement banner component

import Link from "next/link";
import { motion } from "framer-motion";
import { useEffect, useRef } from "react";
import { Banner as BannerType } from "@/lib/db";

interface BannerProps {
  banner: BannerType;
}

export default function Banner({ banner }: BannerProps) {
  const googleAdSenseRef = useRef<HTMLDivElement>(null);

  // /az/ Google AdSense reklamını aktivləşdir
  // /en/ Activate Google AdSense ad
  useEffect(() => {
    if (banner.type === "google-adsense" && banner.googleAdSenseCode && googleAdSenseRef.current) {
      try {
        // /az/ Google AdSense script-ini yoxla və reklamı aktivləşdir
        // /en/ Check Google AdSense script and activate ad
        if (typeof window !== "undefined") {
          // /az/ Script layout-də artıq yüklənib, reklamı aktivləşdir
          // /en/ Script already loaded in layout, activate ad
          ((window as any).adsbygoogle = (window as any).adsbygoogle || []).push({});
        }
      } catch (error) {
        console.error("Google AdSense error:", error);
      }
    }
  }, [banner.type, banner.googleAdSenseCode]);

  // /az/ Banner content-ini render et
  // /en/ Render banner content
  const renderBannerContent = () => {
    if (banner.type === "image" && banner.imageUrl) {
      const content = (
        <img
          src={banner.imageUrl}
          alt={banner.title || "Banner"}
          className="w-full h-auto max-h-64 md:max-h-96 object-contain rounded-lg"
        />
      );

      if (banner.linkUrl) {
        return (
          <Link href={banner.linkUrl} target="_blank" rel="noopener noreferrer" className="block">
            {content}
          </Link>
        );
      }
      return content;
    }

    if (banner.type === "video" && banner.videoUrl) {
      const content = (
        <video
          src={banner.videoUrl}
          className="w-full h-auto max-h-64 md:max-h-96 rounded-lg"
          controls
          autoPlay
          loop
          muted
        />
      );

      if (banner.linkUrl) {
        return (
          <Link href={banner.linkUrl} target="_blank" rel="noopener noreferrer" className="block">
            {content}
          </Link>
        );
      }
      return content;
    }

    if (banner.type === "link" && banner.linkUrl) {
      return (
        <Link
          href={banner.linkUrl}
          target="_blank"
          rel="noopener noreferrer"
          className="block w-full px-4 md:px-6 py-3 md:py-4 bg-primary-600 text-white text-center rounded-lg hover:bg-primary-700 transition-colors font-semibold text-sm md:text-base"
        >
          {banner.title || banner.linkUrl}
        </Link>
      );
    }

    if (banner.type === "google-adsense" && banner.googleAdSenseCode) {
      return (
        <div
          ref={googleAdSenseRef}
          className="w-full flex justify-center items-center min-h-[100px] md:min-h-[250px] overflow-hidden"
          style={{
            maxWidth: "100%",
            // /az/ Google AdSense dizayna təsir etməsin
            // /en/ Google AdSense should not affect design
            isolation: "isolate",
          }}
        >
          <div
            className="w-full max-w-full"
            dangerouslySetInnerHTML={{ __html: banner.googleAdSenseCode }}
          />
        </div>
      );
    }

    return null;
  };

  // /az/ Banner yalnız aktivdirsə görünür (getBannerByPosition-da artıq yoxlanılır, amma təhlükəsizlik üçün)
  // /en/ Banner only visible if active (already checked in getBannerByPosition, but for safety)
  if (!banner.isActive) {
    return null;
  }

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.5 }}
      className="w-full my-4 md:my-8 overflow-hidden"
      style={{
        maxWidth: "100%",
        // /az/ Banner-lər saytın dizaynına təsir etməsin
        // /en/ Banners should not affect site design
        isolation: "isolate",
      }}
    >
      <div className="w-full max-w-full overflow-x-auto">
        {renderBannerContent()}
      </div>
    </motion.div>
  );
}

