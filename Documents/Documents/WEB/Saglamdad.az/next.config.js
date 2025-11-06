/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  images: {
    domains: ['localhost'],
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**',
      },
      {
        protocol: 'http',
        hostname: 'localhost',
      },
    ],
  },
  // /az/ Vercel üçün 404 xətalarını həll etmək
  // /en/ Fix 404 errors for Vercel
  async rewrites() {
    return [];
  },
  // /az/ Trailing slash konfiqurasiyası
  // /en/ Trailing slash configuration
  trailingSlash: false,
  // /az/ Next.js 14-də api bodyParser artıq lazım deyil, App Router avtomatik idarə edir
  // /en/ In Next.js 14, api bodyParser is no longer needed, App Router handles it automatically
}

module.exports = nextConfig

