// Hero Section API Route
// /az/ Hero section API route-u
// /en/ Hero section API route

import { NextRequest, NextResponse } from "next/server";
import { getHeroSection, saveHeroSection } from "@/lib/db";
import { verifyToken } from "@/lib/auth";

// /az/ Hero section məlumatlarını gətirir
// /en/ Get hero section data
export async function GET() {
  try {
    const heroSection = await getHeroSection();
    return NextResponse.json(heroSection);
  } catch (error) {
    return NextResponse.json(
      { error: "Hero section məlumatları gətirilə bilmədi / Failed to fetch hero section" },
      { status: 500 }
    );
  }
}

// /az/ Hero section məlumatlarını yeniləyir (admin tələb olunur)
// /en/ Update hero section data (admin required)
export async function POST(request: NextRequest) {
  try {
    // Auth check
    const authHeader = request.headers.get("authorization");
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }
    const token = authHeader.substring(7);
    if (!verifyToken(token)) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const heroSection = await request.json();
    await saveHeroSection(heroSection);
    return NextResponse.json({ success: true });
  } catch (error) {
    return NextResponse.json(
      { error: "Hero section məlumatları saxlanıla bilmədi / Failed to save hero section" },
      { status: 500 }
    );
  }
}

