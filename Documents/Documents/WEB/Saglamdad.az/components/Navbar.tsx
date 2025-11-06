"use client";

// Navigation Bar Component
// /az/ Naviqasiya çubuğu komponenti - responsiv menyu
// /en/ Navigation bar component - responsive menu

import { useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { motion, AnimatePresence } from "framer-motion";
import { Menu, X } from "lucide-react";

export default function Navbar() {
  const [isOpen, setIsOpen] = useState(false);
  const pathname = usePathname();

  const navItems = [
    { href: "/", label: "Ana Səhifə" },
    { href: "/about", label: "Haqqımızda" },
    { href: "/contact", label: "Əlaqə" },
  ];

  return (
    <nav className="bg-white shadow-md sticky top-0 z-50">
      <div className="container mx-auto px-4">
        <div className="flex justify-between items-center h-16">
          <Link href="/" className="text-2xl font-bold text-primary-600">
            Saglamdad.az
          </Link>

          {/* Desktop Navigation */}
          <div className="hidden md:flex space-x-8">
            {navItems.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                className={`relative font-medium transition-colors ${
                  pathname === item.href
                    ? "text-primary-600"
                    : "text-gray-700 hover:text-primary-600"
                }`}
              >
                {item.label}
                {pathname === item.href && (
                  <motion.div
                    layoutId="navbar-indicator"
                    className="absolute -bottom-1 left-0 right-0 h-0.5 bg-primary-600"
                    initial={false}
                  />
                )}
              </Link>
            ))}
          </div>

          {/* Mobile Menu Button */}
          <button
            className="md:hidden text-gray-700"
            onClick={() => setIsOpen(!isOpen)}
            aria-label="Toggle menu"
          >
            {isOpen ? <X size={24} /> : <Menu size={24} />}
          </button>
        </div>

        {/* Mobile Navigation */}
        <AnimatePresence>
          {isOpen && (
            <motion.div
              initial={{ opacity: 0, height: 0 }}
              animate={{ opacity: 1, height: "auto" }}
              exit={{ opacity: 0, height: 0 }}
              className="md:hidden overflow-hidden"
            >
              <div className="py-4 space-y-2">
                {navItems.map((item) => (
                  <Link
                    key={item.href}
                    href={item.href}
                    onClick={() => setIsOpen(false)}
                    className={`block px-4 py-2 rounded-md transition-colors ${
                      pathname === item.href
                        ? "bg-primary-100 text-primary-600"
                        : "text-gray-700 hover:bg-gray-100"
                    }`}
                  >
                    {item.label}
                  </Link>
                ))}
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </nav>
  );
}

