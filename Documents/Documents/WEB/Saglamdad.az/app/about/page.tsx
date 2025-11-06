"use client";

// About Page Component
// /az/ Haqqında səhifəsi komponenti - admin tərəfindən idarə olunan məzmun
// /en/ About page component - admin-managed content

import { useEffect, useState } from "react";
import { motion } from "framer-motion";

export default function AboutPage() {
  const [content, setContent] = useState("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchAbout();
  }, []);

  const fetchAbout = async () => {
    try {
      const res = await fetch("/api/about");
      const data = await res.json();
      setContent(data.content || "");
    } catch (error) {
      console.error("Error fetching about:", error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen py-16 md:py-24 bg-gradient-to-br from-primary-50 to-white">
      <div className="container mx-auto px-4 max-w-4xl">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
        >
          <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-8 text-center">
            Haqqımızda
          </h1>

          {loading ? (
            <div className="flex justify-center items-center py-20">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
            </div>
          ) : content ? (
            <div
              className="prose prose-lg max-w-none bg-white p-8 rounded-lg shadow-lg"
              dangerouslySetInnerHTML={{ __html: content.replace(/\n/g, "<br />") }}
            />
          ) : (
            <div className="text-center py-20 bg-white rounded-lg shadow-lg">
              <p className="text-gray-500 text-lg">
                Məlumat əlavə olunmayıb
              </p>
            </div>
          )}
        </motion.div>
      </div>
    </div>
  );
}

