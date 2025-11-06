"use client";

// Footer Component
// /az/ Footer komponenti - saytın alt hissəsi
// /en/ Footer component - site footer

import { useState, useEffect } from "react";
import Link from "next/link";

export default function Footer() {
  const [isAdmin, setIsAdmin] = useState(false);
  const [footerDescription, setFooterDescription] = useState("Təbii bal və arı məhsullarının satışı");

  // /az/ Site settings-i fetch et
  // /en/ Fetch site settings
  useEffect(() => {
    const fetchSiteSettings = async () => {
      try {
        const res = await fetch("/api/site-settings");
        if (res.ok) {
          const data = await res.json();
          setFooterDescription(data.footerDescription || "Təbii bal və arı məhsullarının satışı");
        }
      } catch (error) {
        console.error("Error fetching site settings:", error);
      }
    };
    fetchSiteSettings();
    // /az/ Hər 10 saniyədə bir yenilə (real-time update)
    // /en/ Refresh every 10 seconds (real-time update)
    const interval = setInterval(fetchSiteSettings, 10000);
    return () => clearInterval(interval);
  }, []);

  useEffect(() => {
    // /az/ Admin token-ı yoxla və verify et
    // /en/ Check and verify admin token
    const checkAdminAuth = async () => {
      // /az/ SSR üçün client-side yoxlama
      // /en/ Client-side check for SSR
      if (typeof window === "undefined") {
        return;
      }

      const token = localStorage.getItem("adminToken");
      if (!token) {
        setIsAdmin(false);
        return;
      }

      try {
        const res = await fetch("/api/auth/verify", {
          method: "GET",
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        if (res.ok) {
          setIsAdmin(true);
        } else {
          setIsAdmin(false);
          // /az/ Etibarsız token varsa sil
          // /en/ Remove invalid token
          localStorage.removeItem("adminToken");
        }
      } catch (error) {
        setIsAdmin(false);
        localStorage.removeItem("adminToken");
      }
    };

    // /az/ İlk yoxlama
    // /en/ Initial check
    checkAdminAuth();

    // /az/ localStorage dəyişikliklərini dinlə (digər tab/pencerədə login/logout olanda)
    // /en/ Listen to localStorage changes (when login/logout in other tab/window)
    const handleStorageChange = (e: StorageEvent | CustomEvent) => {
      if (e instanceof StorageEvent && e.key === "adminToken") {
        checkAdminAuth();
      } else if (e instanceof CustomEvent && e.detail?.type === "adminToken") {
        checkAdminAuth();
      }
    };

    // /az/ Storage event (digər tab/pencerələr üçün)
    // /en/ Storage event (for other tabs/windows)
    window.addEventListener("storage", handleStorageChange as EventListener);
    
    // /az/ Custom event (eyni tab üçün)
    // /en/ Custom event (for same tab)
    window.addEventListener("adminTokenChanged", handleStorageChange as EventListener);

    // /az/ Hər 30 saniyədə bir yoxla (token yenilənməsi üçün)
    // /en/ Check every 30 seconds (for token refresh)
    const interval = setInterval(checkAdminAuth, 30000);

    return () => {
      clearInterval(interval);
      window.removeEventListener("storage", handleStorageChange as EventListener);
      window.removeEventListener("adminTokenChanged", handleStorageChange as EventListener);
    };
  }, []);

  return (
    <footer className="bg-gray-900 text-white py-8 mt-16">
      <div className="container mx-auto px-4">
        <div className={`grid grid-cols-1 gap-8 ${isAdmin ? "md:grid-cols-3" : "md:grid-cols-2"}`}>
          <div>
            <h3 className="text-xl font-bold mb-4">Saglamdad.az</h3>
            <p className="text-gray-400">
              {footerDescription}
            </p>
          </div>
          <div>
            <h4 className="font-semibold mb-4">Səhifələr</h4>
            <ul className="space-y-2 text-gray-400">
              <li>
                <Link href="/" className="hover:text-white transition-colors">
                  Ana Səhifə
                </Link>
              </li>
              <li>
                <Link
                  href="/about"
                  className="hover:text-white transition-colors"
                >
                  Haqqımızda
                </Link>
              </li>
              <li>
                <Link
                  href="/contact"
                  className="hover:text-white transition-colors"
                >
                  Əlaqə
                </Link>
              </li>
            </ul>
          </div>
          {/* /az/ Admin bölməsi yalnız admin login olanda görünür */}
          {/* /en/ Admin section only visible when admin is logged in */}
          {isAdmin && (
            <div>
              <h4 className="font-semibold mb-4">Admin</h4>
              <Link
                href="/admin"
                className="text-gray-400 hover:text-white transition-colors"
              >
                Admin Paneli
              </Link>
            </div>
          )}
        </div>
        <div className="border-t border-gray-800 mt-8 pt-8 text-center text-gray-400">
          <p>&copy; {new Date().getFullYear()} Saglamdad.az. Bütün hüquqlar qorunur.</p>
        </div>
      </div>
    </footer>
  );
}

