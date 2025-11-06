"use client";

// Social Media Links Component
// /az/ Sosial media linkləri komponenti - sosial media ikonları
// /en/ Social media links component - social media icons

import { motion } from "framer-motion";
import { Instagram, Facebook } from "lucide-react";
import { SocialMedia } from "@/lib/db";

interface SocialMediaLinksProps {
  socialMedia: SocialMedia;
}

export default function SocialMediaLinks({ socialMedia }: SocialMediaLinksProps) {
  const links = [
    {
      name: "Instagram",
      icon: Instagram,
      url: socialMedia.instagram,
      color: "bg-gradient-to-r from-purple-500 to-pink-500",
    },
    {
      name: "TikTok",
      icon: () => (
        <svg
          className="w-6 h-6"
          fill="currentColor"
          viewBox="0 0 24 24"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path d="M19.59 6.69a4.83 4.83 0 0 1-3.77-4.25V2h-3.45v13.67a2.89 2.89 0 0 1-5.2 1.74 2.89 2.89 0 0 1 2.31-4.64 2.93 2.93 0 0 1 .88.13V9.4a6.84 6.84 0 0 0-1-.05A6.33 6.33 0 0 0 5 20.1a6.34 6.34 0 0 0 10.86-4.43v-7a8.16 8.16 0 0 0 4.77 1.52v-3.4a4.85 4.85 0 0 1-1-.1z" />
        </svg>
      ),
      url: socialMedia.tiktok,
      color: "bg-black",
    },
    {
      name: "Facebook",
      icon: Facebook,
      url: socialMedia.facebook,
      color: "bg-blue-600",
    },
  ].filter((link) => link.url);

  if (links.length === 0) return null;

  return (
    <div className="flex justify-center gap-4 mt-6">
      {links.map((link, index) => (
        <motion.a
          key={link.name}
          href={link.url}
          target="_blank"
          rel="noopener noreferrer"
          initial={{ opacity: 0, scale: 0 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.5, delay: index * 0.1 }}
          whileHover={{ scale: 1.1 }}
          whileTap={{ scale: 0.9 }}
          className={`${link.color} text-white p-3 rounded-full shadow-lg hover:shadow-xl transition-shadow`}
        >
          <link.icon className="w-6 h-6" />
        </motion.a>
      ))}
    </div>
  );
}

