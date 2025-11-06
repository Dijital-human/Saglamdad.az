/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  images: {
    domains: ['localhost'],
  },
  // /az/ File upload üçün konfiqurasiya
  // /en/ Configuration for file upload
  api: {
    bodyParser: {
      sizeLimit: '10mb',
    },
  },
}

module.exports = nextConfig

