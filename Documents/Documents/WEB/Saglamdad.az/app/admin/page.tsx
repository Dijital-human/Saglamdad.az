"use client";

// Admin Page Component
// /az/ Admin səhifəsi komponenti - autentifikasiya və admin paneli
// /en/ Admin page component - authentication and admin panel

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import AdminLogin from "@/components/AdminLogin";
import AdminDashboard from "@/components/AdminDashboard";

export default function AdminPage() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [loading, setLoading] = useState(true);
  const router = useRouter();

  useEffect(() => {
    checkAuth();
  }, []);

  const checkAuth = async () => {
    const token = localStorage.getItem("adminToken");
    if (token) {
      try {
        const res = await fetch("/api/auth/verify", {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        if (res.ok) {
          setIsAuthenticated(true);
        } else {
          localStorage.removeItem("adminToken");
        }
      } catch {
        localStorage.removeItem("adminToken");
      }
    }
    setLoading(false);
  };

  const handleLogin = (token: string) => {
    localStorage.setItem("adminToken", token);
    setIsAuthenticated(true);
    // /az/ Custom event dispatch et (Footer-in yenilənməsi üçün)
    // /en/ Dispatch custom event (for Footer refresh)
    if (typeof window !== "undefined") {
      window.dispatchEvent(new CustomEvent("adminTokenChanged", { detail: { type: "adminToken" } }));
    }
  };

  const handleLogout = () => {
    localStorage.removeItem("adminToken");
    setIsAuthenticated(false);
    // /az/ Custom event dispatch et (Footer-in yenilənməsi üçün)
    // /en/ Dispatch custom event (for Footer refresh)
    if (typeof window !== "undefined") {
      window.dispatchEvent(new CustomEvent("adminTokenChanged", { detail: { type: "adminToken" } }));
    }
    router.push("/");
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {isAuthenticated ? (
        <AdminDashboard onLogout={handleLogout} />
      ) : (
        <AdminLogin onLogin={handleLogin} />
      )}
    </div>
  );
}

