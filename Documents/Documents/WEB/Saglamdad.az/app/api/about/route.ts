// About API Route
// /az/ Haqqında API route-u
// /en/ About API route

import { NextRequest, NextResponse } from "next/server";
import { getAbout, saveAbout } from "@/lib/db";
import { verifyToken } from "@/lib/auth";

// /az/ Haqqında məzmununu gətirir
// /en/ Get about content
export async function GET() {
  try {
    const about = await getAbout();
    return NextResponse.json(about);
  } catch (error) {
    return NextResponse.json(
      { error: "Haqqında məzmunu gətirilə bilmədi / Failed to fetch about content" },
      { status: 500 }
    );
  }
}

// /az/ Haqqında məzmununu yeniləyir (admin tələb olunur)
// /en/ Update about content (admin required)
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

    const about = await request.json();
    await saveAbout(about);
    return NextResponse.json({ success: true });
  } catch (error) {
    return NextResponse.json(
      { error: "Haqqında məzmunu saxlanıla bilmədi / Failed to save about content" },
      { status: 500 }
    );
  }
}

