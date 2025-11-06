// Social Media API Route
// /az/ Sosial media API route-u
// /en/ Social media API route

import { NextRequest, NextResponse } from "next/server";
import { getSocialMedia, saveSocialMedia } from "@/lib/db";
import { verifyToken } from "@/lib/auth";

// /az/ Sosial media linklərini gətirir
// /en/ Get social media links
export async function GET() {
  try {
    const socialMedia = await getSocialMedia();
    return NextResponse.json(socialMedia);
  } catch (error) {
    return NextResponse.json(
      { error: "Sosial media məlumatları gətirilə bilmədi / Failed to fetch social media" },
      { status: 500 }
    );
  }
}

// /az/ Sosial media linklərini yeniləyir (admin tələb olunur)
// /en/ Update social media links (admin required)
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

    const socialMedia = await request.json();
    await saveSocialMedia(socialMedia);
    return NextResponse.json({ success: true });
  } catch (error) {
    return NextResponse.json(
      { error: "Sosial media məlumatları saxlanıla bilmədi / Failed to save social media" },
      { status: 500 }
    );
  }
}

