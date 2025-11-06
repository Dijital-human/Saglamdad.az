// Site Settings API Route
// /az/ Site settings API route-u
// /en/ Site settings API route

import { NextRequest, NextResponse } from "next/server";
import { getSiteSettings, saveSiteSettings } from "@/lib/db";
import { verifyToken } from "@/lib/auth";

// /az/ Site settings gətirir
// /en/ Get site settings
export async function GET() {
  try {
    const settings = await getSiteSettings();
    return NextResponse.json(settings);
  } catch (error) {
    return NextResponse.json(
      { error: "Site settings gətirilə bilmədi / Failed to fetch site settings" },
      { status: 500 }
    );
  }
}

// /az/ Site settings saxlayır (admin tələb olunur)
// /en/ Save site settings (admin required)
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

    const settings = await request.json();
    await saveSiteSettings(settings);
    return NextResponse.json({ success: true });
  } catch (error) {
    return NextResponse.json(
      { error: "Site settings saxlanıla bilmədi / Failed to save site settings" },
      { status: 500 }
    );
  }
}

