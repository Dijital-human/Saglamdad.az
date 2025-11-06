// Root Layout Component
// /az/ Əsas layout komponenti - saytın strukturu
// /en/ Root layout component - site structure

import type { Metadata } from "next";
import { Inter } from "next/font/google";
import Script from "next/script";
import "./globals.css";
import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";

const inter = Inter({ subsets: ["latin", "cyrillic"] });

export const metadata: Metadata = {
  title: "Saglamdad.az - Təbii Bal və Arı Məhsulları",
  description: "Təbii bal və arı məhsullarının satışı. Premium keyfiyyət, təbii məhsullar. Səhhətiniz üçün ən yaxşısı.",
  keywords: "bal, arı məhsulları, təbii bal, saglamdad, azərbaycan, honey, bee products, natural honey",
  authors: [{ name: "Saglamdad.az" }],
  openGraph: {
    title: "Saglamdad.az - Təbii Bal və Arı Məhsulları",
    description: "Premium keyfiyyət, təbii bal və arı məhsulları. Səhhətiniz üçün ən yaxşısı.",
    url: "https://saglamdad.az",
    siteName: "Saglamdad.az",
    type: "website",
    locale: "az_AZ",
  },
  twitter: {
    card: "summary_large_image",
    title: "Saglamdad.az - Təbii Bal və Arı Məhsulları",
    description: "Premium keyfiyyət, təbii bal və arı məhsulları.",
  },
  robots: {
    index: true,
    follow: true,
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="az">
      <body className={inter.className}>
        {/* /az/ Google AdSense Script - bütün səhifələr üçün */}
        {/* /en/ Google AdSense Script - for all pages */}
        <Script
          async
          src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-8163629613496922"
          crossOrigin="anonymous"
          strategy="afterInteractive"
        />
        <Navbar />
        <main className="min-h-screen">
          {children}
        </main>
        <Footer />
      </body>
    </html>
  );
}

