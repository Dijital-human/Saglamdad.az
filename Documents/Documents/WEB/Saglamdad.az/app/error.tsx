"use client";

// Error Boundary Component
// /az/ Xəta səhifəsi komponenti
// /en/ Error page component

import { useEffect } from "react";
import { motion } from "framer-motion";
import { AlertTriangle, RefreshCw, Home } from "lucide-react";
import Link from "next/link";

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    // Log error to console
    console.error("Error:", error);
  }, [error]);

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-primary-50 to-white py-12 px-4">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="text-center max-w-md"
      >
        <motion.div
          initial={{ scale: 0.8 }}
          animate={{ scale: 1 }}
          transition={{ delay: 0.2, type: "spring" }}
          className="mb-6 flex justify-center"
        >
          <AlertTriangle className="w-24 h-24 text-red-500" />
        </motion.div>
        
        <h1 className="text-3xl font-bold text-gray-900 mb-4">
          Xəta Baş Verdi / An Error Occurred
        </h1>
        
        <p className="text-gray-600 mb-2">
          {error.message || "Gözlənilməz xəta baş verdi."}
        </p>
        
        {error.digest && (
          <p className="text-sm text-gray-500 mb-6">
            Error ID: {error.digest}
          </p>
        )}

        <div className="flex gap-4 justify-center">
          <button
            onClick={reset}
            className="flex items-center gap-2 px-6 py-3 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors font-semibold"
          >
            <RefreshCw className="w-5 h-5" />
            Yenidən Cəhd Et / Try Again
          </button>
          
          <Link
            href="/"
            className="flex items-center gap-2 px-6 py-3 bg-gray-200 text-gray-900 rounded-lg hover:bg-gray-300 transition-colors font-semibold"
          >
            <Home className="w-5 h-5" />
            Ana Səhifə / Home
          </Link>
        </div>
      </motion.div>
    </div>
  );
}


