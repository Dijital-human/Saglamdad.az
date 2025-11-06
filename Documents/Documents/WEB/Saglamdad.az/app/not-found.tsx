"use client";

// Not Found Page Component
// /az/ 404 səhifəsi komponenti
// /en/ 404 page component

import Link from "next/link";
import { motion } from "framer-motion";
import { Home, ArrowLeft } from "lucide-react";

export default function NotFound() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-primary-50 to-white py-12 px-4">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="text-center max-w-md"
      >
        <motion.h1
          initial={{ scale: 0.8 }}
          animate={{ scale: 1 }}
          transition={{ delay: 0.2, type: "spring" }}
          className="text-9xl font-bold text-primary-600 mb-4"
        >
          404
        </motion.h1>
        <h2 className="text-3xl font-bold text-gray-900 mb-4">
          Səhifə Tapılmadı / Page Not Found
        </h2>
        <p className="text-gray-600 mb-8">
          Axtardığınız səhifə mövcud deyil və ya köçürülüb.
          <br />
          The page you are looking for does not exist or has been moved.
        </p>
        <div className="flex gap-4 justify-center">
          <Link
            href="/"
            className="flex items-center gap-2 px-6 py-3 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors font-semibold"
          >
            <Home className="w-5 h-5" />
            Ana Səhifə / Home
          </Link>
          <button
            onClick={() => window.history.back()}
            className="flex items-center gap-2 px-6 py-3 bg-gray-200 text-gray-900 rounded-lg hover:bg-gray-300 transition-colors font-semibold"
          >
            <ArrowLeft className="w-5 h-5" />
            Geri / Back
          </button>
        </div>
      </motion.div>
    </div>
  );
}

