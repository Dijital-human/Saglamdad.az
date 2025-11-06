// Banners API Route
// /az/ Banner-lər API route-u
// /en/ Banners API route

import { NextRequest, NextResponse } from "next/server";
import { getBanners, saveBanners } from "@/lib/db";
import { verifyToken } from "@/lib/auth";

// /az/ Bütün banner-ləri gətirir
// /en/ Get all banners
export async function GET() {
  try {
    const banners = await getBanners();
    return NextResponse.json(banners);
  } catch (error) {
    return NextResponse.json(
      { error: "Banner-lər gətirilə bilmədi / Failed to fetch banners" },
      { status: 500 }
    );
  }
}

// /az/ Banner-ləri saxlayır (admin tələb olunur)
// /en/ Save banners (admin required)
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

    const banners = await request.json();
    await saveBanners(banners);
    return NextResponse.json({ success: true });
  } catch (error) {
    return NextResponse.json(
      { error: "Banner-lər saxlanıla bilmədi / Failed to save banners" },
      { status: 500 }
    );
  }
}


