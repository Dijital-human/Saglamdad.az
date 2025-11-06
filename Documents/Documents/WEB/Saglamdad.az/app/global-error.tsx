"use client";

// Global Error Boundary Component
// /az/ Global xəta səhifəsi komponenti
// /en/ Global error page component

import { useEffect } from "react";
import { AlertTriangle, RefreshCw } from "lucide-react";

export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    // Log error to console
    console.error("Global Error:", error);
  }, [error]);

  return (
    <html lang="az">
      <body>
        <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-red-50 to-white py-12 px-4">
          <div className="text-center max-w-md">
            <div className="mb-6 flex justify-center">
              <AlertTriangle className="w-24 h-24 text-red-500" />
            </div>
            
            <h1 className="text-3xl font-bold text-gray-900 mb-4">
              Kritik Xəta / Critical Error
            </h1>
            
            <p className="text-gray-600 mb-2">
              {error.message || "Gözlənilməz kritik xəta baş verdi."}
            </p>
            
            {error.digest && (
              <p className="text-sm text-gray-500 mb-6">
                Error ID: {error.digest}
              </p>
            )}

            <button
              onClick={reset}
              className="flex items-center gap-2 px-6 py-3 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors font-semibold mx-auto"
            >
              <RefreshCw className="w-5 h-5" />
              Yenidən Yüklə / Reload
            </button>
          </div>
        </div>
      </body>
    </html>
  );
}

